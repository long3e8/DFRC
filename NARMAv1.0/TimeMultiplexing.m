function [masking,system_inputSequence] = TimeMultiplexing(inputSequence,sequenceLength,theta,nodes,config)

    start_time = 0; % Starting time --- in order to make T = TFinal
    N = sequenceLength * nodes; % Number of values
    timeline = start_time + theta*(0:N-1); % Generate time in matrix


switch(config.masking_type)
   
    case '1' % Sample and Hold
        masking = repelem (inputSequence,nodes);
        system_inputSequence = [timeline(:),masking(:)];
    
        
    case '2' % Binary Masking
        
        inputSequence = repelem (inputSequence,nodes);
        r = randi([-1 1],nodes,1);
        masking = repmat(r,sequenceLength,1);

        masking = masking .* inputSequence + inputSequence;

        system_inputSequence = [timeline(:),masking];

    case '3' % Random Masking
        
        inputSequence = repelem (inputSequence,nodes);
        r = -1 + (1+1)*rand(nodes,1);
        masking = repmat(r,sequenceLength,1);
        masking = masking .* inputSequence + inputSequence;

        system_inputSequence = [timeline(:),masking];
        
        otherwise
        
        system_inputSequence = [];

end