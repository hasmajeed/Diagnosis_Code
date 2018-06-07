function [AUC,Sens,Spec,score_builtin]=train_data_DCIS(feature,labels,feature_val,labels_val)

classifier_lda=fitcdiscr(feature,labels,'discrimType','pseudoLinear');
K = classifier_lda.Coeffs(1,2).Const;
L = classifier_lda.Coeffs(1,2).Linear;

L;
K;

[labels_builtin,score_builtin,cost_builtin]=predict(classifier_lda,feature_val);

title('vote');
[Sens,Spec,T,AUC] = perfcurve(labels_val,score_builtin(:,2),2);
%figure;
%plot(Sens,Spec);
%title('ROC Curve');
end