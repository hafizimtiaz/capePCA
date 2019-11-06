%% code for generating synthetic data samples from a pre-determined mean and variance

clear all;clc;close all
load('/Users/hafizimtiaz/OneDrive/Backup from Dropbox/Rutgers Research/Covtype Database/covtype.mat');

samples = samples';
[D, Ntot] = size(samples);                                          % sample dimension and sample number
N = 60000;
K = 20;                                                         % real rank
ids = randsample(Ntot, N);
samples = samples(:, ids);
labels = labels(ids);

X_mean = mean(samples, 2);                                       % mean of the samples
X = samples - X_mean * ones(1,N);
A = (1/N) * (X * X');                                       % sample covariance matrix

nrm = zeros(N,1);

for n = 1:N
    nrm(n) = norm(X(:,n));
end
max_nrm = max(nrm);
for n = 1:N
    X(:,n) = X(:,n) / max_nrm;
end

save('covtype_d_54_n_60000','X','A','samples', 'K', 'N', 'D', 'labels')