%% NARMA-10 Benchmark Task
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.
clear
close all
rng(1,'twister');

loop = 1;
err = zeros(1,loop);
tic
for i = 1:loop
%% Setup
%rng(1,'twister');
sequenceLength = 5000;
memoryLength = 10;
Nodes = 30;
theta = 0.01;
config.memoryLength = '{10,5}'; %[0,0.5]
[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequenceLength, memoryLength);

% split of data set 60/20/20 train/val/test
config.train_fraction=0.6; 
config.val_fraction=0.2; 
config.test_fraction=0.2;
% [individual,test_states,test_sequence] = testReservoir(individual,config);

%% Time-multiplexing
config.masking_type = 'Random Mask';  % select between 'Binary Mask','Random Mask','Sample and Hold'
[System_inputSequence] = TimeMultiplexing(inputSequence,Nodes,sequenceLength,theta,config);

%% Run Mackey-Glass in Simulink
TFinal = theta * sequenceLength * Nodes;
coupling = 0.32;
decay_rate = 0.55;
n = 0.002; % Nonlinearity
config.connectivity = '30'; % Connectivity
[state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,config);

%% Training
% Moore-Penrose pseudo-inverse, which allows to avoid problems with
% ill-conditioned matrices.
% Weighted average of matrix
yt = repelem(outputSequence,Nodes).';
w = yt * pinv(state_matrix);

%% Demultiplexing
system_output = w * state_matrix;
yt = yt(1:Nodes:end,1:Nodes:end);

system_output = system_output(1:Nodes:end,1:Nodes:end);

%% Error between NARMA and Simulink model
% nrmse_err = sqrt((sum((yt-system_output).^2)/(var(yt)))*(1/length(yt)))
% err = nrmse(yt , system_output)
config.err_type = 'NRMSE';
err(i) = calculateError(system_output,yt,config);
% save('sh_output(30).mat','sh_err');
toc
end
% boxplot(err)
% csvwrite('test1.csv',err);
% Plot
% figure(1);
%  plot(system_output(1100:1200));
%  hold on;
%  plot(yt(1100:1200));
%  legend('System Output','Desired Output');