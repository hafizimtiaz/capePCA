clear;clc;close all

epsilon_all = [1e-3 5e-3 1e-2 5e-2 1e-1 5e-1 1 5 10];
delta = 0.01;
FS = 36;

%% for synth data
load synth_vs_epsilon.mat
subplot(131)

en_pool_dp_mean = mean(en_pool_dp) / en_pool_ndp;
en_dist_hafiz_ndp_mean = mean(en_dist_hafiz_ndp) / en_pool_ndp;
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp) / en_pool_ndp;
en_loc_hafiz_ndp_mean = mean(en_loc_hafiz_ndp) / en_pool_ndp;
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp) / en_pool_ndp;

semilogx(epsilon_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_hafiz_ndp_mean,'rs--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_dist_hafiz_dp_mean,'bo--','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_hafiz_ndp_mean,'r*--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_loc_hafiz_dp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([epsilon_all(1)/10 epsilon_all(end)*10 -0.05 1.05])
xticks(epsilon_all(1:2:end))
xticklabels({'0.001', '0.01', '0.1', '1.0', '10.0'})

set(gca,'FontSize',FS-4,'FontWeight','bold')
xlabel('Privacy parameter (\epsilon)','FontSize',FS,'FontWeight','bold');
ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
title('Synthetic data (\delta=0.01, S = 10, N_s = 1k)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP','DistH nDP', 'DistH DP', 'LocH nDP', 'LocH DP', 'Location','NE')
legend('Pooled DP', 'DPdisPCA', 'Local DP', 'Location','NW')

% subplot(234)
% en_pool_dp_mean = mean(en_pool_dp) / en_pool_ndp;
% en_dist_djica_ndp_mean = mean(en_dist_djica_ndp) / en_pool_ndp;
% en_dist_djica_dp_mean = mean(en_dist_djica_dp) / en_pool_ndp;
% en_loc_djica_ndp_mean = mean(en_loc_djica_ndp) / en_pool_ndp;
% en_loc_djica_dp_mean = mean(en_loc_djica_dp) / en_pool_ndp;
% 
% semilogx(epsilon_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_djica_ndp_mean,'rs-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_djica_dp_mean,'bo-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_djica_ndp_mean,'r*-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_djica_dp_mean,'b*-.','LineWidth',3,'MarkerSize',10); hold on
% 
% axis([epsilon_all(1)/10 epsilon_all(end)*10 -0.05 1.05])
% xticks(epsilon_all(1:2:end))
% xticklabels({'0.001', '0.01', '0.1', '1.0', '10.0'})
% 
% set(gca,'FontSize',FS-4,'FontWeight','bold')
% xlabel('Privacy parameter (\epsilon)','FontSize',FS,'FontWeight','bold');
% ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
% title('Synthetic data (\delta=0.01, S = 10, N_s = 1k)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP', 'DistD nDP', 'DistD DP', 'LocD nDP', 'LocD DP', 'Location','NE')

%% for MNIST data
load mnist_vs_epsilon.mat
subplot(132)

en_pool_dp_mean = mean(en_pool_dp) / en_pool_ndp;
en_dist_hafiz_ndp_mean = mean(en_dist_hafiz_ndp) / en_pool_ndp;
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp) / en_pool_ndp;
en_loc_hafiz_ndp_mean = mean(en_loc_hafiz_ndp) / en_pool_ndp;
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp) / en_pool_ndp;

semilogx(epsilon_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_hafiz_ndp_mean,'rs--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_dist_hafiz_dp_mean,'bo--','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_hafiz_ndp_mean,'r*--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_loc_hafiz_dp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([epsilon_all(1)/10 epsilon_all(end)*10 -0.05 1.05])
xticks(epsilon_all(1:2:end))
xticklabels({'0.001', '0.01', '0.1', '1.0', '10.0'})

set(gca,'FontSize',FS-4,'FontWeight','bold')
xlabel('Privacy parameter (\epsilon)','FontSize',FS,'FontWeight','bold');
ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
title('MNIST data (\delta=0.01, S = 10, N_s = 1k)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP','DistH nDP', 'DistH DP', 'LocH nDP', 'LocH DP', 'Location','NE')
legend('Pooled DP', 'DPdisPCA', 'Local DP', 'Location','NW')

% subplot(235)
% en_pool_dp_mean = mean(en_pool_dp) / en_pool_ndp;
% en_dist_djica_ndp_mean = mean(en_dist_djica_ndp) / en_pool_ndp;
% en_dist_djica_dp_mean = mean(en_dist_djica_dp) / en_pool_ndp;
% en_loc_djica_ndp_mean = mean(en_loc_djica_ndp) / en_pool_ndp;
% en_loc_djica_dp_mean = mean(en_loc_djica_dp) / en_pool_ndp;
% 
% semilogx(epsilon_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_djica_ndp_mean,'rs-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_djica_dp_mean,'bo-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_djica_ndp_mean,'r*-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_djica_dp_mean,'b*-.','LineWidth',3,'MarkerSize',10); hold on
% 
% axis([epsilon_all(1)/10 epsilon_all(end)*10 -0.05 1.05])
% xticks(epsilon_all(1:2:end))
% xticklabels({'0.001', '0.01', '0.1', '1.0', '10.0'})
% 
% set(gca,'FontSize',FS-4,'FontWeight','bold')
% xlabel('Privacy parameter (\epsilon)','FontSize',FS,'FontWeight','bold');
% ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
% title('MNIST data (\delta=0.01, S = 10, N_s = 1k)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP', 'DistD nDP', 'DistD DP', 'LocD nDP', 'LocD DP', 'Location','NE')

%% for covtype data
load covtype_vs_epsilon.mat
subplot(133)

en_pool_dp_mean = mean(en_pool_dp) / en_pool_ndp;
en_dist_hafiz_ndp_mean = mean(en_dist_hafiz_ndp) / en_pool_ndp;
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp) / en_pool_ndp;
en_loc_hafiz_ndp_mean = mean(en_loc_hafiz_ndp) / en_pool_ndp;
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp) / en_pool_ndp;

semilogx(epsilon_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_hafiz_ndp_mean,'rs--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_dist_hafiz_dp_mean,'bo--','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_hafiz_ndp_mean,'r*--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_loc_hafiz_dp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([epsilon_all(1)/10 epsilon_all(end)*10 -0.05 1.05])
xticks(epsilon_all(1:2:end))
xticklabels({'0.001', '0.01', '0.1', '1.0', '10.0'})

set(gca,'FontSize',FS-4,'FontWeight','bold')
xlabel('Privacy parameter (\epsilon)','FontSize',FS,'FontWeight','bold');
ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
title('COVTYPE data (\delta=0.01, S = 10,N_s = 0.5k)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP','DistH nDP', 'DistH DP', 'LocH nDP', 'LocH DP', 'Location','NE')
legend('Pooled DP', 'DPdisPCA', 'Local DP', 'Location','NW')

% subplot(236)
% en_pool_dp_mean = mean(en_pool_dp) / en_pool_ndp;
% en_dist_djica_ndp_mean = mean(en_dist_djica_ndp) / en_pool_ndp;
% en_dist_djica_dp_mean = mean(en_dist_djica_dp) / en_pool_ndp;
% en_loc_djica_ndp_mean = mean(en_loc_djica_ndp) / en_pool_ndp;
% en_loc_djica_dp_mean = mean(en_loc_djica_dp) / en_pool_ndp;
% 
% semilogx(epsilon_all, en_pool_dp_mean,'ko:','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_djica_ndp_mean,'rs-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_dist_djica_dp_mean,'bo-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_djica_ndp_mean,'r*-.','LineWidth',3,'MarkerSize',10); hold on
% semilogx(epsilon_all, en_loc_djica_dp_mean,'b*-.','LineWidth',3,'MarkerSize',10); hold on
% 
% axis([epsilon_all(1)/10 epsilon_all(end)*10 -0.05 1.05])
% xticks(epsilon_all(1:2:end))
% xticklabels({'0.001', '0.01', '0.1', '1.0', '10.0'})
% 
% set(gca,'FontSize',FS-4,'FontWeight','bold')
% xlabel('Privacy parameter (\epsilon)','FontSize',FS,'FontWeight','bold');
% ylabel('Relative captured energy','FontSize',FS,'FontWeight','bold');
% title('COVTYPE data (\delta=0.01, S = 10,N_s = 0.5k)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP', 'DistD nDP', 'DistD DP', 'LocD nDP', 'LocD DP', 'Location','NE')

