function [system_output_sequence,target_output_sequence] = train_test(state_matrix, outputSequence, sequenceLength, nodes)

% Split split of data set 60/20/20 train/test
train_state = state_matrix(:,1:0.6*nodes*sequenceLength);
test_state = state_matrix(:,0.6*nodes*sequenceLength +1:nodes*sequenceLength);

target_matrix = repmat(outputSequence,1,0.6*nodes); % concatenation of outputSequence: Bl
target_output_sequence = repmat(target_matrix,1,sequenceLength);  % concatenation of outputSequence: B

reg_param = [10e-1 10e-3 10e-5 10e-7 10e-9 10e-11];

    for i = 1:length(reg_param)
        %Train: tanspose is inversed compared to equation
        output_weights = target_output_sequence*train_state'*inv(train_state*train_state' + reg_param(i)*eye(size(train_state*train_state')));
        
        % Trained system output
        system_output_sequence = output_weights*train_state;
       
    end
    output_weights(isnan(output_weights)) = 0;
    
    
end