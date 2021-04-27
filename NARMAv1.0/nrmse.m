function nrmse(desired_output , system_output, N )


r = sqrt(sum((system_output(1:N) - desired_output(1:N)).^2 / numel(system_output)));