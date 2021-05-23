load connect_sh.mat;
load connect_bm.mat;
load connect_rm.mat;
% x1 = ['2','5','10','15','30'];

plot(mean(test_err_sh),'linewidth',1.5);
hold on;
plot(mean(test_err_bm),':','linewidth',1.5);
hold on;
plot(mean(test_err_rm),'--','linewidth',1.5)

xlim([1 5]);
ylim([0.3 1]);
legend('Sample and Hold','Binary Mask','Random Mask');
grid on;
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = ':';
ax.GridAlpha = 0.5;
xlabel('Connectivity');
ylabel('NRMSE');