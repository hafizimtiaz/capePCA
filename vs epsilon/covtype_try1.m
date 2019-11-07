clear;clc;close all

%% load data and set parameters

load('../datasets/covtype_d_54_n_60000.mat')
epsilon_all = [1e-3 5e-3 1e-2 5e-2 1e-1 5e-1 1 5 10];
delta = 0.01;
nensemble = 10;
S = 10;
K = 10;
R = 2 * K;

%% pick up some data samples
Xorg = X;
Ntot = N;
N = 5e3;
ids = randsample(Ntot, N);
X = Xorg(:, ids);
X_mean = mean(X, 2);
X = X - X_mean * ones(1, N);

%% compute pooled non-dp performance
sample_cov = (1/N) * (X * X');
[U, Sigma, ~] = svd(sample_cov);
U_pool_ndp = U(:, 1:K);
en_pool_ndp = trace(U_pool_ndp' * A * U_pool_ndp);

%% make data distributed

Ns = N / S;
st_id = 1 + ([1:S] - 1) * Ns;
en_id = [1:S] * Ns;
site_members = zeros(S, Ns);
X_sites = cell(S);
for s = 1:S
    site_members(s,:) = st_id(s) : en_id(s);
    X_sites{s} = X(:, st_id(s) : en_id(s));
end


%% vary epsilon and compute performance
en_pool_dp = zeros(nensemble, length(epsilon_all));

en_dist_hafiz_ndp = zeros(nensemble, length(epsilon_all));
en_dist_hafiz_dp = zeros(nensemble, length(epsilon_all));
en_dist_djica_ndp = zeros(nensemble, length(epsilon_all));
en_dist_djica_dp = zeros(nensemble, length(epsilon_all));

en_loc_hafiz_ndp = zeros(nensemble, length(epsilon_all));
en_loc_hafiz_dp = zeros(nensemble, length(epsilon_all));
en_loc_djica_ndp = zeros(nensemble, length(epsilon_all));
en_loc_djica_dp = zeros(nensemble, length(epsilon_all));

for itr = 1:nensemble
    for eps_id = 1:length(epsilon_all)
        epsilon = epsilon_all(eps_id);

        % pooled dp
        Ahat = my_AG(sample_cov, N, epsilon, delta);
        [U, Sigma, ~] = svd(Ahat);
        U_pool_dp = U(:, 1:K);
        en_pool_dp(itr, eps_id) = trace(U_pool_dp' * A * U_pool_dp);

        % Hafiz dPCA
        [U_dist_hafiz_ndp, U_loc_hafiz_ndp] = my_dPCA_hafiz (X_sites, K, R, 0, 0);
        [U_dist_hafiz_dp, U_loc_hafiz_dp] = my_dPCA_hafiz (X_sites, K, R, epsilon, delta);

        en_dist_hafiz_ndp(itr, eps_id) = trace(U_dist_hafiz_ndp' * A * U_dist_hafiz_ndp);
        en_dist_hafiz_dp(itr, eps_id) = trace(U_dist_hafiz_dp' * A * U_dist_hafiz_dp);
        en_loc_hafiz_ndp(itr, eps_id) = trace(U_loc_hafiz_ndp' * A * U_loc_hafiz_ndp);
        en_loc_hafiz_dp(itr, eps_id) = trace(U_loc_hafiz_dp' * A * U_loc_hafiz_dp);

        % djICA dPCA
        [U_dist_djica_ndp, U_loc_djica_ndp] = my_dPCA_djica (X_sites, K, R, 0, 0);
        [U_dist_djica_dp, U_loc_djica_dp] = my_dPCA_djica (X_sites, K, R, epsilon, delta);

        en_dist_djica_ndp(itr, eps_id) = trace(U_dist_hafiz_ndp' * A * U_dist_hafiz_ndp);
        en_dist_djica_dp(itr, eps_id) = trace(U_dist_hafiz_dp' * A * U_dist_hafiz_dp);
        en_loc_djica_ndp(itr, eps_id) = trace(U_loc_djica_ndp' * A * U_loc_djica_ndp);
        en_loc_djica_dp(itr, eps_id) = trace(U_loc_djica_dp' * A * U_loc_djica_dp);

    end
end
save('covtype_vs_epsilon', 'epsilon_all', 'delta', 'site_members', 'en_pool_ndp', 'en_pool_dp', 'en_dist_hafiz_ndp', 'en_dist_hafiz_dp', 'en_dist_djica_ndp', 'en_dist_djica_dp', 'en_loc_hafiz_ndp', 'en_loc_hafiz_dp', 'en_loc_djica_ndp', 'en_loc_djica_dp')