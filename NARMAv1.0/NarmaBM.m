%% NARMA-10 Sample & Hold (√), Binary Masking (√)
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.

clear
close all
rng(1,'twister');

loop = 1;
bm_err = zeros(1,loop);
tic
for i = 1:loop
    
%% Setup
% rng(1,'twister');
sequence_length = 5000;
memory_length = 10;
Nodes = 30;
% split of data set 60/20/20 train/val/test
config.train_fraction=0.6; config.val_fraction=0.2; config.test_fraction=0.2;
[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequence_length,memory_length,0,0.5);

config.memoryLength = '{10,5}'; %[0,0.5]

%% input Sequence with time dimension
% Generating time data to input
start_time = 0; % Starting time --- in order to make T = TFinal
theta = 0.01; % Step
N = sequence_length * Nodes; % Number of values
timeine = start_time+theta*(0:N-1); % Generate time in matrix
AinputSequence = repelem (inputSequence,Nodes);

%% Masking ()
r = -0.02 + 0.1.*rand(Nodes,1);
masking = repmat(r,sequence_length,1);

BinputSequence = masking .* AinputSequence + AinputSequence;

inputSequence = [timeine(:),BinputSequence];

%% Run Mackey-Glass in Simulink
B = 0.32;
G = 0.55;
n = 0.002;
TDelay = theta;
TFinal = theta*N;
sim('MG1.slx');

%% Training
% For N nodes and k time steps, the result is a (N*k)-dimensional reservoir
% state matrix
res_matrix = [ans.simout1].';
res_matrix(:,1) = [];

% Moore-Penrose pseudo-inverse, which allows to avoid problems with
% ill-conditioned matrices.
% Weighted average of matrix
yt = repelem(outputSequence,Nodes).';
w = yt * pinv(res_matrix);

system_output = w * res_matrix;

%% Demultiplexing
yt = yt(1:Nodes:end,1:Nodes:end);
system_output = system_output(1:Nodes:end,1:Nodes:end);

%% Error between NARMA and Simulink model
config.err_type = 'NRMSE';
bm_err(i) = calculateError(system_output,yt,config)
% save('bm_output(30).mat','bm_err');
toc
end
%% Plot
% figure(1);
%  plot(system_output(800:950));
%  hold on;
%  plot(yt(800:950));
%  legend('System Output','Desired Output');