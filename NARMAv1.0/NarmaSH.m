%% NARMA-10 Sample & Hold (√), Masking (×)
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.

clear
close all
rng(1,'twister');

loop = 10;
sh_err = zeros(1,loop);
tic
for l = 1:loop
%% Setup
%rng(1,'twister');
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
theta = 0.01; % Step
N = sequenceLength * Nodes; % Number of values
timeline = start_time + theta*(0:N-1); % Generate time in matrix

% Sample & Hold
inputSequence = repelem (inputSequence,Nodes);
inputSequence = [timeline(:),inputSequence(:)];

%% Run Mackey-Glass in Simulink
TDelay = theta;
TFinal = theta * N;
B = 0.32;
G = 0.55;
n = 0.002;
sim('MG1.slx');

%% Training
% For N nodes and k time steps, the result is a (N*k)-dimensional reservoir state matrix
res_matrix = [ans.simout1].';
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
% err = nrmse(yt , system_output)
config.err_type = 'NRMSE';
sh_err(l) = calculateError(system_output,yt,config);
save('sh_output.mat','sh_err');
toc
end
% boxplot(err)
% csvwrite('test1.csv',err);
%% Plot
% figure(1);
%  plot(system_output(1100:1200));
%  hold on;
%  plot(yt(1100:1200));
%  legend('System Output','Desired Output');