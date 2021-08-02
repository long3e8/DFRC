% ideal tapped delay
% load offset30.mat;
% load offset15.mat;
% load offset5.mat;
% load offset1.mat;

% load offset.mat;

% lossless transmission line
% load offset_ll30.mat;
% load offset_ll15.mat;
% load offset_ll5.mat;
% load offset_ll1.mat;

% damping transmission line (offset)
% load dp30.mat;
% load dp15.mat;
% load dp5.mat;
% load dp1.mat;

% damping transmission line NARMA-10 (no-offset)
% load damping_no30.mat;
% load damping_no15.mat;
% load damping_no5.mat;
% load damping_no1.mat;

% damping transmission line NARMA-30 (offset)
load N30_offsetdp30.mat;
load N30_offsetdp15.mat;
load N30_offsetdp5.mat;
load N30_offsetdp1.mat;

% x1 = ['2','5','10','15','30'];

figure('Renderer', 'painters', 'Position', [10 10 800 400]);

t = tiledlayout(1,4);

xlabel(t,'Time-multiplexing');
ylabel(t,'NRMSE');


ax1 = nexttile;
% boxplot(test_err_no30,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% boxplot(test_err_ll30,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% boxplot(test_err_dp30,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
boxplot(test_err_30dp30,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% xtickangle(ax1,45);
ylim([0.1 0.35]);
title('N_i = 30','FontSize', 11);
grid on;

ax2 = nexttile;
% boxplot(test_err_no15,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% boxplot(test_err_ll15,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% boxplot(test_err_dp15,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
boxplot(test_err_30dp15,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% xtickangle(ax2,45);
ylim([0.1 0.35]);
title('N_i = 15','FontSize', 11);
grid on;

ax3 = nexttile;
% boxplot(test_err_no5,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% boxplot(test_err_ll5,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% boxplot(test_err_dp5,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
boxplot(test_err_30dp5,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% xtickangle(ax3,45);
ylim([0.1 0.35]);
title('N_i = 5','FontSize', 11);
grid on;

ax4 = nexttile;
% boxplot(test_err_no1,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% boxplot(test_err_ll1,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% boxplot(test_err_dp1,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
boxplot(test_err_30dp1,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% xtickangle(ax4,45);
ylim([0.1 0.35]);
title('N_i = 1','FontSize', 11);
grid on;

% ax5 = nexttile;
% boxplot(test_err_2,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% % hold on;
% % boxplot(train_err_2,'Color',[0, 0.4470, 0.7410],'Notch','on','Labels',{'SH','BM','RM'});
% % xtickangle(ax5,45);
% ylim([0.08 0.65]);
% title('N_i = 2','FontSize', 11);
% grid on;

% ax6 = nexttile;
% boxplot(test_err_1,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% % hold on;
% % boxplot(train_err_1,'Color',[0, 0.4470, 0.7410],'Notch','on','Labels',{'SH','BM','RM'});
% % xtickangle(ax6,45);
% ylim([0.08 0.65]);
% title('N_i = 1','FontSize', 11);
% grid on;
% h = zeros(2, 1);
% h(1) = plot(0,0,'or', 'visible', 'off');
% h(2) = plot(0,0,'ob', 'visible', 'off');

lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', [0.8500 0.3250 0.0980]);

% linkaxes([ax1,ax2,ax3,ax4,ax5,ax6],'y');
linkaxes([ax1,ax2,ax3,ax4],'y');