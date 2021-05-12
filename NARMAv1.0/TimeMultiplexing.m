function [System_inputSequence] = TimeMultiplexing(inputSequence,Nodes,sequenceLength,theta,config)

    start_time = 0; % Starting time --- in order to make T = TFinal
    N = sequenceLength * Nodes; % Number of values
    timeline = start_time + theta*(0:N-1); % Generate time in matrix
    
switch(config.masking_type)
   
    case 'Sample and Hold'
        AinputSequence = repelem (inputSequence,Nodes);
        System_inputSequence = [timeline(:),AinputSequence(:)];
    
        
    case 'Binary Mask'
        
        inputSequence = repelem (inputSequence,Nodes);
        
        r = -0.02 + 0.1.*rand(Nodes,1);
        masking = repmat(r,sequenceLength,1);

        inputSequence = masking .* inputSequence + inputSequence;

        System_inputSequence = [timeline(:),inputSequence];

    case 'Random Mask'
        
        inputSequence = repelem (inputSequence,Nodes);
    
        r = rand(Nodes,1);
        masking = repmat(r,sequenceLength,1);
        BinputSequence = masking .* inputSequence + inputSequence;

        System_inputSequence = [timeline(:),BinputSequence];
        
        otherwise
        
        System_inputSequence = inputSequence;
end