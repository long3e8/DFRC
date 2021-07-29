% load nonoffset_SH.mat;
% load nonoffset_BM.mat;
% load nonoffset_RM.mat;

load Nooffset_SH30.mat;
load Nooffset_BWM30.mat;
load Nooffset_RWM30.mat;

t = tiledlayout(1,3);
xlabel(t,'Settings');
ylabel(t,'NRMSE');

ax1 = nexttile;
% boxplot(nonoffset_SH,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
boxplot(NooffsetSH30,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
% xtickangle(ax1,45);
ylim([0.02 0.32]);
grid on;
title('Sample & Hold','FontSize', 9);

ax2 = nexttile;
% boxplot(nonoffset_BM,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
boxplot(NooffsetBWM30,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
% xtickangle(ax2,45);
ylim([0.02 0.32]);
grid on;
title('Binary Weight Mask','FontSize', 9);

ax3 = nexttile;
% boxplot(nonoffset_RM,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
boxplot(NooffsetBWM30,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
% xtickangle(ax3,45);
ylim([0.02 0.32]);
grid on;
title('Real Weight Mask','FontSize', 9);

lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', [0.8500 0.3250 0.0980]);
linkaxes([ax1,ax2,ax3],'y');