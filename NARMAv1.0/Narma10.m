%% NARMA-10 Benchmark Task
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.

clear
close all

loop = 10;
train_err_2 = zeros(loop,3);
test_err_2 = zeros(loop,3);

rng(1,'twister');

% t1 = [2,5,10,15,30];
t2 = [1,2,3]; % Masking --- See TimeMultiplexing.m
for j = 1:3

for i = 1:loop
%% Setup
sequenceLength = 2000;
memoryLength = 10;
nodes = 30;
theta = 0.02;
tau = nodes * theta;
systemSequence = sequenceLength*nodes;
config.memoryLength = '{10,5}'; %[0,0.5]

[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequenceLength, memoryLength);
% outputSequence = kron(outputSequence, ones(2,1));
%% Time-multiplexing
% config.masking_type = '3'; % select between '1 = Sample and Hold','2 = Binary Mask','3 = Random Mask'
config.masking_type = num2str(t2(j));  
[system_inputSequence] = TimeMultiplexing(inputSequence,nodes,sequenceLength,theta,config);

%% Run Mackey-Glass in Simulink

TFinal = theta * sequenceLength * nodes;
coupling = 2;
decay_rate = 1;

sample_time = tau/15;  % '30'=tau ; '15'=tau/2 ; '10'=tau/3 ; '5'=tau/6 ; '2'=tau/15 !!
n = 9.65; % Nonlinearity

% config.connect_type = num2str(t1(j)); % Connectivity: '30','15','10','5','2'
config.connect_type = '2';
[state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,tau,config);

%% Training --- ridge regression Wout = BA'(AA'-λI)^-1 / pseudo-inverse Wout =  pinv(A) * B

[output_weights,system_train_output_sequence,target_train_state,system_test_output_sequence,...
    target_test_state] = train_test(state_matrix, outputSequence, systemSequence);

%% Evaluation

config.err_type = 'NRMSE';
    train_error = calculateError(system_train_output_sequence,target_train_state,config);
    test_error = calculateError(system_test_output_sequence,target_test_state,config);
    
    train_err_2(i,j) = train_error;
    test_err_2(i,j) = test_error;
%% Demultiplexing

% config.plot_type = 'test set';
% [target_plot,system_plot] = demultiplexing(system_train_output_sequence,target_train_output_sequence,...
%     system_test_output_sequence,target_test_output_sequence,config);

%% Plot

% plot(target_plot(850:950),'r');
% hold on;
% plot(system_plot(850:950),'b--')
% 
% xlabel('t')
% ylabel('x(t)')
% legend('target output','system output')


end
end
save 'bkpp_2.mat' test_err_2 train_err_2