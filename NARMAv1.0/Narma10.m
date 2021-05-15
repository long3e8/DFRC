%% NARMA-10 Benchmark Task
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.
clear
close all
rng(1,'twister');

loop = 1;
train_error = zeros(1,loop);
test_error = zeros(1,loop);
tic
for i = 1:loop
%% Setup
%rng(1,'twister');
sequenceLength = 2000;
memoryLength = 10;
nodes = 30;
theta = 0.01;
config.memoryLength = '{10,5}'; %[0,0.5]
[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequenceLength, memoryLength);

%% Time-multiplexing
config.masking_type = 'Binary Mask';  % select between 'Binary Mask','Random Mask','Sample and Hold'
[system_inputSequence] = TimeMultiplexing(inputSequence,nodes,sequenceLength,theta,config);

%% Run Mackey-Glass in Simulink
TFinal = theta * sequenceLength * nodes;
coupling = 5;
decay_rate = 1;
n = 1.2; % Nonlinearity
config.connect_type = '30'; % Connectivity: '30','15','10','5','2'
[state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,config);

%% Training
[system_train_output_sequence,target_train_output_sequence,system_test_sequence,target_test_output_sequence] ...
    = train_test(state_matrix, outputSequence, sequenceLength, nodes);

%% Evaluation
config.err_type = 'NRMSE';
    train_error(i) = calculateError(system_train_output_sequence,target_train_output_sequence,config)
    test_error(i) = calculateError(system_test_sequence,target_test_output_sequence,config)
    
% %% Demultiplexing
% system_test_sequence = system_test_sequence(:,1);
% target_test_output_sequence = target_test_output_sequence(:,1);
% 
% plot(system_test_sequence(100:200));
% hold on;
% plot(target_test_output_sequence(100:200));

toc
end
% err = mean(err(i))
% boxplot(err)