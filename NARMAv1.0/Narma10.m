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
sequenceLength = 10000;
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
n = 0.02; % Nonlinearity
config.connect_type = '15'; % Connectivity
[state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,config);

%% Training
% Moore-Penrose pseudo-inverse, which allows to avoid problems with
% ill-conditioned matrices.
% Weighted average of matrix
target_output = repelem(outputSequence,Nodes).';
w = target_output * pinv(state_matrix);

%% Demultiplexing
system_output = w * state_matrix;
system_output = system_output(1:Nodes:end,1:Nodes:end);
target_output = target_output(1:Nodes:end,1:Nodes:end);

%% Evaluation
config.err_type = 'NRMSE';
err(i) = calculateError(system_output,target_output,config);
% save('sh_output(30).mat','sh_err');
toc
end
% boxplot(err)

% figure(1);
%  plot(system_output(1100:1200));
%  hold on;
%  plot(yt(1100:1200));
%  legend('System Output','Desired Output');