% This script makes box plots of MG reservoir with different
% Time-multiplexing

% Load files
load('train_30')

% Plot
T = train_30';
bins = {'Sample & Hold','Binary Mask','Random Mask'};
boxchart(T,'Notch','on')
set(gcf, 'units', 'normalized');
set(gcf, 'Position', [0.5, 0.5, 0.1, 0.5]);


ylabel('NRMSE')
title('30 nodes')