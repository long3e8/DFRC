% This script makes box plots of MG reservoir with different read-out
% connectivies

A = matfile('sh_output(30).mat');
A = A.sh_err;

B = matfile('sh_output(15).mat');
B = B.sh_err;

C = matfile('sh_output(10).mat');
C = C.sh_err;

D = matfile('sh_output(5).mat');
D = D.sh_err;

E = matfile('sh_output(2).mat');
E = E.sh_err;

T = [E;D;C;B;A];

% Plot
boxplot(T','Labels',{'2','5','10','15','30'},'Whisker',1)
xlabel('Connectivity')
ylabel('NRMSE')
title('Time-multiplexing = Sample & Hold')