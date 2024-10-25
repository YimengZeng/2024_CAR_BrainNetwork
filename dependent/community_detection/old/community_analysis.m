nStates = str2num(stateSet{1});
for state=1:nStates
      sc(state) =  sum(estStates ==state);
end
counts_post = sc/sum(sc);
[percent_dominant, dominant_states] = sort(counts_post,'descend');
 
 
%Estimates of Covariance
for state= 1:nStates
      k = dominant_states(state);
      est_cov = dataCov{k};
      invD = inv(diag(sqrt(diag(est_cov))));
      pearson_corr(:,:,state) = invD*est_cov*invD;
      %Partial Correlation
      inv_est_cov = inv(est_cov);
      invD = inv(diag(sqrt(diag(inv_est_cov))));
      partial_corr(:,:,state) = -invD*inv_est_cov*invD;
end
dim = size(data{1},1);
est_network1 = zeros(dim,dim,nStates);
est_network2 = zeros(dim,dim,nStates);

for k=1:10
      [est_network2(:,:,k),nclust] = clusters_community_detection_Newman(partial_corr(:,:,k), 1);
%             [est_network2(:,:,k),nclust] = clusters_community_detection_JT(partial_corr(:,:,k), 1.21);

     numel( unique(nclust))
      figure;
      axis square 
       cca_plotcausality_MyVersion2(est_network2(:,:,k),roi_names,.5);
      axis off
end