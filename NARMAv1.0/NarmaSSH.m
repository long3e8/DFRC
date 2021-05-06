% NARMA-10 Sample & Hold (√), Masking (×)
% To run NARMA equation
sequence_length = 5000;
memory_length = 10;
Nodes = 30;
% split of data set 60/20/20 train/val/test
config.train_fraction=0.6; config.val_fraction=0.2; config.test_fraction=0.2;
[inputSequence, outputSequence] = generate_new_NARMA_sequence(sequence_length,memory_length,0,0.5);
config.memoryLength = '{10,5}'; %[0,0.5]

start_time = 0; % Starting time --- in order to make T = TFinal
step_size = 0.01; % Step
N = sequence_length * Nodes; % Number of values
timeline = start_time + step_size*(0:N-1); % Generate time in matrix
% Sample & Hold
inputSequence = repelem (inputSequence,Nodes);
inputSequence = [timeline(:),inputSequence(:)];

% Run Mackey-Glass simulation
TDelay = step_size;
TFinal = step_size*N;
sim('MG1.slx');

% Training
% For N nodes and k time steps, the result is a (N*k)-dimensional reservoir state matrix
res_matrix = [ans.simout1 ans.simout].';
res_matrix(:,1) = [];
res_matrix = flipud(res_matrix);
% Moore-Penrose pseudo-inverse, which allows to avoid problems with
% ill-conditioned matrices.
% Weighted average of matrix
yt = repelem(outputSequence,Nodes).';
res_mpp_matrix = pinv(res_matrix);
w = yt * res_mpp_matrix;

% Demultiplexing
system_output = w * res_matrix;
yt = yt(1:Nodes:end,1:Nodes:end);
system_output = system_output(1:Nodes:end,1:Nodes:end);

% Error between NARMA and Simulink model
nrmse_err = sqrt((sum((yt-system_output).^2)/(var(yt)))*(1/length(yt)))
% nmse_err = mean((yt-system_output).^2)/var(yt)

figure(1);
 plot(system_output(1100:1200));
 hold on;
 plot(yt(1100:1200));
 legend('System Output','Desired Output');