function [masking] = TimeMultiplexing(inputSequence,sequenceLength,nodes,config)

switch(config.masking_type)
   
    case '1' % Sample and Hold
        masking = repelem (inputSequence,nodes);
        
        
    case '2' % Binary Masking
        AinputSequence = repelem (inputSequence,nodes);
        r = randi([-1 1],nodes,1);
        Amasking = repmat(r,sequenceLength,1);

        masking = Amasking .* AinputSequence + AinputSequence;

    case '3' % Random Masking
        
        AinputSequence = repelem (inputSequence,nodes);
        r = -1 + (1+1)*rand(nodes,1);
        Amasking = repmat(r,sequenceLength,1);
        masking = Amasking .* AinputSequence + AinputSequence;

        
        otherwise
        
        masking = [];

end