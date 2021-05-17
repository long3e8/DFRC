function [state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,config)

TFinal = TFinal;
coupling = coupling;
decay_rate = decay_rate;
n = n;

sim('MG2.slx');

% For N nodes and k time steps, the result is a (N*k)-dimensional reservoir state matrix
switch(config.connect_type)
    
    case '30'
        state_matrix = [ans.simout,ans.simout1,ans.simout2,ans.simout3,ans.simout4,...
                        ans.simout5,ans.simout6,ans.simout7,ans.simout8,ans.simout9,...
                        ans.simout10,ans.simout11,ans.simout12,ans.simout13,ans.simout14,...
                        ans.simout15,ans.simout16,ans.simout17,ans.simout18,ans.simout19,...
                        ans.simout20,ans.simout21,ans.simout22,ans.simout23,ans.simout24,...
                        ans.simout25,ans.simout26,ans.simout27,ans.simout28,ans.simout29].';
        state_matrix(:,1) = [];
        state_matrix = flipud(state_matrix); 

    case '15'
        state_matrix = [ans.simout,ans.simout2,ans.simout4,ans.simout6,ans.simout8,ans.simout10,...
                        ans.simout12,ans.simout14,ans.simout16,ans.simout18,ans.simout20,ans.simout22,...
                        ans.simout24,ans.simout26,ans.simout28 ; ans.simout1,ans.simout3,ans.simout5,...
                        ans.simout7,ans.simout9,ans.simout11,ans.simout13,ans.simout15,ans.simout17,...
                        ans.simout19,ans.simout21,ans.simout23,ans.simout25,ans.simout27,ans.simout29].';
        state_matrix(:,1) = [];
        state_matrix = flipud(state_matrix); 
        
    case '10'
        state_matrix = [ans.simout4;ans.simout5;ans.simout6].';
        state_matrix(:,1) = [];
        state_matrix = flipud(state_matrix);
        
    case ''
        
        
    otherwise
        state_matrix = [];
        

end