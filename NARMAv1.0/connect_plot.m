load 2_mask.mat;
load 5_mask.mat;
load 10_mask.mat;
load 15_mask.mat;
load 30_mask.mat;

% x1 = ['2','5','10','15','30'];


t = tiledlayout(1,5);

xlabel(t,'Time-multiplexing');
ylabel(t,'NRMSE');

ax1 = nexttile;
boxplot(test_err_2,'Notch','on','Labels',{'SH','BM','RM'});
title('N = 2');
ax2 = nexttile;
boxplot(test_err_5,'Notch','on','Labels',{'SH','BM','RM'});
title('N = 5');
ax3 = nexttile;
boxplot(test_err_10,'Notch','on','Labels',{'SH','BM','RM'});
title('N = 10');
ax4 = nexttile;
boxplot(test_err_15,'Notch','on','Labels',{'SH','BM','RM'});
title('N = 15');
ax5 = nexttile;
boxplot(test_err_30,'Notch','on','Labels',{'SH','BM','RM'});
title('N = 30');
linkaxes([ax1,ax2,ax3,ax4,ax5],'y');