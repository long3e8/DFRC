load bkpp_itsay_sh.mat;
load bkpp_itsay_bm.mat;
load bkpp_itsay_rm.mat;
% x1 = ['2','5','10','15','30'];
figure('Renderer', 'painters', 'Position', [10 10 600 300]);

plot(mean(test_err_sh),'linewidth',1.5);
hold on;
plot(mean(test_err_bm),'linewidth',1.5);
hold on;
plot(mean(test_err_rm),'linewidth',1.5);
hold on;

x_sh = 1:1:5;
y_sh = [mean(test_err_sh(:,1)) mean(test_err_sh(:,2)) mean(test_err_sh(:,3))...
    mean(test_err_sh(:,4)) mean(test_err_sh(:,5))];
err_sh = [max(test_err_sh(:,1))-min(test_err_sh(:,1)) max(test_err_sh(:,2))-min(test_err_sh(:,2))...
    max(test_err_sh(:,3))-min(test_err_sh(:,3)) max(test_err_sh(:,4))-min(test_err_sh(:,4)) ...
    max(test_err_sh(:,5))-min(test_err_sh(:,5))];
errorbar(x_sh,y_sh,err_sh,'o');

hold on;


x_bm = 1:1:5;
y_bm = [mean(test_err_bm(:,1)) mean(test_err_bm(:,2)) mean(test_err_bm(:,3))...
    mean(test_err_bm(:,4)) mean(test_err_bm(:,5))];
err_bm = [max(test_err_bm(:,1))-min(test_err_bm(:,1)) max(test_err_bm(:,2))-min(test_err_bm(:,2))...
    max(test_err_bm(:,3))-min(test_err_bm(:,3)) max(test_err_bm(:,4))-min(test_err_bm(:,4)) ...
    max(test_err_bm(:,5))-min(test_err_bm(:,5))];
errorbar(x_bm,y_bm,err_bm,'o');
hold on;


x_rm = 1:1:5;
y_rm = [mean(test_err_rm(:,1)) mean(test_err_rm(:,2)) mean(test_err_rm(:,3))...
    mean(test_err_rm(:,4)) mean(test_err_rm(:,5))];
err_rm = [max(test_err_rm(:,1))-min(test_err_rm(:,1)) max(test_err_rm(:,2))-min(test_err_rm(:,2))...
    max(test_err_rm(:,3))-min(test_err_rm(:,3)) max(test_err_rm(:,4))-min(test_err_rm(:,4)) ...
    max(test_err_rm(:,5))-min(test_err_rm(:,5))];
errorbar(x_rm,y_rm,err_rm,'o');



xlim([1 5]);
ylim([0.09 0.7]);
legend('Sample and Hold','Binary Mask','Random Mask');
grid on;
ax = gca;
ax.GridColor = [0 .5 .5];
ax.GridLineStyle = ':';
ax.GridAlpha = 0.5;
xlabel('Connectivity');
ylabel('NRMSE');