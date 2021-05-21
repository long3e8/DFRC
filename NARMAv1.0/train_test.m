function [output_weights,system_train_output_sequence,target_train_state,system_test_output_sequence,...
    target_test_state] = train_test(state_matrix, outputSequence, systemSequence)

connect = 2;

% Split split of data set 60/20 train/test
system_train_state = state_matrix(:,1:0.6*systemSequence/connect); % A ∈ 
system_test_state = state_matrix(:,0.6*systemSequence/connect +1:systemSequence/connect); % C ∈

% Target output matrix
% target_matrix = outputSequence';
target_matrix = repmat(outputSequence,1,systemSequence/connect); % concatenation of outputSequence: Bl
target_train_state = target_matrix(:,1:0.6*systemSequence/connect);
target_test_state = target_matrix(:,1:0.4*systemSequence/connect);

% Find best reg parameter
reg_param = [10e-1 10e-3 10e-5 10e-7 10e-9 10e-11];

    for i = 1:length(reg_param)
        % Training --- Ridge Regression Wout = BA'(AA'-λI)^-1
%         output_weights = target_train_state*system_train_state'* ...
%             inv(system_train_state*system_train_state' + reg_param(i)*eye(size(system_train_state*system_train_state')));
        
        % Training --- Moore–Penrose pseudo-inverse Wout = B * pinv(A) --- 
        output_weights = target_train_state * pinv(system_train_state);
        
        % Trained system output
        system_train_output_sequence = output_weights * system_train_state;
       
    end
    
    %remove NaNs
    output_weights(isnan(output_weights)) = 0;

    system_test_output_sequence = output_weights * system_test_state;
    
    
end