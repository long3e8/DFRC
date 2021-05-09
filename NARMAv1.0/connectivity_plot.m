% This script makes box plots of MG reservoir with different
% Time-multiplexing

% Load files
load('sh_output(30).mat', 'sh_err')
load('bm_output(30).mat', 'bm_err')
load('rm_output(30).mat', 'rm_err')

% Plot
T = [sh_err;bm_err;rm_err];
boxplot(T','Labels',{'Sample&Hold','Binary Mask','Random Mask'},'Whisker',1)
set(gcf, 'units', 'normalized');
set(gcf, 'Position', [0.5, 0.5, 0.2, 0.5]);
ylim([0.68,0.82])
xlabel('Time multiplexing')
ylabel('NRMSE')
title('Connectivity = 30 nodes')