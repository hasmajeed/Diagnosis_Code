function [feature3_val_benign,feature3_val_malignant]=gen_feature_three_val(dummy3_val_benign,dummy3_val_malignant,PCA_coeff,index)
M=[dummy3_val_benign;dummy3_val_malignant];
%[PCA_coeff_val,score_val,latent_val,~,explained_val]=pca(M);
score_val=M*PCA_coeff;
means_val = mean(score_val,1);
for num=1:1:size(score_val,1)
score_val(num,:)=score_val(num,:) - means_val;
end
index
feature3_val_benign = score_val(1:size(dummy3_val_benign,1),index(1:50));
feature3_val_malignant = score_val(size(dummy3_val_benign,1)+1:end,index(1:50));
end