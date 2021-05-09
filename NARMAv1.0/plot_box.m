% This script makes box plots of MG reservoir with different
% Time-multiplexing

NarmaSH
NarmaBM
NarmaRM

load('sh_output(15).mat', 'sh_err')
load('bm_output(15).mat', 'bm_err')
load('rm_output(15).mat', 'rm_err')

T = [sh_err;bm_err;rm_err];
boxplot(T','Labels',{'Sample&Hold','Binary Mask','Random Mask'},'Whisker',1)
xlabel('Time multiplexing')
ylabel('NRMSE')
title('Connectivity = 15 nodes')