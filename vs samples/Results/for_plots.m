clear;clc;close all

FS = 36;

%% for synth data
load synth_vs_samples.mat
subplot(131)

en_pool_ndp_mean = mean(en_pool_ndp);
en_pool_dp_mean = mean(en_pool_dp) ./ en_pool_ndp_mean;
en_dist_hafiz_ndp_mean = mean(en_dist_hafiz_ndp) ./ en_pool_ndp_mean;
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp) ./ en_pool_ndp_mean;
en_loc_hafiz_ndp_mean = mean(en_loc_hafiz_ndp) ./ en_pool_ndp_mean;
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp) ./ en_pool_ndp_mean;

semilogx(N_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_dist_hafiz_ndp_mean,'rs--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_dist_hafiz_dp_mean,'bo--','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_loc_hafiz_ndp_mean,'r*--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_loc_hafiz_dp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on

axis([N_all(1)/10 N_all(end)*10 -0.05 1.05])
xticks(N_all(1:3:end))
xticklabels({'0.1', '1', '4'})

set(gca,'FontSize',FS-4,'FontWeight','bold')
xlabel('Local sample size in 1000 (N_s)','FontSize',FS,'FontWeight','bold');
ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
title('Synthetic data (\epsilon = 0.5, \delta=0.01, S = 10)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP','DistH nDP', 'DistH DP', 'LocH nDP', 'LocH DP', 'Location','NE')
legend('Pooled DP', 'DPdisPCA', 'Local DP', 'Location','NW')

% subplot(234)
% en_pool_dp_mean = mean(en_pool_dp) ./ en_pool_ndp_mean;
% en_dist_djica_ndp_mean = mean(en_dist_djica_ndp) ./ en_pool_ndp_mean;
% en_dist_djica_dp_mean = mean(en_dist_djica_dp) ./ en_pool_ndp_mean;
% en_loc_djica_ndp_mean = mean(en_loc_djica_ndp) ./ en_pool_ndp_mean;
% en_loc_djica_dp_mean = mean(en_loc_djica_dp) ./ en_pool_ndp_mean;
% 
% semilogx(N_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_dist_djica_ndp_mean,'rs-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_dist_djica_dp_mean,'bo-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_loc_djica_ndp_mean,'r*-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_loc_djica_dp_mean,'b*-.','LineWidth',3,'MarkerSize',10); hold on
% 
% axis([N_all(1)/10 N_all(end)*10 -0.05 1.05])
% xticks(N_all(1:3:end))
% xticklabels({'0.1', '1', '4'})
% 
% set(gca,'FontSize',FS-4,'FontWeight','bold')
% xlabel('Local sample size in 1000 (N_s)','FontSize',FS,'FontWeight','bold');
% ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
% title('Synthetic data (\epsilon = 0.5, \delta=0.01, S = 10)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP', 'DistD nDP', 'DistD DP', 'LocD nDP', 'LocD DP', 'Location','NE')

%% for MNIST data
load mnist_vs_samples.mat
subplot(132)

en_pool_ndp_mean = mean(en_pool_ndp);
en_pool_dp_mean = mean(en_pool_dp) ./ en_pool_ndp_mean;
en_dist_hafiz_ndp_mean = mean(en_dist_hafiz_ndp) ./ en_pool_ndp_mean;
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp) ./ en_pool_ndp_mean;
en_loc_hafiz_ndp_mean = mean(en_loc_hafiz_ndp) ./ en_pool_ndp_mean;
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp) ./ en_pool_ndp_mean;

semilogx(N_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_dist_hafiz_ndp_mean,'rs--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_dist_hafiz_dp_mean,'bo--','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_loc_hafiz_ndp_mean,'r*--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_loc_hafiz_dp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([N_all(1)/10 N_all(end)*10 -0.05 1.05])
xticks(N_all(1:3:end))
xticklabels({'0.1', '1', '4'})

set(gca,'FontSize',FS-4,'FontWeight','bold')
xlabel('Local sample size in 1000 (N_s)','FontSize',FS,'FontWeight','bold');
ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
title('MNIST data (\epsilon = 1, \delta=0.01, S = 10)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP','DistH nDP', 'DistH DP', 'LocH nDP', 'LocH DP', 'Location','NE')
legend('Pooled DP', 'DPdisPCA', 'Local DP', 'Location','NW')

% subplot(235)
% en_pool_dp_mean = mean(en_pool_dp) ./ en_pool_ndp_mean;
% en_dist_djica_ndp_mean = mean(en_dist_djica_ndp) ./ en_pool_ndp_mean;
% en_dist_djica_dp_mean = mean(en_dist_djica_dp) ./ en_pool_ndp_mean;
% en_loc_djica_ndp_mean = mean(en_loc_djica_ndp) ./ en_pool_ndp_mean;
% en_loc_djica_dp_mean = mean(en_loc_djica_dp) ./ en_pool_ndp_mean;
% 
% semilogx(N_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_dist_djica_ndp_mean,'rs-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_dist_djica_dp_mean,'bo-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_loc_djica_ndp_mean,'r*-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_loc_djica_dp_mean,'b*-.','LineWidth',3,'MarkerSize',10); hold on
% 
% axis([N_all(1)/10 N_all(end)*10 -0.05 1.05])
% xticks(N_all(1:3:end))
% xticklabels({'0.1', '1', '4'})
% 
% set(gca,'FontSize',FS-4,'FontWeight','bold')
% xlabel('Local sample size in 1000 (N_s)','FontSize',FS,'FontWeight','bold');
% ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
% title('MNIST data (\epsilon = 1, \delta=0.01, S = 10)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP', 'DistD nDP', 'DistD DP', 'LocD nDP', 'LocD DP', 'Location','NE')

%% for covtype data
load covtype_vs_samples.mat
subplot(133)

en_pool_ndp_mean = mean(en_pool_ndp);
en_pool_dp_mean = mean(en_pool_dp) ./ en_pool_ndp_mean;
en_dist_hafiz_ndp_mean = mean(en_dist_hafiz_ndp) ./ en_pool_ndp_mean;
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp) ./ en_pool_ndp_mean;
en_loc_hafiz_ndp_mean = mean(en_loc_hafiz_ndp) ./ en_pool_ndp_mean;
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp) ./ en_pool_ndp_mean;

semilogx(N_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_dist_hafiz_ndp_mean,'rs--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_dist_hafiz_dp_mean,'bo--','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_loc_hafiz_ndp_mean,'r*--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_loc_hafiz_dp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([N_all(1)/10 N_all(end)*10 -0.05 1.05])
xticks(N_all(1:3:end))
xticklabels({'0.1', '1', '4'})

set(gca,'FontSize',FS-4,'FontWeight','bold')
xlabel('Local sample size in 1000 (N_s)','FontSize',FS,'FontWeight','bold');
ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
title('COVTYPE data (\epsilon = 0.1, \delta=0.01, S = 10)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP','DistH nDP', 'DistH DP', 'LocH nDP', 'LocH DP', 'Location','NE')
legend('Pooled DP', 'DPdisPCA', 'Local DP', 'Location','NW')

% subplot(236)
% en_pool_dp_mean = mean(en_pool_dp) ./ en_pool_ndp_mean;
% en_dist_djica_ndp_mean = mean(en_dist_djica_ndp) ./ en_pool_ndp_mean;
% en_dist_djica_dp_mean = mean(en_dist_djica_dp) ./ en_pool_ndp_mean;
% en_loc_djica_ndp_mean = mean(en_loc_djica_ndp) ./ en_pool_ndp_mean;
% en_loc_djica_dp_mean = mean(en_loc_djica_dp) ./ en_pool_ndp_mean;
% 
% semilogx(N_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_dist_djica_ndp_mean,'rs-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_dist_djica_dp_mean,'bo-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_loc_djica_ndp_mean,'r*-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(N_all, en_loc_djica_dp_mean,'b*-.','LineWidth',3,'MarkerSize',10); hold on
% 
% axis([N_all(1)/10 N_all(end)*10 -0.05 1.05])
% xticks(N_all(1:3:end))
% xticklabels({'0.1', '1', '4'})
% 
% set(gca,'FontSize',FS-4,'FontWeight','bold')
% xlabel('Local sample size in 1000 (N_s)','FontSize',FS,'FontWeight','bold');
% ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
% title('COVTYPE data (\epsilon = 0.1, \delta=0.01, S = 10)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP', 'DistD nDP', 'DistD DP', 'LocD nDP', 'LocD DP', 'Location','NE')