function [output_weights,system_train_output_sequence,target_train_output_sequence,system_test_output_sequence,...
    target_test_output_sequence] = train_test(state_matrix, outputSequence, sequenceLength, nodes)

% Split split of data set 60/20 train/test
system_train_state = state_matrix(:,1:0.6*nodes*sequenceLength); % A ∈ 
system_test_state = state_matrix(:,0.6*nodes*sequenceLength +1:0.8*nodes*sequenceLength); % C ∈

% Target output matrix
target_train_matrix = repmat(outputSequence,1,0.6*nodes); % concatenation of outputSequence: Bl
target_train_output_sequence = repmat(target_train_matrix,1,sequenceLength);  % concatenation of outputSequence: B ∈
target_test_matrix = repmat(outputSequence,1,0.2*nodes);
target_test_output_sequence = repmat(target_test_matrix,1,sequenceLength); % D ∈

% Find best reg parameter
reg_param = [10e-1 10e-3 10e-5 10e-7 10e-9 10e-11];

    for i = 1:length(reg_param)
        % Training --- Ridge Regression Wout = BA'(AA'-λI)^-1
        output_weights = target_train_output_sequence*system_train_state'* ...
            inv(system_train_state*system_train_state' + reg_param(i)*eye(size(system_train_state*system_train_state')));
        
        % Training --- Moore–Penrose pseudo-inverse Wout = B * pinv(A) --- 
%         output_weights = target_train_output_sequence * pinv(system_train_state) ;
        
        % Trained system output
        system_train_output_sequence = output_weights*system_train_state;
       
    end
    
    %remove NaNs
    output_weights(isnan(output_weights)) = 0;

    system_test_output_sequence = output_weights * system_test_state;
    
    
end