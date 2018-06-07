[feature3_ordered_benign_tr12,feature3_ordered_malignant_tr12,PCA_coeff,index]=gen_feature_three_tr(feature3_tr12_benign,feature3_tr12_malignant);
[feature3_ordered_benign_val1,feature3_ordered_malignant_val1]=gen_feature_three_val(feature3_val1_benign,feature3_val1_malignant,PCA_coeff,index);
figure;
plot3(feature1_tr12_benign,feature2_tr12_benign,feature3_ordered_benign_tr12(:,1),'b*');
hold on;
plot3(feature1_tr12_malignant,feature2_tr12_malignant,feature3_ordered_malignant_tr12(:,1),'r*');
xlim([0 12]);
ylim([0 0.1]);
title('Training Space');
legend('Benign','Malignant');

benign_indexes=find(gland_labels_val1_benign.gland_labels_benign==1);
hyp_indexes=find(gland_labels_val1_benign.gland_labels_benign==2);
dys_indexes=find(gland_labels_val1_malignant.gland_labels_malignant==3);
malig_indexes=find(gland_labels_val1_malignant.gland_labels_malignant==4);

figure;
plot3(feature1_val1_benign,feature2_val1_benign,feature3_ordered_benign_val1(:,1),'b*');
hold on;
plot3(feature1_val1_malignant,feature2_val1_malignant,feature3_ordered_malignant_val1(:,1),'r*');
%{
hold on;
plot3(feature1_val1_benign(hyp_indexes),feature2_val1_benign(hyp_indexes),feature3_ordered_benign_val1((hyp_indexes),2),'b*');
hold on;
plot3(feature1_val1_malignant(dys_indexes),feature2_val1_malignant(dys_indexes),feature3_ordered_malignant_val1((dys_indexes),2),'r*');
hold on;
plot3(feature1_val1_malignant(malig_indexes),feature2_val1_malignant(malig_indexes),feature3_ordered_malignant_val1((malig_indexes),2),'black*');
%}
xlim([0 12]);
ylim([0 0.08]);
xlabel('<l_{s}>[\mum]');
ylabel('<C>[pixel^{-1}]');
zlabel('PC1<T>');
title('Validation Space');
legend('Low risk','High risk');


figure;
plot(feature3_ordered_benign_val1(benign_indexes,2),feature3_ordered_benign_val1(benign_indexes,1),'g*');
hold on;
plot(feature3_ordered_benign_val1(hyp_indexes,2),feature3_ordered_benign_val1(hyp_indexes,1),'b*');
hold on;
plot(feature3_ordered_malignant_val1(dys_indexes,2),feature3_ordered_malignant_val1(dys_indexes,1),'m*');
hold on;
plot(feature3_ordered_malignant_val1(malig_indexes,2),feature3_ordered_malignant_val1(malig_indexes,1),'r*');