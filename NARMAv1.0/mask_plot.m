load bkpp_ipytm_30.mat;
load bkpp_ipytm_15.mat;
load bkpp_ipytm_10.mat;
load bkpp_ipytm_5.mat;
load bkpp_ipytm_2.mat;

figure('Color', 'w');
c = colormap(lines(3));

A(1:30,:) = NaN;

data = [test_err_ipytm2 A test_err_ipytm5 A test_err_ipytm10 A test_err_ipytm15 A test_err_ipytm30];

C = [c; ones(1,3); c];

boxplot(data, 'colors', C , 'Notch','on',...
    'labels', {'','ASIA','','','','USA','','','','','','','','','','','','',''}); % label only two categories
hold on;
for ii = 1:3
    plot(NaN,1,'color', c(ii,:), 'LineWidth', 4);
end

title('BOXPLOT');
ylabel('MPG');
xlabel('ORIGIN');
legend({'SUV', 'SEDAN', 'SPORT'});
grid on;
set(gca, 'XLim', [0 19], 'YLim', [0.2 0.7]);