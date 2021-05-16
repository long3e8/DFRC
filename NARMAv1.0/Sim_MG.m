function [state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,config)

TFinal = TFinal;
coupling = coupling;
decay_rate = decay_rate;
n = n;

sim('MG1.slx');

% For N nodes and k time steps, the result is a (N*k)-dimensional reservoir state matrix
switch(config.connect_type)
    
    case '30'
        state_matrix = [ans.simout1].';
        state_matrix(:,1) = [];
        state_matrix = flipud(state_matrix); 

    case '15'
        state_matrix = [ans.simout3].';
        state_matrix(:,1) = [];
        state_matrix = flipud(state_matrix); 
        
    case '10'
        state_matrix = [ans.simout4,ans.simout5].';
        state_matrix(:,1) = [];
        state_matrix = flipud(state_matrix);
        
    case ''
        
        
    otherwise
        state_matrix = [];
        

end