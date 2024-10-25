function [fractional_occupancy, mean_life, mean_life_var, Counters] = summary_stats_fast(z,stateSet)

K = numel(stateSet);
T = length(z);
fractional_occupancy = zeros(1,K);
mean_life = zeros(1,K);
Counters = zeros(1,K);
for i = 1:K
    k = stateSet(i);
    ix = find(z == k);
    if ~isempty(ix)
        fractional_occupancy(i) = length(ix)/T;
    end
temp = bwconncomp(diag(z == k));
 counter = temp.NumObjects;

    Counters(i) = counter;
    if counter > 0
        mean_life(i) = length(ix)/counter;
    else
        mean_life(i) = 0;
    end
    % add by zeng
    life_length =0;
    for j=1:length(temp.PixelIdxList)
       life_length(j) = length(temp.PixelIdxList{1,j});
    end
    mean_life_var(i) = std(life_length);
end
