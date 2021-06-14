load nonoffset_BM.mat;
load offset_BM.mat;
[p,h,stats] = ranksum(nonoffset_BM(:,3),nonoffset_BM(:,2));

d = computeCohen_d(nonoffset_BM(:,2),nonoffset_BM(:,3), 'independent');