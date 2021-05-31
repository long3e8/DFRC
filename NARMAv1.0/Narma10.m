%% NARMA-10 Benchmark Task
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.

clear
close all

loop = 30; % Runs
train_err_ipytm2 = zeros(loop,3);
test_err_ipytm2 = zeros(loop,3); % (loop, 3 for mask / 5 for sampling)

rng(1,'twister'); 

% sampling = [2,5,10,15,30];
mask = [1,2,3]; % Masking --- See TimeMultiplexing.m
for i = 1:loop
% rng(1,'twister'); % For same input data (every loop), different mask
for j = 1:3
%% Setup
sequenceLength = 3000;
memoryLength = 10;
nodes = 30;
theta = 0.06;
tau = nodes * theta;

config.memoryLength = '{10,5}'; %[0,0.5]

[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequenceLength, memoryLength);

%% Time-multiplexing
% config.masking_type = '3'; % select between '1 = Sample and Hold','2 = Binary Mask','3 = Random Mask'
config.masking_type = num2str(mask(j));
[masking,system_inputSequence] = TimeMultiplexing(inputSequence,sequenceLength,theta,nodes,config);

%% Run Mackey-Glass in Simulink

TFinal = theta * sequenceLength * nodes;
coupling = 2;
decay_rate = 1;
n = 9.65; % Nonlinearity

% connect_nodes = sampling(j);  %-- For vary sampling
connect_nodes = 2;
ratio = nodes/connect_nodes;
config.connect_type = '2';
% config.connect_type = num2str(sampling(j)); % Connectivity: '30','15','10','5','2'
sample_time = tau/ratio; % '30'=tau ; '15'=tau/2 ; '10'=tau/3 ; '5'=tau/6 ; '2'=tau/15 ;'1'=tau/30
[state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,tau,connect_nodes,ratio,config);

%% Training --- ridge regression Wout = BA'(AA'-λI)^-1 / pseudo-inverse Wout =  B * pinv(A)
% [output_weights,system_train_output_sequence,target_train_state,system_test_output_sequence,...
%     target_test_state,target_matrix] = train_test(state_matrix, outputSequence,connect_nodes,ratio);

[output_weights,system_train_output_sequence,target_train_state,system_test_output_sequence,...
    target_test_state,target_matrix] = train_test_try(state_matrix,outputSequence);

%% Evaluation

config.err_type = 'NRMSE';
    train_error = calculateError(system_train_output_sequence,target_train_state,config);
    test_error = calculateError(system_test_output_sequence,target_test_state,config);
    
    train_err_ipytm2(i,j) = train_error;
    test_err_ipytm2(i,j) = test_error;
% %% Demultiplexing
% 
% config.plot_type = 'test set';
% [target_plot,system_plot] = demultiplexing(system_train_output_sequence,target_train_state,...
%     system_test_output_sequence,target_test_state,config);
% 
% %% Plot
% 
% plot(target_plot(850:950),'r');
% hold on;
% plot(system_plot(850:950),'b--')
% 
% xlabel('t')
% ylabel('x(t)')
% legend('target output','system output')


end
end
 save 'bkpp_ipytm_2.mat' test_err_ipytm2 train_err_ipytm2