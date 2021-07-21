function [state_matrix] = Sim_MG(coupling,decay_rate,n,TFinal,tau,connect_nodes,ratio,config)

TFinal = TFinal;
coupling = coupling;
decay_rate = decay_rate;
tau = tau;
n = n;

% sim('MG_Damping_18a.slx'); % Delay line with damping
% sim('MG_lossless.slx'); % Lossless transmission line
% sim('MackeyGlass.slx'); % ideal delay line
sim('TapDL_resistor.slx'); % ideal tapped delay line with resistors


switch(config.connect_type)
    
    case '30'
       
        state_matrix = [ans.simout,ans.simout1,ans.simout2,ans.simout3,ans.simout4,...
                        ans.simout5,ans.simout6,ans.simout7,ans.simout8,ans.simout9,...
                        ans.simout10,ans.simout11,ans.simout12,ans.simout13,ans.simout14,...
                        ans.simout15,ans.simout16,ans.simout17,ans.simout18,ans.simout19,...
                        ans.simout20,ans.simout21,ans.simout22,ans.simout23,ans.simout24,...
                        ans.simout25,ans.simout26,ans.simout27,ans.simout28,ans.simout29]';
        state_matrix(:,1) = [];
        state_matrix = reshape (state_matrix,connect_nodes*ratio,[]);

%     case '15'
%         state_matrix = [ans.simout,ans.simout2,ans.simout4,ans.simout6,ans.simout8,ans.simout10,...
%                         ans.simout12,ans.simout14,ans.simout16,ans.simout18,ans.simout20,ans.simout22,...
%                         ans.simout24,ans.simout26,ans.simout28 ; ans.simout1,ans.simout3,ans.simout5,...
%                         ans.simout7,ans.simout9,ans.simout11,ans.simout13,ans.simout15,ans.simout17,...
%                         ans.simout19,ans.simout21,ans.simout23,ans.simout25,ans.simout27,ans.simout29].';
%         state_matrix(:,1) = [];
%         state_matrix = flipud(state_matrix); 

     case '15'

        state_matrix = [ans.simout,ans.simout1,ans.simout2,ans.simout3,ans.simout4,...
                        ans.simout5,ans.simout6,ans.simout7,ans.simout8,ans.simout9,...
                        ans.simout10,ans.simout11,ans.simout12,ans.simout13,ans.simout14]';
        state_matrix(:,1) = [];
        state_matrix = reshape (state_matrix,connect_nodes*ratio,[]);
%     case '10'
%         state_matrix = [ans.simout,ans.simout3,ans.simout6,ans.simout9,ans.simout12,ans.simout15,ans.simout18,...
%                         ans.simout21,ans.simout24,ans.simout27 ; ans.simout1,ans.simout4,ans.simout7,ans.simout10,...
%                         ans.simout13,ans.simout16,ans.simout19,ans.simout22,ans.simout25,ans.simout28 ; ans.simout2,...
%                         ans.simout5,ans.simout8,ans.simout11,ans.simout14,ans.simout17,ans.simout20,ans.simout23,...
%                         ans.simout26,ans.simout29].';
%         state_matrix(:,1) = [];
%         state_matrix = flipud(state_matrix);

    case '10'
        state_matrix = [ans.simout,ans.simout1,ans.simout2,ans.simout3,ans.simout4,...
                        ans.simout5,ans.simout6,ans.simout7,ans.simout8,ans.simout9]';
        state_matrix(:,1) = [];
        state_matrix = reshape (state_matrix,connect_nodes*ratio,[]);


%     case '5'
%         state_matrix = [ans.simout,ans.simout6,ans.simout12,ans.simout18,ans.simout24 ; ans.simout1,ans.simout7,...
%                         ans.simout13,ans.simout19,ans.simout25 ; ans.simout2,ans.simout8,ans.simout14,ans.simout20,...
%                         ans.simout26 ; ans.simout3,ans.simout9,ans.simout15,ans.simout21,ans.simout27 ; ans.simout4,...
%                         ans.simout10,ans.simout16,ans.simout22,ans.simout28 ; ans.simout5,ans.simout11,ans.simout17,...
%                         ans.simout23,ans.simout29].';
%         state_matrix(:,1) = [];
%         state_matrix = flipud(state_matrix); 
    
     case '5'
        state_matrix = [ans.simout,ans.simout1,ans.simout2,ans.simout3,ans.simout4]';
        state_matrix(:,1) = [];
        state_matrix = reshape (state_matrix,connect_nodes*ratio,[]);
        
%     case '2'
%         
%         state_matrix = [ans.simout,ans.simout15;ans.simout1,ans.simout16;ans.simout2,ans.simout17;...
%                         ans.simout3,ans.simout18;ans.simout4,ans.simout19;ans.simout5,ans.simout20;...
%                         ans.simout6,ans.simout21;ans.simout7,ans.simout22;ans.simout8,ans.simout23;...
%                         ans.simout9,ans.simout24;ans.simout10,ans.simout25;ans.simout11,ans.simout26;...
%                         ans.simout12,ans.simout27;ans.simout13,ans.simout28;ans.simout14,ans.simout29].';
%         state_matrix(:,1) = [];
%         state_matrix = flipud(state_matrix);
        
    case '2'
        
        state_matrix = [ans.simout,ans.simout1]';
        state_matrix(:,1) = [];
        state_matrix = reshape (state_matrix,connect_nodes*ratio,[]);
        
    case '1'
        state_matrix = [ans.simout]';
        state_matrix(:,1) = [];
        state_matrix = reshape (state_matrix,connect_nodes*ratio,[]);
        
    otherwise
        state_matrix = [];
        

end