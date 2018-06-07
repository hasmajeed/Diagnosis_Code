function [perf_hd,perf_hm,perf_bm,perf_bd,perf_bh,perf_dm,labels_hd,labels_hm,labels_bm,labels_bd,labels_bh,labels_dm]=train_data_DCIS_fourclass(feature,labels,feature_val,labels_val,four_class_label_val)

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

[Sens_dash_hd,Spec_dash_hd,T_dash_hd,AUC_dash_hd] = perfcurve([ones(size(scores_builtin_h));2*ones(size(scores_builtin_d))],[scores_builtin_h;scores_builtin_d],2);
[Sens_dash_hm,Spec_dash_hm,T_dash_hm,AUC_dash_hm] = perfcurve([ones(size(scores_builtin_h));2*ones(size(scores_builtin_m))],[scores_builtin_h;scores_builtin_m],2);
[Sens_dash_bm,Spec_dash_bm,T_dash_bm,AUC_dash_bm] = perfcurve([ones(size(scores_builtin_b));2*ones(size(scores_builtin_m))],[scores_builtin_b;scores_builtin_m],2);
[Sens_dash_bd,Spec_dash_bd,T_dash_bd,AUC_dash_bd] = perfcurve([ones(size(scores_builtin_b));2*ones(size(scores_builtin_d))],[scores_builtin_b;scores_builtin_d],2);
[Sens_dash_bh,Spec_dash_bh,T_dash_bh,AUC_dash_bh] = perfcurve([ones(size(scores_builtin_b));2*ones(size(scores_builtin_h))],[scores_builtin_b;scores_builtin_h],2);
[Sens_dash_dm,Spec_dash_dm,T_dash_dm,AUC_dash_dm] = perfcurve([ones(size(scores_builtin_d));2*ones(size(scores_builtin_m))],[scores_builtin_d;scores_builtin_m],2);


end