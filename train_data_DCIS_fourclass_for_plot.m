function [scores_builtin_b,scores_builtin_h,scores_builtin_d,scores_builtin_m]=train_data_DCIS_fourclass_for_plot(feature,labels,feature_val,labels_val,four_class_label_val)

classifier_lda=fitcdiscr(feature,labels,'discrimType','pseudoLinear');
K = classifier_lda.Coeffs(1,2).Const;
L = classifier_lda.Coeffs(1,2).Linear;

L;
K;

[labels_builtin,score_builtin,cost_builtin]=predict(classifier_lda,feature_val);
b_samples_in_val=find(four_class_label_val==1);
h_samples_in_val=find(four_class_label_val==2);
d_samples_in_val=find(four_class_label_val==3);
m_samples_in_val=find(four_class_label_val==4);
scores_builtin_b=score_builtin(b_samples_in_val,2);
scores_builtin_h=score_builtin(h_samples_in_val,2);
scores_builtin_d=score_builtin(d_samples_in_val,2);
scores_builtin_m=score_builtin(m_samples_in_val,2);

perf_hd=[scores_builtin_h;scores_builtin_d];
perf_hm=[scores_builtin_h;scores_builtin_m];
perf_bm=[scores_builtin_b;scores_builtin_m];
perf_bd=[scores_builtin_b;scores_builtin_d];
perf_bh=[scores_builtin_b;scores_builtin_h];
perf_dm=[scores_builtin_d;scores_builtin_m];
labels_hd=[ones(size(scores_builtin_h));2*ones(size(scores_builtin_d))];
labels_hm=[ones(size(scores_builtin_h));2*ones(size(scores_builtin_m))];
labels_bm=[ones(size(scores_builtin_b));2*ones(size(scores_builtin_m))];
labels_bd=[ones(size(scores_builtin_b));2*ones(size(scores_builtin_d))];
labels_bh=[ones(size(scores_builtin_b));2*ones(size(scores_builtin_h))];
labels_dm=[ones(size(scores_builtin_d));2*ones(size(scores_builtin_m))];


end