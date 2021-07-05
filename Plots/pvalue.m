load nonoffset_BM.mat;
load nonoffset_RM.mat;

load offset_BM.mat;
load offset_RM.mat;
[p,h,stats] = ranksum(BM(:,3),nonoffset_BM(:,3),'alpha',0.05);

% d = computeCohen_d(RM(:,3),BM(:,3), 'paired');

M = size(BM(:,3),1);
N = size(nonoffset_BM(:,3),1);

A = (stats.ranksum/N - (N+1)/2)/M;