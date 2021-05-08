T = readmatrix('boxplot.xlsx');
boxplot(T','Labels',{'Sample&Hold','Binary Mask','Random Mask'},'Whisker',1)
xlabel('Time multiplexing')
colors = rand(4, 3);
ylabel('NRMSE')
title('Connectivity = 30 nodes')