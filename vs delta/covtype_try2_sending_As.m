clear;clc;close all

%% load data and set parameters

load('../datasets/covtype_d_54_n_60000.mat')
epsilon = 0.5;
delta_all = [1e-4 5e-4 1e-3 5e-3 1e-2 5e-2];
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
en_pool_dp = zeros(nensemble, length(delta_all));

en_dist_hafiz_ndp = zeros(nensemble, length(delta_all));
en_dist_hafiz_dp = zeros(nensemble, length(delta_all));
en_dist_hafiz_dp_ver2 = zeros(nensemble, length(delta_all));
en_dist_djica_ndp = zeros(nensemble, length(delta_all));
en_dist_djica_dp = zeros(nensemble, length(delta_all));

en_loc_hafiz_ndp = zeros(nensemble, length(delta_all));
en_loc_hafiz_dp = zeros(nensemble, length(delta_all));
en_loc_hafiz_dp_ver2 = zeros(nensemble, length(delta_all));
en_loc_djica_ndp = zeros(nensemble, length(delta_all));
en_loc_djica_dp = zeros(nensemble, length(delta_all));

for itr = 1:nensemble
    for del_id = 1:length(delta_all)
        delta = delta_all(del_id);

        % pooled dp
        Ahat = my_AG(sample_cov, N, epsilon, delta);
        [U, Sigma, ~] = svd(Ahat);
        U_pool_dp = U(:, 1:K);
        en_pool_dp(itr, del_id) = trace(U_pool_dp' * A * U_pool_dp);

        % Hafiz dPCA
        [U_dist_hafiz_ndp, U_loc_hafiz_ndp] = my_dPCA_hafiz (X_sites, K, R, 0, 0);
        [U_dist_hafiz_dp, U_loc_hafiz_dp] = my_dPCA_hafiz (X_sites, K, R, epsilon, delta);
        [U_dist_hafiz_dp_ver2, U_loc_hafiz_dp_ver2] = my_dPCA_hafiz_ver2 (X_sites, K, R, epsilon, delta);

        en_dist_hafiz_ndp(itr, del_id) = trace(U_dist_hafiz_ndp' * A * U_dist_hafiz_ndp);
        en_dist_hafiz_dp(itr, del_id) = trace(U_dist_hafiz_dp' * A * U_dist_hafiz_dp);
        en_dist_hafiz_dp_ver2(itr, del_id) = trace(U_dist_hafiz_dp_ver2' * A * U_dist_hafiz_dp_ver2);
        
        en_loc_hafiz_ndp(itr, del_id) = trace(U_loc_hafiz_ndp' * A * U_loc_hafiz_ndp);
        en_loc_hafiz_dp(itr, del_id) = trace(U_loc_hafiz_dp' * A * U_loc_hafiz_dp);
%         en_loc_hafiz_dp_ver2(itr, eps_id) = trace(U_loc_hafiz_dp_ver2' * A * U_loc_hafiz_dp_ver2);
    end
end
save('covtype_vs_delta_ver2', 'delta_all', 'epsilon', 'site_members', 'en_pool_ndp', 'en_pool_dp', 'en_dist_hafiz_ndp', 'en_dist_hafiz_dp', 'en_dist_hafiz_dp_ver2', 'en_dist_djica_ndp', 'en_dist_djica_dp', 'en_loc_hafiz_ndp', 'en_loc_hafiz_dp', 'en_loc_djica_ndp', 'en_loc_djica_dp')
%% plot
FS = 24;

en_pool_dp_mean = mean(en_pool_dp) / en_pool_ndp;

en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp) / en_pool_ndp;
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2) / en_pool_ndp;

en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp) / en_pool_ndp;

semilogx(delta_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_hafiz_ndp_mean,'rs--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_dist_hafiz_dp_mean,'bo--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_dist_hafiz_dp_ver2_mean,'ro--','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_hafiz_ndp_mean,'r*--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_loc_hafiz_dp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([delta_all(1)/10 delta_all(end)*10 -0.05 1.05])
xticks(delta_all(1:2:end))
xticklabels({'0.0001', '0.001', '0.01'})

set(gca,'FontSize',FS-4,'FontWeight','bold')
xlabel('Privacy parameter (\delta)','FontSize',FS,'FontWeight','bold');
ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
title('Covtype data (\epsilon=0.5, S = 10, N_s = 0.5k)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP','DistH nDP', 'DistH DP', 'LocH nDP', 'LocH DP', 'Location','NE')
legend('q_{pooled} / q_o', 'q_{DPdisPCA} / q_o', 'q_{full} / q_o', 'q_{local} / q_o', 'Location','NW')