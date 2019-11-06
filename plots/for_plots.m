clear;clc;close all

epsilon_all = [1e-3 5e-3 1e-2 5e-2 1e-1 5e-1 1 5 10];
delta = 0.01;
FS = 30;

%% plotting performance vs epsilon
% for synth data
load synth_vs_epsilon_ver2.mat
subplot(331)

en_pool_ndp_mean = en_pool_ndp * ones(length(epsilon_all), 1);
en_pool_dp_mean = mean(en_pool_dp);
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp);
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2);
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp);

semilogx(epsilon_all, en_pool_dp_mean,'kd--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_dist_hafiz_dp_mean,'ks--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_dist_hafiz_dp_ver2_mean,'kx--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_loc_hafiz_dp_mean,'kv--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_pool_ndp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on

axis([epsilon_all(1)/10 epsilon_all(end)*10 50 300])
xticks(epsilon_all(1:2:end))
xticklabels({'0.001', '0.01', '0.1', '1.0', '10.0'})

set(gca,'FontSize',FS,'FontWeight','bold')
xlabel('(a) Privacy parameter (\epsilon)','FontSize',FS,'FontWeight','bold');
ylabel('q^{CE}','FontSize',FS,'FontWeight','bold');
title('Synthetic (\delta=0.01, S = 10, N_s = 1k)','FontSize',FS,'FontWeight','bold')
legend('capePCA', 'DPdisPCA', 'conv', 'dp local', 'non-dp pool', 'Location','best')

% for MNIST data
load mnist_vs_epsilon_ver2.mat
subplot(332)

en_pool_ndp_mean = en_pool_ndp * ones(length(epsilon_all), 1);
en_pool_dp_mean = mean(en_pool_dp);
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp);
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2);
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp);

semilogx(epsilon_all, en_pool_dp_mean,'kd--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_dist_hafiz_dp_mean,'ks--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_dist_hafiz_dp_ver2_mean,'kx--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_loc_hafiz_dp_mean,'kv--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_pool_ndp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on

axis([epsilon_all(1)/10 epsilon_all(end)*10 0 50])
xticks(epsilon_all(1:2:end))
xticklabels({'0.001', '0.01', '0.1', '1.0', '10.0'})

set(gca,'FontSize',FS,'FontWeight','bold')
xlabel('(b) Privacy parameter (\epsilon)','FontSize',FS,'FontWeight','bold');
ylabel('q^{CE}','FontSize',FS,'FontWeight','bold');
title('MNIST (\delta=0.01, S = 10, N_s = 1k)','FontSize',FS,'FontWeight','bold')
% legend('capePCA', 'DPdisPCA', 'conv', 'dp local', 'non-dp pool', 'Location','best')

% for covtype data
load covtype_vs_epsilon_ver2.mat
subplot(333)

en_pool_ndp_mean = en_pool_ndp * ones(length(epsilon_all), 1);
en_pool_dp_mean = mean(en_pool_dp);
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp);
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2);
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp);

semilogx(epsilon_all, en_pool_dp_mean,'kd--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_dist_hafiz_dp_mean,'ks--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_dist_hafiz_dp_ver2_mean,'kx--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_loc_hafiz_dp_mean,'kv--','LineWidth',3,'MarkerSize',10); hold on
semilogx(epsilon_all, en_pool_ndp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on

axis([epsilon_all(1)/10 epsilon_all(end)*10 0 5e6])
xticks(epsilon_all(1:2:end))
xticklabels({'0.001', '0.01', '0.1', '1.0', '10.0'})

set(gca,'FontSize',FS,'FontWeight','bold')
xlabel('(c) Privacy parameter (\epsilon)','FontSize',FS,'FontWeight','bold');
ylabel('q^{CE}','FontSize',FS,'FontWeight','bold');
title('COVTYPE (\delta=0.01, S = 10,N_s = 0.5k)','FontSize',FS,'FontWeight','bold')
% legend('capePCA', 'DPdisPCA', 'conv', 'dp local', 'non-dp pool', 'Location','best')

%% plotting performance vs samples
% for synth data
load synth_vs_samples_ver2.mat
subplot(334)

en_pool_ndp_mean = mean(en_pool_ndp);
en_pool_dp_mean = mean(en_pool_dp);
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp);
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2);
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp);

semilogx(N_all, en_pool_dp_mean,'kd--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_dist_hafiz_dp_mean,'ks--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_dist_hafiz_dp_ver2_mean,'kx--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_loc_hafiz_dp_mean,'kv--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_pool_ndp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on

axis([N_all(1)/2 N_all(end)*2 50 300])
xticks(N_all(1:3:end))
xticklabels({'0.1', '1', '4'})

set(gca,'FontSize',FS,'FontWeight','bold')
xlabel('(d) Local sample size in 1000 (N_s)','FontSize',FS,'FontWeight','bold');
ylabel('q^{CE}','FontSize',FS,'FontWeight','bold');
title('Synthetic (\epsilon = 0.5, \delta=0.01, S = 10)','FontSize',FS,'FontWeight','bold')
legend('capePCA', 'DPdisPCA', 'conv', 'dp local', 'non-dp pool', 'Location','best')

% for MNIST data
load mnist_vs_samples_ver2.mat
subplot(335)

en_pool_ndp_mean = mean(en_pool_ndp);
en_pool_dp_mean = mean(en_pool_dp);
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp);
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2);
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp);

semilogx(N_all, en_pool_dp_mean,'kd--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_dist_hafiz_dp_mean,'ks--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_dist_hafiz_dp_ver2_mean,'kx--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_loc_hafiz_dp_mean,'kv--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_pool_ndp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on

axis([N_all(1)/2 N_all(end)*2 0 50])
xticks(N_all(1:3:end))
xticklabels({'0.1', '1', '4'})

set(gca,'FontSize',FS,'FontWeight','bold')
xlabel('(e) Local sample size in 1000 (N_s)','FontSize',FS,'FontWeight','bold');
ylabel('q^{CE}','FontSize',FS,'FontWeight','bold');
title('MNIST (\epsilon = 1, \delta=0.01, S = 10)','FontSize',FS,'FontWeight','bold')

% for covtype data
load covtype_vs_samples_ver2.mat
subplot(336)

en_pool_ndp_mean = mean(en_pool_ndp);
en_pool_dp_mean = mean(en_pool_dp);
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp);
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2);
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp);

semilogx(N_all, en_pool_dp_mean,'kd--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_dist_hafiz_dp_mean,'ks--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_dist_hafiz_dp_ver2_mean,'kx--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_loc_hafiz_dp_mean,'kv--','LineWidth',3,'MarkerSize',10); hold on
semilogx(N_all, en_pool_ndp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([N_all(1)/2 N_all(end)*2 0 5e6])
xticks(N_all(1:3:end))
xticklabels({'0.1', '1', '4'})

set(gca,'FontSize',FS,'FontWeight','bold')
xlabel('(f) Local sample size in 1000 (N_s)','FontSize',FS,'FontWeight','bold');
ylabel('q^{CE}','FontSize',FS,'FontWeight','bold');
title('COVTYPE (\epsilon = 0.1, \delta=0.01, S = 10)','FontSize',FS,'FontWeight','bold')


%% plotting performance vs delta
% figure
% for synth data
load synth_vs_delta_ver2.mat
subplot(337)

en_pool_ndp_mean = en_pool_ndp * ones(length(delta_all), 1);
en_pool_dp_mean = mean(en_pool_dp);
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp);
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2);
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp);

semilogx(delta_all, en_pool_dp_mean,'kd--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_dist_hafiz_dp_mean,'ks--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_dist_hafiz_dp_ver2_mean,'kx--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_loc_hafiz_dp_mean,'kv--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_pool_ndp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([delta_all(1)/200 delta_all(end)*2 50 300])
xticks(delta_all(1:2:end))
xticklabels({'0.0001', '0.001', '0.01'})

set(gca,'FontSize',FS,'FontWeight','bold')
xlabel('(g) Privacy parameter (\delta)','FontSize',FS,'FontWeight','bold');
ylabel('q^{CE}','FontSize',FS,'FontWeight','bold');
title('Synthetic (\epsilon=1.0, S = 10, N_s = 1k)','FontSize',FS,'FontWeight','bold')
legend('capePCA', 'DPdisPCA', 'conv', 'dp local', 'non-dp pool', 'Location','best')

% for MNIST data
load mnist_vs_delta_ver2.mat
subplot(338)

en_pool_ndp_mean = en_pool_ndp * ones(length(delta_all), 1);
en_pool_dp_mean = mean(en_pool_dp);
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp);
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2);
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp);

semilogx(delta_all, en_pool_dp_mean,'kd--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_dist_hafiz_dp_mean,'ks--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_dist_hafiz_dp_ver2_mean,'kx--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_loc_hafiz_dp_mean,'kv--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_pool_ndp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([delta_all(1)/2 delta_all(end)*2 0 40])
xticks(delta_all(1:2:end))
xticklabels({'0.0001', '0.001', '0.01'})

set(gca,'FontSize',FS,'FontWeight','bold')
xlabel('(h) Privacy parameter (\delta)','FontSize',FS,'FontWeight','bold');
ylabel('q^{CE}','FontSize',FS,'FontWeight','bold');
title('MNIST (\epsilon=2.0, S = 10, N_s = 1k)','FontSize',FS,'FontWeight','bold')

% for covtype data
load covtype_vs_delta_ver2.mat
subplot(339)

en_pool_ndp_mean = en_pool_ndp * ones(length(delta_all), 1);
en_pool_dp_mean = mean(en_pool_dp);
en_dist_hafiz_dp_mean = mean(en_dist_hafiz_dp);
en_dist_hafiz_dp_ver2_mean = mean(en_dist_hafiz_dp_ver2);
en_loc_hafiz_dp_mean = mean(en_loc_hafiz_dp);

semilogx(delta_all, en_pool_dp_mean,'kd--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_dist_hafiz_dp_mean,'ks--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_dist_hafiz_dp_ver2_mean,'kx--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_loc_hafiz_dp_mean,'kv--','LineWidth',3,'MarkerSize',10); hold on
semilogx(delta_all, en_pool_ndp_mean,'b*--','LineWidth',3,'MarkerSize',10); hold on


axis([delta_all(1)/2 delta_all(end)*2 0 5e6])
xticks(delta_all(1:2:end))
xticklabels({'0.0001', '0.001', '0.01'})

set(gca,'FontSize',FS,'FontWeight','bold')
xlabel('(i) Privacy parameter (\delta)','FontSize',FS,'FontWeight','bold');
ylabel('q^{CE}','FontSize',FS,'FontWeight','bold');
title('COVTYPE (\epsilon=0.5, S = 10,N_s = 0.5k)','FontSize',FS,'FontWeight','bold')
% legend('Pool DP','DistH nDP', 'DistH DP', 'LocH nDP', 'LocH DP', 'Location','NE')
% legend('q_{capePCA}', 'q_{DPdisPCA}', 'q_{conv}', 'q_{local}', 'q_o', 'Location','SE')

