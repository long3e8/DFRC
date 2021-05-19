load sh_connect.mat;
load bm_connect.mat;
load rm_connect.mat;
% x1 = ['2','5','10','15','30'];


t = tiledlayout(1,3);

xlabel(t,'Connectivity');
ylabel(t,'NRMSE');

ax1 = nexttile;
boxplot(test_err_sh,'Notch','on','Labels',{'2','5','10','15','30'});
title('Sample and Hold');
ax2 = nexttile;
boxplot(test_err_bm,'Notch','on','Labels',{'2','5','10','15','30'});
title('Binary Mask');
ax3 = nexttile;
boxplot(test_err_rm,'Notch','on','Labels',{'2','5','10','15','30'});
title('Random Mask');
linkaxes([ax1,ax2,ax3],'y');