NarmaSH
NarmaBM
NarmaRM

load('sh_output.mat', 'sh_err')
load('bm_output.mat', 'bm_err')
load('rm_output.mat', 'rm_err')

T = [sh_err;bm_err;rm_err];
boxplot(T','Labels',{'Sample&Hold','Binary Mask','Random Mask'},'Whisker',1)
xlabel('Time multiplexing')
ylabel('NRMSE')
title('Connectivity = 30 nodes')