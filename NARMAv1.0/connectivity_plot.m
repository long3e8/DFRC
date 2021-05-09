% This script makes box plots of MG reservoir with different
% Time-multiplexing

% Call main functions
NarmaSH
NarmaBM
NarmaRM

% Load files
load('sh_output(10).mat', 'sh_err')
load('bm_output(10).mat', 'bm_err')
load('rm_output(10).mat', 'rm_err')

% Plot
T = [sh_err;bm_err;rm_err];
boxplot(T','Labels',{'Sample&Hold','Binary Mask','Random Mask'},'Whisker',1)
xlabel('Time multiplexing')
ylabel('NRMSE')
title('Connectivity = 10 nodes')