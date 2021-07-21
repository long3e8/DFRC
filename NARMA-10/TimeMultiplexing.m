function [masking] = TimeMultiplexing(inputSequence,sequenceLength,nodes,config)

switch(config.masking_type)
   
    case '1' % Sample and Hold

        masking = repelem (inputSequence,nodes);
        
    case '2' % Binary Weight Masking
        
        AinputSequence = repelem (inputSequence,nodes);
        r = 2* randi(2,nodes,1)-1 -2;
        Amasking = repmat(r,sequenceLength,1);
        % Offset
        masking = Amasking .* AinputSequence + AinputSequence;
%         No-Offset
%         masking = Amasking .* AinputSequence; 

    case '3' % Random Weight Masking
        
        AinputSequence = repelem (inputSequence,nodes);
        r = -1 + (1+1)*rand(nodes,1);
        Amasking = repmat(r,sequenceLength,1);
        % Offset
        masking = Amasking .* AinputSequence + AinputSequence;
        % No-Offset
%         masking = Amasking .* AinputSequence; % M * u
        
    otherwise
        
        masking = [];

end