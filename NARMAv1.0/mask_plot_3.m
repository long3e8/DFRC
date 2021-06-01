load bkpp_itsay_sh.mat;
load bkpp_itsay_bm.mat;
load bkpp_itsay_rm.mat;
% x1 = ['2','5','10','15','30'];
figure('Renderer', 'painters', 'Position', [10 10 600 300]);

ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = ':';
ax.GridAlpha = 0.5;
t = tiledlayout(1,3);

xlabel(t,'Sampling Scale');
ylabel(t,'NRMSE');



ax1 = nexttile;
boxplot(test_err_sh,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'2','5','10','15','30'});
% xtickangle(ax1,45);
ylim([0.22 0.68]);
title('Sample & Hold','FontSize', 11);
grid on;

ax2 = nexttile;
boxplot(test_err_bm,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'2','5','10','15','30'});
% xtickangle(ax2,45);
ylim([0.22 0.68]);
title('Binary Mask','FontSize', 11);
grid on;
ax3 = nexttile;
boxplot(test_err_rm,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'2','5','10','15','30'});
% xtickangle(ax3,45);
ylim([0.22 0.68]);
title('Random Mask','FontSize', 11);

lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', [0.8500 0.3250 0.0980]);

linkaxes([ax1,ax2,ax3],'y');
grid on;