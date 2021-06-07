function [masking] = TimeMultiplexing(inputSequence,sequenceLength,nodes,config)

switch(config.masking_type)
   
    case '1' % Sample and Hold
        masking = repelem (inputSequence,nodes);
        
        
    case '2' % Binary Masking
        AinputSequence = repelem (inputSequence,nodes);
        r = 2* randi(2,nodes,1)-1 -2;
%         r = randi([0,1],nodes,1);
        Amasking = repmat(r,sequenceLength,1);

%         masking = Amasking .* AinputSequence + AinputSequence;
        masking = Amasking .* AinputSequence; % M * u
    case '3' % Random Masking
        
        AinputSequence = repelem (inputSequence,nodes);
        r = -1 + (1+1)*rand(nodes,1);
        Amasking = repmat(r,sequenceLength,1);
        masking = Amasking .* AinputSequence + AinputSequence;
%         masking = Amasking .* AinputSequence; % M * u
        
        otherwise
        
        masking = [];

end