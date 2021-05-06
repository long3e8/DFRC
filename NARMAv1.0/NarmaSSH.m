%% NARMA-10 Sample & Hold (√), Masking (×)
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.

% !! Lack of training and testing process for now.

clear
close all

rng(1,'twister');

%% Setup
sequenceLength = 5000;
memoryLength = 10;
Nodes = 30;
[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequenceLength, memoryLength);

% split of data set 60/20/20 train/val/test
config.train_fraction=0.6; 
config.val_fraction=0.2; 
config.test_fraction=0.2;
config.memoryLength = '{10,5}'; %[0,0.5]

%% input Sequence with time dimension

start_time = 0; % Starting time --- in order to make T = TFinal
step_size = 0.01; % Step
N = sequenceLength * Nodes; % Number of values
timeline = start_time + step_size*(0:N-1); % Generate time in matrix

% Sample & Hold
inputSequence = repelem (inputSequence,Nodes);
inputSequence = [timeline(:),inputSequence(:)];

%% Run Mackey-Glass in Simulink
TDelay = step_size;
TFinal = step_size * N;
B = 0.32;
G = 0.55;
n = 0.12;
sim('MG1.slx');

%% Training --- lack of training process!

% For N nodes and k time steps, the result is a (N*k)-dimensional reservoir state matrix
res_matrix = [ans.simout1 ans.simout].';
res_matrix(:,1) = [];
res_matrix = flipud(res_matrix);
% Moore-Penrose pseudo-inverse, which allows to avoid problems with
% ill-conditioned matrices.
% Weighted average of matrix
yt = repelem(outputSequence,Nodes).';
w = yt * pinv(res_matrix);

%% Demultiplexing

system_output = w * res_matrix;
yt = yt(1:Nodes:end,1:Nodes:end);
system_output = system_output(1:Nodes:end,1:Nodes:end);

%% Error between NARMA and Simulink model
% nrmse_err = sqrt((sum((yt-system_output).^2)/(var(yt)))*(1/length(yt)))
err = nrmse(yt , system_output)

%% Plot
figure(1);
 plot(system_output(1100:1200));
 hold on;
 plot(yt(1100:1200));
 legend('System Output','Desired Output');