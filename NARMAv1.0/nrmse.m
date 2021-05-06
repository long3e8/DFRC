function err = nrmse(desired_output , system_output)


err= sqrt((sum((desired_output-system_output).^2)/(var(desired_output)))*(1/length(desired_output)));