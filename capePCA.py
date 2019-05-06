#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 12 10:55:39 2017

@author: hafizimtiaz
"""
import numpy as np
import matplotlib.pyplot as plt

#%% helper functions

# function to compute the second-moment matrix of local data
def localPCA(data, epsilon = 0, delta = 0):
    N = data.shape[1]
    C = (1/N) * np.dot(data, data.T)
    if not(epsilon == 0):
        C = dp_pca_ag ( C, N, epsilon, delta )
    return C

# function to compute the global second-moment matrix and PCA subspace
def globalPCA(Cs, K):
    C = 0
    S = len(Cs)
    for s in range(S):
        C += Cs[s]
    C = (1/S) * C
    U, S, V = np.linalg.svd(C)
    Uk = U[:, :K]
    return Uk

# function to compute differentially-private second-moment matrix
def dp_pca_ag ( A, N, epsilon = 1.0, delta = 0.1 ):
    sigma = ( 1.0 / ( N * epsilon ) ) * np.sqrt( 2.0 * np.log( 1.25 / delta ) )
    m = A.shape[0]
    temp = np.random.normal( 0, sigma, (m, m))
    temp2 = np.triu( temp )
    temp3 = temp2.transpose()
    temp4 = np.tril(temp3, -1)
    E = temp2 + temp4
    hat_A = A + E
    return hat_A

    
#%% generate data
D = 100
N = 10000
num_sites = 10
num_samples_site = N // num_sites
K = 20
mu = np.zeros([D,])
diag_entries = np.arange(D, 0, -1)
diag_entries[K:] = 0
true_cov = np.diag(diag_entries)
X = np.random.multivariate_normal(mu, true_cov, N).T

## normalizing the data
norms = np.sqrt(np.diag(np.dot(X.T, X)))
max_norm = norms.max()
diag_matrix = (1/max_norm) * np.diag(np.ones([N,]))
X = np.dot(X, diag_matrix)

## compute the captured energy in pooled case
K = 5
sample_cov = (1/N) * np.dot(X, X.T)
U, S, V = np.linalg.svd(sample_cov)
Uk = U[:, :K]
en_pool = np.trace(np.dot(np.dot(Uk.T, true_cov), Uk)) # this is the baseline


#%% Compare PCA methods - capePCA and conventional DP-dPCA
epsilon_all = [1e-3, 5e-3, 1e-2, 5e-2, 1e-1, 5e-1, 1, 5, 10] 
delta = 0.01
num_ensemble = 50
en_cape = np.zeros([num_ensemble, len(epsilon_all)])
en_conv = np.zeros([num_ensemble, len(epsilon_all)])
for itr in range(num_ensemble):
    for eps_id in range(len(epsilon_all)):
        epsilon = epsilon_all[eps_id]
        
        # compute the captured energy using CAPE
        sample_cov = (1/N) * np.dot(X, X.T)
        sample_cov = dp_pca_ag ( sample_cov, N, epsilon, delta )
        U, S, V = np.linalg.svd(sample_cov)
        Uk = U[:, :K]
        en_cape[itr, eps_id] = np.trace(np.dot(np.dot(Uk.T, true_cov), Uk))
        
        # compute the captured energy using CONV
        st_id = 0
        en_id = num_samples_site
        Cs = dict()
        for s in range(num_sites):
            Xs = X[:, st_id : en_id]
            Cs[s] = localPCA(Xs, epsilon/num_sites, delta/num_sites)
            st_id += num_samples_site
            en_id += num_samples_site
        
        Udk = globalPCA(Cs, K)
        en_conv[itr, eps_id] = np.trace(np.dot(np.dot(Udk.T, true_cov), Udk))

# for plotting
en_cape_avg = np.mean(en_cape, axis = 0)
en_conv_avg = np.mean(en_conv, axis = 0)
plt.semilogx(epsilon_all, en_pool * np.ones([len(epsilon_all),]), \
             epsilon_all, en_cape_avg, \
             epsilon_all, en_conv_avg)
plt.legend(['Non-private pooled', 'CAPE', 'CONV'], loc = 'upper left')