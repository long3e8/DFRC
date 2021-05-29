load bkpp_itsay_1.mat;
load bkpp_itsay_2.mat;
load bkpp_itsay_5.mat;
load bkpp_itsay_10.mat;
load bkpp_itsay_15.mat;
load bkpp_itsay_30.mat;

% x1 = ['2','5','10','15','30'];

figure('Renderer', 'painters', 'Position', [10 10 900 600]);
t = tiledlayout(2,3);

xlabel(t,'Time-multiplexing');
ylabel(t,'NRMSE');

ax1 = nexttile;
boxplot(test_err_30,'Notch','on','Labels',{'SH','BM','RM'});
hold on;
boxplot(train_err_30,'Notch','on');
xtickangle(ax1,45);
ylim([0.22 0.65]);
title('N = 30','FontSize', 11);

ax2 = nexttile;
boxplot(test_err_15,'Notch','on','Labels',{'SH','BM','RM'});
xtickangle(ax2,45);
ylim([0.22 0.65]);
title('N = 15','FontSize', 11);

ax3 = nexttile;
boxplot(test_err_10,'Notch','on','Labels',{'SH','BM','RM'});
xtickangle(ax3,45);
ylim([0.22 0.65]);
title('N = 10','FontSize', 11);

ax4 = nexttile;
boxplot(test_err_5,'Notch','on','Labels',{'SH','BM','RM'});
xtickangle(ax4,45);
ylim([0.22 0.65]);
title('N = 5','FontSize', 11);

ax5 = nexttile;
boxplot(test_err_2,'Notch','on','Labels',{'SH','BM','RM'});
xtickangle(ax5,45);
ylim([0.22 0.65]);
title('N = 2','FontSize', 11);

ax6 = nexttile;
boxplot(test_err_1,'Notch','on','Labels',{'SH','BM','RM'});
xtickangle(ax6,45);
ylim([0.22 0.65]);
title('N = 1','FontSize', 11);

linkaxes([ax1,ax2,ax3,ax4,ax5,ax6],'y');