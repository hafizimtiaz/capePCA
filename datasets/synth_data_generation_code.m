%% code for generating synthetic data samples from a pre-determined mean and variance

clear all;clc;close all
d = 100;                                        % sample dimension
n = 1000;                                       % number of samples
k = 20;                                         % real rank
X_mean = zeros(d,1);                            % mean of the samples
A = diag([linspace(10,1,k) 0.5*rand(1,d-k)]);   % covariance matrix for generating samples

X = my_rand_data_generator(X_mean,A,n);

max_nrm = max(sqrt(diag(X'*X)));

diag_mat = diag((1/max_nrm)*ones(n,1));

X = X*diag_mat;

save('synth_d_100_n_1000','X','A','X_mean','k','n','d')