%% NARMA-10 Sample & Hold (√), Random Masking (√)
% This script is used to run NARMA-10 benchmark on Mackey-Glass dynamical
% system with Simulink tool.
clear
close all

% rng(1,'twister');
loop = 10;
err = zeros(1,loop);
tic
for l = 1:loop
%% Setup

sequence_length = 5000;
memory_length = 10;
Nodes = 30;
% split of data set 60/20/20 train/val/test
config.train_fraction=0.6; config.val_fraction=0.2; config.test_fraction=0.2;
[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequence_length,memory_length);

config.memoryLength = '{10,5}'; %[0,0.5]

%% input Sequence with time dimension
% Generating time data to input
start_time = 0; % Starting time --- in order to make T = TFinal
step_size = 0.01; % Step
N = sequence_length * Nodes; % Number of values
T = start_time+step_size*(0:N-1); % Generate time in matrix
AinputSequence = repelem (inputSequence,Nodes);

%% Masking ()
r = rand(Nodes,1);
masking = repmat(r,sequence_length,1);
BinputSequence = masking .* AinputSequence + AinputSequence;

inputSequence = [T(:),BinputSequence];

%% Run Mackey-Glass simulation
B = 0.32;
G = 0.55;
n = 0.002;
TDelay = step_size;
TFinal = step_size*N;
sim('MG1.slx');

%% Training
% For N nodes and k time steps, the result is a (N*k)-dimensional reservoir state matrix
res_matrix = [ans.simout1].';
res_matrix(:,1) = [];
% Morore-Penrose pseudo-inverse, which allows to avoid problems with
% ill-conditioned matrices.
% Weighted average of matrix
yt = repelem(outputSequence,Nodes).';
res_mpp_matrix = pinv(res_matrix);
w = yt * pinv(res_matrix);

system_output = w * res_matrix;

%% Demultiplexing
yt = yt(1:Nodes:end,1:Nodes:end);
system_output = system_output(1:Nodes:end,1:Nodes:end);

%% Error between NARMA and Simulink model
config.err_type = 'NRMSE';
rm_err(l) = calculateError(system_output,yt,config);
toc
end

%% Plot
% figure(1);
%  plot(system_output(800:950));
%  hold on;
%  plot(yt(800:950));
%  legend('System Output','Desired Output');