function [target_plot,system_plot] = demultiplexing(system_train_output_sequence,target_train_state,...
    system_test_output_sequence,target_test_state,config)

switch(config.plot_type)

    case 'train set'
        system_plot = system_train_output_sequence(:,2);
        target_plot = target_train_state(:,2);
        
    case 'test set'
        system_plot = system_test_output_sequence(:,1);
        target_plot = target_test_state(:,1);
    
    otherwise
        target_plot = [];
        system_plot = [];
end