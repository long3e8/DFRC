function [output_weights,system_train_output_sequence,target_train_state,system_test_output_sequence,...
    target_test_state,target_matrix] = train_test_try(state_matrix, outputSequence,ratio,connect_nodes)


% Split split of data set 60/20 train/test
system_train_state = state_matrix(:,1:0.6*length(outputSequence)*ratio); % A ∈ 
system_test_state = state_matrix(:,0.6*length(outputSequence)*ratio +1:length(outputSequence)*ratio); % C ∈

%% Target output matrix

% if Wout = [M x Ni]: bm '30'~0.2709 ; '15'~0.5554 ; '10'~0.7256 ---matrix
% does make sense, but not the result?
% target = [M x k]
% target_matrix = repmat(outputSequence,1,length(outputSequence)*ratio);

% ------------------------------------------------------------------------

% if Wout = [M*ratio x Ni], e.g. [6000 x 15] => constant 90000 weights
% target = [M*ratio x k]
% in total. 2 ways to resize : 1. a b a b 2. a a b b

% 1. a b a b: umm not reasonable. bm '30'~0.2709 ; '15'~0.5554 ; '10'~0.7256
% target_matrix = repmat(outputSequence,1,length(outputSequence)*ratio);
% target_matrix = [target_matrix;target_matrix];

% 2. a a b b: rm '30'~0.2709 ; '15'~0.5554 ; '10'~0.7256
% This method x
% target_matrix = repmat(outputSequence,1,length(outputSequence)*ratio);
% target_matrix = kron(target_matrix,ones(2,1));

% ------------------------------------------------------------------------

% if Wout = [M/ratio x Ni], e.g. [1500 x 15] [1000 x 10]
% target = [M/ratio x k] , 2 ways:

% 1. [3000 x 1] => [1500 x 2] first 
% bm '30'~0.2709 ; '15'~0.5537 ;
% '10'~0.5095 ; '5'~0.3289 ; '2'~0.1467
% target_matrix = reshape(outputSequence,[],ratio);
% target_matrix = repmat(target_matrix,1,length(outputSequence));

% 2. reshape => kron bm '30'~0.2709 ; '15'~0.4733 ; '10'~0.5477
% target_matrix = reshape(outputSequence,[],ratio);
% target_matrix = kron(target_matrix,ones(1,length(outputSequence)));

% ------------------------------------------------------------------------

% if Wout = [M/Ni x Ni] total no. of weights would be constant.
% '30'~0.3075 ; '15'~0.3273 ; '10'~0.3543 ; '5'~0.3787 ; '2'~0.3565
target_matrix = reshape(outputSequence,[],connect_nodes);
target_matrix = repmat(target_matrix,1,length(outputSequence)*ratio/connect_nodes); 


% Split into train and test data set
target_train_state = target_matrix(:,1:0.6*length(outputSequence)*ratio);
target_test_state = target_matrix(:,1:0.4*length(outputSequence)*ratio);

% Find best reg parameter
reg_param = [10e-1 10e-3 10e-5 10e-7 10e-9 10e-11];

    for i = 1:length(reg_param)
        % Training --- Ridge Regression Wout = BA'(AA'-λI)^-1
%         output_weights = target_train_state*system_train_state'* ...
%             inv(system_train_state*system_train_state' + reg_param(i)*eye(size(system_train_state*system_train_state')));
        
        %% Training --- Moore–Penrose pseudo-inverse Wout = B * pinv(A) --- 
        output_weights = target_train_state * pinv(system_train_state);
        
        %% Trained system output
        system_train_output_sequence = output_weights * system_train_state;
       
    end
    
    %%remove NaNs
    output_weights(isnan(output_weights)) = 0;
    
    %% System test matrix
    system_test_output_sequence = output_weights * system_test_state;
    
    
end