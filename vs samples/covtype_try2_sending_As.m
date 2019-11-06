clear;clc;close all

%% load data and set parameters

load('/Users/hafizimtiaz/OneDrive/Backup from Dropbox/Rutgers Research/Implementation of dPCA/New Simulations October 2017/Database/covtype_d_54_n_60000.mat')
Xorg = X;
N_all = [1 2 5 10 20 30 40 50 60] * 1000;
[~, Ntot] = size(Xorg);
epsilon = 0.1;
delta = 0.01;
nensemble = 10;
S = 10;
K = 10;
R = 2 * K;

en_pool_dp = zeros(nensemble, length(N_all));
en_pool_ndp = zeros(nensemble, length(N_all));

en_dist_hafiz_ndp = zeros(nensemble, length(N_all));
en_dist_hafiz_dp = zeros(nensemble, length(N_all));
en_dist_hafiz_dp_ver2 = zeros(nensemble, length(N_all));
en_dist_djica_ndp = zeros(nensemble, length(N_all));
en_dist_djica_dp = zeros(nensemble, length(N_all));

en_loc_hafiz_ndp = zeros(nensemble, length(N_all));
en_loc_hafiz_dp = zeros(nensemble, length(N_all));
en_loc_djica_ndp = zeros(nensemble, length(N_all));
en_loc_djica_dp = zeros(nensemble, length(N_all));


for itr = 1:nensemble
    for n_id = 1:length(N_all)
        N = N_all(n_id);
        ids = randsample(Ntot, N);
        X = Xorg(:, ids);
        X_mean = mean(X, 2);
        X = X - X_mean * ones(1, N);
        
        
        %% compute pooled non-dp performance
        sample_cov = (1/N) * (X * X');
        [U, ~, ~] = svd(sample_cov);
        U_pool_ndp = U(:, 1:K);
        en_pool_ndp(itr, n_id) = trace(U_pool_ndp' * A * U_pool_ndp);

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

        % pooled dp
        Ahat = my_AG(sample_cov, N, epsilon, delta);
        [U, ~, ~] = svd(Ahat);
        U_pool_dp = U(:, 1:K);
        en_pool_dp(itr, n_id) = trace(U_pool_dp' * A * U_pool_dp);

        % Hafiz dPCA
        [U_dist_hafiz_ndp, U_loc_hafiz_ndp] = my_dPCA_hafiz (X_sites, K, R, 0, 0);
        [U_dist_hafiz_dp, U_loc_hafiz_dp] = my_dPCA_hafiz (X_sites, K, R, epsilon, delta);
        [U_dist_hafiz_dp_ver2, U_loc_hafiz_dp_ver2] = my_dPCA_hafiz_ver2 (X_sites, K, R, epsilon, delta);
        
        en_dist_hafiz_ndp(itr, n_id) = trace(U_dist_hafiz_ndp' * A * U_dist_hafiz_ndp);
        en_dist_hafiz_dp(itr, n_id) = trace(U_dist_hafiz_dp' * A * U_dist_hafiz_dp);
        en_dist_hafiz_dp_ver2(itr, n_id) = trace(U_dist_hafiz_dp_ver2' * A * U_dist_hafiz_dp_ver2);
        
        en_loc_hafiz_ndp(itr, n_id) = trace(U_loc_hafiz_ndp' * A * U_loc_hafiz_ndp);
        en_loc_hafiz_dp(itr, n_id) = trace(U_loc_hafiz_dp' * A * U_loc_hafiz_dp);

    end
end
save('covtype_vs_samples_ver2', 'N_all', 'epsilon', 'delta', 'en_pool_ndp', 'en_pool_dp', 'en_dist_hafiz_ndp', 'en_dist_hafiz_dp', 'en_dist_hafiz_dp_ver2', 'en_dist_djica_ndp', 'en_dist_djica_dp', 'en_loc_hafiz_ndp', 'en_loc_hafiz_dp', 'en_loc_djica_ndp', 'en_loc_djica_dp')