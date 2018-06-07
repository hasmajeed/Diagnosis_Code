function [feature3_tr_benign,feature3_tr_malignant,PCA_coeff,index]=gen_feature_three_tr(temp3_tr_benign,temp3_tr_malignant)
PCA_matrix = [temp3_tr_benign;temp3_tr_malignant];
[PCA_coeff,score,latent,~,explained] = pca(PCA_matrix);
for num=1:1:size(PCA_matrix,2)
[h,p(num)] = ttest2(score(1:length(temp3_tr_benign),num),score(length(temp3_tr_benign)+1:end,num));
end
%figure;
%plot(p,'black*');
[p_values_ascend,indexes_ascend]= sort(p,'ascend')
index=indexes_ascend;
%index=1;
feature3_tr_benign=score(1:length(temp3_tr_benign),index(1:50));
feature3_tr_malignant=score(length(temp3_tr_benign)+1:end,index(1:50));
end