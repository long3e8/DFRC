load dism.mat;
load sidm.mat;
load didm.mat;


t = tiledlayout(1,3);
xlabel(t,'Time-multiplexing');
ylabel(t,'NRMSE');

ax1 = nexttile;
boxplot(test_err_sidm,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SH','BM','RM'});
ylim([0.23 0.66]);
grid on;
title('SIDM','FontSize', 9);

ax2 = nexttile;
boxplot(test_err_dism,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SH','BM','RM'});
ylim([0.23 0.66]);
grid on;
title('DISM','FontSize', 9);

ax3 = nexttile;
boxplot(test_err_didm,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SH','BM','RM'});
ylim([0.23 0.66]);
grid on;
title('DIDM','FontSize', 9);

lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', [0.8500 0.3250 0.0980]);
linkaxes([ax1,ax2,ax3],'y');