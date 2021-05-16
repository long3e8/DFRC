%% NARMA-10 Benchmark Task
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.

clear
close all
rng(1,'twister');

loop = 10;
train_error = zeros(1,loop);
test_error = zeros(1,loop);
tic
for i = 1:loop
%% Setup

%rng(1,'twister');
sequenceLength = 2000;
memoryLength = 10;
nodes = 30;
theta = 0.06;
config.memoryLength = '{10,5}'; %[0,0.5]
[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequenceLength, memoryLength);

%% Time-multiplexing

config.masking_type = 'Binary Mask';  % select between 'Binary Mask','Random Mask','Sample and Hold'
[system_inputSequence] = TimeMultiplexing(inputSequence,nodes,sequenceLength,theta,config);

%% Run Mackey-Glass in Simulink

TFinal = theta * sequenceLength * nodes;
coupling = 2;
decay_rate = 1;
n = 9.65; % Nonlinearity
config.connect_type = '30'; % Connectivity: '30','15','10','5','2'
[state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,config);

%% Training --- ridge regression Wout = BA'(AA'-λI)^-1

[system_train_output_sequence,target_train_output_sequence,system_test_output_sequence,target_test_output_sequence] ...
    = train_test(state_matrix, outputSequence, sequenceLength, nodes);

%% Evaluation

config.err_type = 'NRMSE';
    train_error(i) = calculateError(system_train_output_sequence,target_train_output_sequence,config);
    test_error(i) = calculateError(system_test_output_sequence,target_test_output_sequence,config);
    
%% Demultiplexing

config.plot_type = 'test set';
[target_plot,system_plot] = demultiplexing(system_train_output_sequence,target_train_output_sequence,...
    system_test_output_sequence,target_test_output_sequence,config);

%% Plot

% plot(target_plot(850:950),'r--');
% hold on;
% plot(system_plot(850:950),'b')
% 
% xlabel('t')
% ylabel('x(t)')
% legend('target output','system output')
toc
end
train_err = mean(train_error(i))
test_err = mean(test_error(i))
% boxplot(train_error)