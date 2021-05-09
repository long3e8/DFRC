A = matfile('bm_output(30).mat');
A = A.bm_err;

B = matfile('bm_output(15).mat');
B = B.bm_err;

C = matfile('bm_output(10).mat');
C = C.bm_err;

T = [A;B;C];

boxplot(T')
title('Time-multiplexing = ')