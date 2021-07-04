load 10_offset.mat;
load 5_offset.mat;
load 2_offset.mat;
load 1_offset.mat


% x1 = ['2','5','10','15','30'];

figure('Renderer', 'painters', 'Position', [10 10 800 400]);

t = tiledlayout(1,4);

xlabel(t,'Time-multiplexing');
ylabel(t,'NRMSE');


ax1 = nexttile;
boxplot(test_err_o10,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% hold on;
% boxplot(train_err_30,'Color',[0, 0.4470, 0.7410],'Notch','on','Labels',{'SH','BM','RM'});
% xtickangle(ax1,45);
ylim([0.08 0.65]);
title('N_i = 10','FontSize', 11);
grid on;

ax2 = nexttile;
boxplot(test_err_o5,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% hold on;
% boxplot(train_err_15,'Color',[0, 0.4470, 0.7410],'Notch','on','Labels',{'SH','BM','RM'});
% xtickangle(ax2,45);
ylim([0.08 0.65]);
title('N_i = 1','FontSize', 11);
grid on;

ax3 = nexttile;
boxplot(test_err_o2,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% hold on;
% boxplot(train_err_10,'Color',[0, 0.4470, 0.7410],'Notch','on','Labels',{'SH','BM','RM'});
% xtickangle(ax3,45);
ylim([0.08 0.65]);
title('N_i = 2','FontSize', 11);
grid on;

ax4 = nexttile;
boxplot(test_err_o1,'Color',[0, 0, 0.65],'Notch','on','Labels',{'SH','BWM','RWM'});
% hold on;
% boxplot(train_err_5,'Color',[0, 0.4470, 0.7410],'Notch','on','Labels',{'SH','BM','RM'});
% xtickangle(ax4,45);
ylim([0.08 0.65]);
title('N_i = 5','FontSize', 11);
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