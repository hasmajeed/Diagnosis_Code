clc;
clear all;
close all;
cd('Z:\Hassaan\DCIS\B_vs_M_mycomputer\');
path_save='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_20textons\';
train_textons_glandwise(1,20);
train_textons_glandwise(2,20);
train_textons_glandwise(3,20);
getting_texton_image_glandwise(0,1,20);
getting_texton_image_glandwise(1,1,20);
getting_texton_image_glandwise(0,2,20);
getting_texton_image_glandwise(1,2,20);
getting_texton_image_glandwise(0,3,20);
getting_texton_image_glandwise(1,3,20);
generate_histograms_threefold_glandwise(0,0,1,20);
generate_histograms_threefold_glandwise(1,0,1,20);
generate_histograms_threefold_glandwise(0,0,2,20);
generate_histograms_threefold_glandwise(1,0,2,20);
generate_histograms_threefold_glandwise(0,0,3,20);
generate_histograms_threefold_glandwise(1,0,3,20);
[feature3_tr12_benign,feature3_tr12_malignant]=gland_texton_medians_glandwise3fold(0,1);
[feature3_tr23_benign,feature3_tr23_malignant]=gland_texton_medians_glandwise3fold(0,2);
[feature3_tr13_benign,feature3_tr13_malignant]=gland_texton_medians_glandwise3fold(0,3);
save(strcat(path_save,'feature3_tr12_benign.mat'),'feature3_tr12_benign');
save(strcat(path_save,'feature3_tr12_malignant.mat'),'feature3_tr12_malignant');
save(strcat(path_save,'feature3_tr23_benign.mat'),'feature3_tr23_benign');
save(strcat(path_save,'feature3_tr23_malignant.mat'),'feature3_tr23_malignant');
save(strcat(path_save,'feature3_tr13_benign.mat'),'feature3_tr13_benign');
save(strcat(path_save,'feature3_tr13_malignant.mat'),'feature3_tr13_malignant');
val_textons_glandwise3fold(0,1);
val_textons_glandwise3fold(1,1);
val_textons_glandwise3fold(0,2);
val_textons_glandwise3fold(1,2);
val_textons_glandwise3fold(0,3);
val_textons_glandwise3fold(1,3);
[feature3_val1_benign,feature3_val1_malignant]=gland_texton_medians_glandwise3fold(1,1);
[feature3_val2_benign,feature3_val2_malignant]=gland_texton_medians_glandwise3fold(1,2);
[feature3_val3_benign,feature3_val3_malignant]=gland_texton_medians_glandwise3fold(1,3);
save(strcat(path_save,'feature3_val1_benign.mat'),'feature3_val1_benign');
save(strcat(path_save,'feature3_val1_malignant.mat'),'feature3_val1_malignant');
save(strcat(path_save,'feature3_val2_benign.mat'),'feature3_val2_benign');
save(strcat(path_save,'feature3_val2_malignant.mat'),'feature3_val2_malignant');
save(strcat(path_save,'feature3_val3_benign.mat'),'feature3_val3_benign');
save(strcat(path_save,'feature3_val3_malignant.mat'),'feature3_val3_malignant');
[feature1_tr12_benign,feature1_tr12_malignant,feature2_tr12_benign,feature2_tr12_malignant,feature4_tr12_benign,feature4_tr12_malignant]=ls_Analysis_3fold_glandwise(0,1);
[feature1_tr23_benign,feature1_tr23_malignant,feature2_tr23_benign,feature2_tr23_malignant,feature4_tr23_benign,feature4_tr23_malignant]=ls_Analysis_3fold_glandwise(0,2);
[feature1_tr13_benign,feature1_tr13_malignant,feature2_tr13_benign,feature2_tr13_malignant,feature4_tr13_benign,feature4_tr13_malignant]=ls_Analysis_3fold_glandwise(0,3);
[feature1_val1_benign,feature1_val1_malignant,feature2_val1_benign,feature2_val1_malignant,feature4_val1_benign,feature4_val1_malignant]=ls_Analysis_3fold_glandwise(1,1);
[feature1_val2_benign,feature1_val2_malignant,feature2_val2_benign,feature2_val2_malignant,feature4_val2_benign,feature4_val2_malignant]=ls_Analysis_3fold_glandwise(1,2);
[feature1_val3_benign,feature1_val3_malignant,feature2_val3_benign,feature2_val3_malignant,feature4_val3_benign,feature4_val3_malignant]=ls_Analysis_3fold_glandwise(1,3);

save(strcat(path_save,'feature1_tr12_benign.mat'),'feature1_tr12_benign');
save(strcat(path_save,'feature1_tr12_malignant.mat'),'feature1_tr12_malignant');
save(strcat(path_save,'feature1_tr23_benign.mat'),'feature1_tr23_benign');
save(strcat(path_save,'feature1_tr23_malignant.mat'),'feature1_tr23_malignant');
save(strcat(path_save,'feature1_tr13_benign.mat'),'feature1_tr13_benign');
save(strcat(path_save,'feature1_tr13_malignant.mat'),'feature1_tr13_malignant');
save(strcat(path_save,'feature1_val1_benign.mat'),'feature1_val1_benign');
save(strcat(path_save,'feature1_val1_malignant.mat'),'feature1_val1_malignant');
save(strcat(path_save,'feature1_val2_benign.mat'),'feature1_val2_benign');
save(strcat(path_save,'feature1_val2_malignant.mat'),'feature1_val2_malignant');
save(strcat(path_save,'feature1_val3_benign.mat'),'feature1_val3_benign');
save(strcat(path_save,'feature1_val3_malignant.mat'),'feature1_val3_malignant');
save(strcat(path_save,'feature2_tr12_benign.mat'),'feature2_tr12_benign');
save(strcat(path_save,'feature2_tr12_malignant.mat'),'feature2_tr12_malignant');
save(strcat(path_save,'feature2_tr23_benign.mat'),'feature2_tr23_benign');
save(strcat(path_save,'feature2_tr23_malignant.mat'),'feature2_tr23_malignant');
save(strcat(path_save,'feature2_tr13_benign.mat'),'feature2_tr13_benign');
save(strcat(path_save,'feature2_tr13_malignant.mat'),'feature2_tr13_malignant');
save(strcat(path_save,'feature2_val1_benign.mat'),'feature2_val1_benign');
save(strcat(path_save,'feature2_val1_malignant.mat'),'feature2_val1_malignant');
save(strcat(path_save,'feature2_val2_benign.mat'),'feature2_val2_benign');
save(strcat(path_save,'feature2_val2_malignant.mat'),'feature2_val2_malignant');
save(strcat(path_save,'feature2_val3_benign.mat'),'feature2_val3_benign');
save(strcat(path_save,'feature2_val3_malignant.mat'),'feature2_val3_malignant');
%{
feature1_tr12_benign_st=load(strcat(path_save,'feature1_tr12_benign.mat'),'feature1_tr12_benign');
feature1_tr12_malignant_st=load(strcat(path_save,'feature1_tr12_malignant.mat'),'feature1_tr12_malignant');
feature1_tr23_benign_st=load(strcat(path_save,'feature1_tr23_benign.mat'),'feature1_tr23_benign');
feature1_tr23_malignant_st=load(strcat(path_save,'feature1_tr23_malignant.mat'),'feature1_tr23_malignant');
feature1_tr13_benign_st=load(strcat(path_save,'feature1_tr13_benign.mat'),'feature1_tr13_benign');
feature1_tr13_malignant_st=load(strcat(path_save,'feature1_tr13_malignant.mat'),'feature1_tr13_malignant');
feature1_val1_benign_st=load(strcat(path_save,'feature1_val1_benign.mat'),'feature1_val1_benign');
feature1_val1_malignant_st=load(strcat(path_save,'feature1_val1_malignant.mat'),'feature1_val1_malignant');
feature1_val2_benign_st=load(strcat(path_save,'feature1_val2_benign.mat'),'feature1_val2_benign');
feature1_val2_malignant_st=load(strcat(path_save,'feature1_val2_malignant.mat'),'feature1_val2_malignant');
feature1_val3_benign_st=load(strcat(path_save,'feature1_val3_benign.mat'),'feature1_val3_benign');
feature1_val3_malignant_st=load(strcat(path_save,'feature1_val3_malignant.mat'),'feature1_val3_malignant');
feature2_tr12_benign_st=load(strcat(path_save,'feature2_tr12_benign.mat'),'feature2_tr12_benign');
feature2_tr12_malignant_st=load(strcat(path_save,'feature2_tr12_malignant.mat'),'feature2_tr12_malignant');
feature2_tr23_benign_st=load(strcat(path_save,'feature2_tr23_benign.mat'),'feature2_tr23_benign');
feature2_tr23_malignant_st=load(strcat(path_save,'feature2_tr23_malignant.mat'),'feature2_tr23_malignant');
feature2_tr13_benign_st=load(strcat(path_save,'feature2_tr13_benign.mat'),'feature2_tr13_benign');
feature2_tr13_malignant_st=load(strcat(path_save,'feature2_tr13_malignant.mat'),'feature2_tr13_malignant');
feature2_val1_benign_st=load(strcat(path_save,'feature2_val1_benign.mat'),'feature2_val1_benign');
feature2_val1_malignant_st=load(strcat(path_save,'feature2_val1_malignant.mat'),'feature2_val1_malignant');
feature2_val2_benign_st=load(strcat(path_save,'feature2_val2_benign.mat'),'feature2_val2_benign');
feature2_val2_malignant_st=load(strcat(path_save,'feature2_val2_malignant.mat'),'feature2_val2_malignant');
feature2_val3_benign_st=load(strcat(path_save,'feature2_val3_benign.mat'),'feature2_val3_benign');
feature2_val3_malignant_st=load(strcat(path_save,'feature2_val3_malignant.mat'),'feature2_val3_malignant');

feature1_tr12_benign=feature1_tr12_benign_st.feature1_tr12_benign;
feature1_tr12_malignant=feature1_tr12_malignant_st.feature1_tr12_malignant;
feature1_tr23_benign=feature1_tr23_benign_st.feature1_tr23_benign;
feature1_tr23_malignant=feature1_tr23_malignant_st.feature1_tr23_malignant;
feature1_tr13_benign=feature1_tr13_benign_st.feature1_tr13_benign;
feature1_tr13_malignant=feature1_tr13_malignant_st.feature1_tr13_malignant;
feature1_val1_benign=feature1_val1_benign_st.feature1_val1_benign;
feature1_val1_malignant=feature1_val1_malignant_st.feature1_val1_malignant;
feature1_val2_benign=feature1_val2_benign_st.feature1_val2_benign;
feature1_val2_malignant=feature1_val2_malignant_st.feature1_val2_malignant;
feature1_val3_benign=feature1_val3_benign_st.feature1_val3_benign;
feature1_val3_malignant=feature1_val3_malignant_st.feature1_val3_malignant;
feature2_tr12_benign=feature2_tr12_benign_st.feature2_tr12_benign;
feature2_tr12_malignant=feature2_tr12_malignant_st.feature2_tr12_malignant;
feature2_tr23_benign=feature2_tr23_benign_st.feature2_tr23_benign;
feature2_tr23_malignant=feature2_tr23_malignant_st.feature2_tr23_malignant;
feature2_tr13_benign=feature2_tr13_benign_st.feature2_tr13_benign;
feature2_tr13_malignant=feature2_tr13_malignant_st.feature2_tr13_malignant;
feature2_val1_benign=feature2_val1_benign_st.feature2_val1_benign;
feature2_val1_malignant=feature2_val1_malignant_st.feature2_val1_malignant;
feature2_val2_benign=feature2_val2_benign_st.feature2_val2_benign;
feature2_val2_malignant=feature2_val2_malignant_st.feature2_val2_malignant;
feature2_val3_benign=feature2_val3_benign_st.feature2_val3_benign;
feature2_val3_malignant=feature2_val3_malignant_st.feature2_val3_malignant;

%training/val set 1
feature3_tr12_benign_st=load(strcat(path_save,'feature3_tr12_benign.mat'),'feature3_tr12_benign');
feature3_tr12_malignant_st=load(strcat(path_save,'feature3_tr12_malignant.mat'),'feature3_tr12_malignant');
feature3_tr23_benign_st=load(strcat(path_save,'feature3_tr23_benign.mat'),'feature3_tr23_benign');
feature3_tr23_malignant_st=load(strcat(path_save,'feature3_tr23_malignant.mat'),'feature3_tr23_malignant');
feature3_tr13_benign_st=load(strcat(path_save,'feature3_tr13_benign.mat'),'feature3_tr13_benign');
feature3_tr13_malignant_st=load(strcat(path_save,'feature3_tr13_malignant.mat'),'feature3_tr13_malignant');
feature3_val1_benign_st=load(strcat(path_save,'feature3_val1_benign.mat'),'feature3_val1_benign');
feature3_val1_malignant_st=load(strcat(path_save,'feature3_val1_malignant.mat'),'feature3_val1_malignant');
feature3_val2_benign_st=load(strcat(path_save,'feature3_val2_benign.mat'),'feature3_val2_benign');
feature3_val2_malignant_st=load(strcat(path_save,'feature3_val2_malignant.mat'),'feature3_val2_malignant');
feature3_val3_benign_st=load(strcat(path_save,'feature3_val3_benign.mat'),'feature3_val3_benign');
feature3_val3_malignant_st=load(strcat(path_save,'feature3_val3_malignant.mat'),'feature3_val3_malignant');

feature3_tr12_benign=feature3_tr12_benign_st.feature3_tr12_benign;
feature3_tr12_malignant=feature3_tr12_malignant_st.feature3_tr12_malignant;
feature3_tr23_benign=feature3_tr23_benign_st.feature3_tr23_benign;
feature3_tr23_malignant=feature3_tr23_malignant_st.feature3_tr23_malignant;
feature3_tr13_benign=feature3_tr13_benign_st.feature3_tr13_benign;
feature3_tr13_malignant=feature3_tr13_malignant_st.feature3_tr13_malignant;
feature3_val1_benign=feature3_val1_benign_st.feature3_val1_benign;
feature3_val1_malignant=feature3_val1_malignant_st.feature3_val1_malignant;
feature3_val2_benign=feature3_val2_benign_st.feature3_val2_benign;
feature3_val2_malignant=feature3_val2_malignant_st.feature3_val2_malignant;
feature3_val3_benign=feature3_val3_benign_st.feature3_val3_benign;
feature3_val3_malignant=feature3_val3_malignant_st.feature3_val3_malignant;
%}



feature_tr12_benign=[feature1_tr12_benign' feature2_tr12_benign' feature3_tr12_benign];
feature_val1_benign=[feature1_val1_benign' feature2_val1_benign' feature3_val1_benign];
feature_tr12_malignant=[feature1_tr12_malignant' feature2_tr12_malignant' feature3_tr12_malignant];
feature_val1_malignant=[feature1_val1_malignant' feature2_val1_malignant' feature3_val1_malignant];

%{
feature_tr12_benign=[feature2_tr12_benign' feature3_tr12_benign];
feature_val1_benign=[feature2_val1_benign' feature3_val1_benign];
feature_tr12_malignant=[feature2_tr12_malignant' feature3_tr12_malignant];
feature_val1_malignant=[feature2_val1_malignant' feature3_val1_malignant];
%}
%training/val set 2

feature_tr23_benign=[feature1_tr23_benign' feature2_tr23_benign' feature3_tr23_benign];
feature_val2_benign=[feature1_val2_benign' feature2_val2_benign' feature3_val2_benign];
feature_tr23_malignant=[feature1_tr23_malignant' feature2_tr23_malignant' feature3_tr23_malignant];
feature_val2_malignant=[feature1_val2_malignant' feature2_val2_malignant' feature3_val2_malignant];
%{
feature_tr23_benign=[feature2_tr23_benign' feature3_tr23_benign];
feature_val2_benign=[feature2_val2_benign' feature3_val2_benign];
feature_tr23_malignant=[feature2_tr23_malignant' feature3_tr23_malignant];
feature_val2_malignant=[feature2_val2_malignant' feature3_val2_malignant];
%}
%training/val set 3

feature_tr13_benign=[feature1_tr13_benign' feature2_tr13_benign' feature3_tr13_benign];
feature_val3_benign=[feature1_val3_benign' feature2_val3_benign' feature3_val3_benign];
feature_tr13_malignant=[feature1_tr13_malignant' feature2_tr13_malignant' feature3_tr13_malignant];
feature_val3_malignant=[feature1_val3_malignant' feature2_val3_malignant' feature3_val3_malignant];

%{
feature_tr13_benign=[feature2_tr13_benign' feature3_tr13_benign ];
feature_val3_benign=[feature2_val3_benign' feature3_val3_benign ];
feature_tr13_malignant=[feature2_tr13_malignant' feature3_tr13_malignant ];
feature_val3_malignant=[feature2_val3_malignant' feature3_val3_malignant ];
%}
feature_tr12=[feature_tr12_benign; feature_tr12_malignant];
feature_tr23=[feature_tr23_benign; feature_tr23_malignant];
feature_tr13=[feature_tr13_benign; feature_tr13_malignant];
label_tr12=[ones(size(feature_tr12_benign,1),1);2*ones(size(feature_tr12_malignant,1),1)];
label_tr23=[ones(size(feature_tr23_benign,1),1);2*ones(size(feature_tr23_malignant,1),1)];
label_tr13=[ones(size(feature_tr13_benign,1),1);2*ones(size(feature_tr13_malignant,1),1)];

gland_labels_val1_benign=load('Z:\Hassaan\HE_Scanner\BR1003_11_11_2017\RGB2GRAY\SLIM\Cores\B_to_M_Continuum\Partitioned_glands\gland_labels_benign_val1_w_core.mat');
gland_labels_val1_malignant=load('Z:\Hassaan\HE_Scanner\BR1003_11_11_2017\RGB2GRAY\SLIM\Cores\B_to_M_Continuum\Partitioned_glands\gland_labels_malignant_val1_w_core.mat');
gland_labels_val2_benign=load('Z:\Hassaan\HE_Scanner\BR1003_11_11_2017\RGB2GRAY\SLIM\Cores\B_to_M_Continuum\Partitioned_glands\gland_labels_benign_val2_w_core.mat');
gland_labels_val2_malignant=load('Z:\Hassaan\HE_Scanner\BR1003_11_11_2017\RGB2GRAY\SLIM\Cores\B_to_M_Continuum\Partitioned_glands\gland_labels_malignant_val2_w_core.mat');
gland_labels_val3_benign=load('Z:\Hassaan\HE_Scanner\BR1003_11_11_2017\RGB2GRAY\SLIM\Cores\B_to_M_Continuum\Partitioned_glands\gland_labels_benign_val3_w_core.mat');
gland_labels_val3_malignant=load('Z:\Hassaan\HE_Scanner\BR1003_11_11_2017\RGB2GRAY\SLIM\Cores\B_to_M_Continuum\Partitioned_glands\gland_labels_malignant_val3_w_core.mat');

feature_val1=[feature_val1_benign; feature_val1_malignant];
feature_val2=[feature_val2_benign; feature_val2_malignant];
feature_val3=[feature_val3_benign; feature_val3_malignant];

label_val1=[ones(size(feature_val1_benign,1),1);2*ones(size(feature_val1_malignant,1),1)];
label_val2=[ones(size(feature_val2_benign,1),1);2*ones(size(feature_val2_malignant,1),1)];
label_val3=[ones(size(feature_val3_benign,1),1);2*ones(size(feature_val3_malignant,1),1)];
four_class_label_val1=[gland_labels_val1_benign.gland_labels_benign';gland_labels_val1_malignant.gland_labels_malignant'];
four_class_label_val2=[gland_labels_val2_benign.gland_labels_benign';gland_labels_val2_malignant.gland_labels_malignant'];
four_class_label_val3=[gland_labels_val3_benign.gland_labels_benign';gland_labels_val3_malignant.gland_labels_malignant'];

[AUC1,Sens1,Spec1,Perf1]=train_data_DCIS(feature_tr12(:,1:end),label_tr12,feature_val1(:,1:end),label_val1);
[AUC2,Sens2,Spec2,Perf2]=train_data_DCIS(feature_tr23(:,1:end),label_tr23,feature_val2(:,1:end),label_val2);
[AUC3,Sens3,Spec3,Perf3]=train_data_DCIS(feature_tr13(:,1:end),label_tr13,feature_val3(:,1:end),label_val3);
Perf1_stand=Perf1(:,2);%-nanmean(Perf1(:,2));
Perf2_stand=Perf2(:,2);%-nanmean(Perf2(:,2));
Perf3_stand=Perf3(:,2);%-nanmean(Perf3(:,2));
ensemble_perf_score=[Perf1_stand; Perf2_stand; Perf3_stand];
ensemble_ground_truth=[label_val1; label_val2; label_val3];
[Spec,Sens,T,AUC,OPTROCPT] = perfcurve(ensemble_ground_truth,ensemble_perf_score,2);
figure;
plot(Spec,Sens,'r-');
xlabel('Sens.');
ylabel('1-Spec.');

AUC
AUC1
AUC2
AUC3
(AUC1+AUC2+AUC3)/3
text(0.5,0.5,sprintf('AUC = %d',AUC));
save(strcat(path_save,'workspace_median_of_textons_BvsM_stained_std_seg_meansub_16bitcorrection.mat'));

for core=1:1:24
current_idx_1=find(gland_labels_val1_benign.gland_labels_benign(:,2)==core);
current_idx_2=find(gland_labels_val2_benign.gland_labels_benign(:,2)==core);
current_idx_3=find(gland_labels_val3_benign.gland_labels_benign(:,2)==core);
core_score_benign(core)=mean([Perf1(current_idx_1,2);Perf2(current_idx_2,2);Perf3(current_idx_3,2)]);
clear current_idx_1 current_idx_2 current_idx_3;
end    

for core=1:1:27
current_idx_1=find(gland_labels_val1_malignant.gland_labels_malignant(:,2)==core);
current_idx_2=find(gland_labels_val2_malignant.gland_labels_malignant(:,2)==core);
current_idx_3=find(gland_labels_val3_malignant.gland_labels_malignant(:,2)==core);
core_score_malignant(core)=mean([Perf1(current_idx_1,2);Perf2(current_idx_2,2);Perf3(current_idx_3,2)]);
clear current_idx_1 current_idx_2 current_idx_3;
end 

plot(core_score_benign,'b*');
hold on;
plot(core_score_malignant,'r*');
%{
[perf1_dash_hd,perf1_dash_hm,perf1_dash_bm,perf1_dash_bd,perf1_dash_bh,perf1_dash_dm,labels1_hd,labels1_hm,labels1_bm,labels1_bd,labels1_bh,labels1_dm]=train_data_DCIS_fourclass(feature_tr12,label_tr12,feature_val1,label_val1,four_class_label_val1);
[perf2_dash_hd,perf2_dash_hm,perf2_dash_bm,perf2_dash_bd,perf2_dash_bh,perf2_dash_dm,labels2_hd,labels2_hm,labels2_bm,labels2_bd,labels2_bh,labels2_dm]=train_data_DCIS_fourclass(feature_tr23,label_tr23,feature_val2,label_val2,four_class_label_val2);
[perf3_dash_hd,perf3_dash_hm,perf3_dash_bm,perf3_dash_bd,perf3_dash_bh,perf3_dash_dm,labels3_hd,labels3_hm,labels3_bm,labels3_bd,labels3_bh,labels3_dm]=train_data_DCIS_fourclass(feature_tr13,label_tr13,feature_val3,label_val3,four_class_label_val3);

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

Perf1_hd=perf1_dash_hd-nanmean(perf1_dash_hd);
Perf1_hm=perf1_dash_hm-nanmean(perf1_dash_hm);
Perf1_bm=perf1_dash_bm-nanmean(perf1_dash_bm);
Perf1_bd=perf1_dash_bd-nanmean(perf1_dash_bd);
Perf1_bh=perf1_dash_bh-nanmean(perf1_dash_bh);
Perf1_dm=perf1_dash_dm-nanmean(perf1_dash_dm);

Perf2_hd=perf2_dash_hd-nanmean(perf2_dash_hd);
Perf2_hm=perf2_dash_hm-nanmean(perf2_dash_hm);
Perf2_bm=perf2_dash_bm-nanmean(perf2_dash_bm);
Perf2_bd=perf2_dash_bd-nanmean(perf2_dash_bd);
Perf2_bh=perf2_dash_bh-nanmean(perf2_dash_bh);
Perf2_dm=perf2_dash_dm-nanmean(perf2_dash_dm);

Perf3_hd=perf3_dash_hd-nanmean(perf3_dash_hd);
Perf3_hm=perf3_dash_hm-nanmean(perf3_dash_hm);
Perf3_bm=perf3_dash_bm-nanmean(perf3_dash_bm);
Perf3_bd=perf3_dash_bd-nanmean(perf3_dash_bd);
Perf3_bh=perf3_dash_bh-nanmean(perf3_dash_bh);
Perf3_dm=perf3_dash_dm-nanmean(perf3_dash_dm);

ensemble_Perf_hd=[Perf1_hd; Perf2_hd; Perf3_hd];
ensemble_Perf_hm=[Perf1_hm; Perf2_hm; Perf3_hm];
ensemble_Perf_bm=[Perf1_bm; Perf2_bm; Perf3_bm];
ensemble_Perf_bd=[Perf1_bd; Perf2_bd; Perf3_bd];
ensemble_Perf_bh=[Perf1_bh; Perf2_bh; Perf3_bh];
ensemble_Perf_dm=[Perf1_dm; Perf2_dm; Perf3_dm];

ensemble_groundtruth_hd=[labels1_hd;labels2_hd;labels3_hd];
ensemble_groundtruth_hm=[labels1_hm;labels2_hm;labels3_hm];
ensemble_groundtruth_bm=[labels1_bm;labels2_bm;labels3_bm];
ensemble_groundtruth_bd=[labels1_bd;labels2_bd;labels3_bd];
ensemble_groundtruth_bh=[labels1_bh;labels2_bh;labels3_bh];
ensemble_groundtruth_dm=[labels1_dm;labels2_dm;labels3_dm];

[Spec_hd,Sens_hd,T_hd,AUC_hd,OPTROCPT_hd] = perfcurve(ensemble_groundtruth_hd,ensemble_Perf_hd,2);
[Spec_hm,Sens_hm,T_hm,AUC_hm,OPTROCPT_hm] = perfcurve(ensemble_groundtruth_hm,ensemble_Perf_hm,2);
[Spec_bm,Sens_bm,T_bm,AUC_bm,OPTROCPT_bm] = perfcurve(ensemble_groundtruth_bm,ensemble_Perf_bm,2);
[Spec_bd,Sens_bd,T_bd,AUC_bd,OPTROCPT_bd] = perfcurve(ensemble_groundtruth_bd,ensemble_Perf_bd,2);
[Spec_bh,Sens_bh,T_bh,AUC_bh,OPTROCPT_bh] = perfcurve(ensemble_groundtruth_bh,ensemble_Perf_bh,2);
[Spec_dm,Sens_dm,T_dm,AUC_dm,OPTROCPT_dm] = perfcurve(ensemble_groundtruth_dm,ensemble_Perf_dm,2);
%}
[perf1_b,perf1_h,perf1_d,perf1_m]=train_data_DCIS_fourclass_for_plot(feature_tr12,label_tr12,feature_val1,label_val1,four_class_label_val1);
[perf2_b,perf2_h,perf2_d,perf2_m]=train_data_DCIS_fourclass_for_plot(feature_tr23,label_tr23,feature_val2,label_val2,four_class_label_val2);
[perf3_b,perf3_h,perf3_d,perf3_m]=train_data_DCIS_fourclass_for_plot(feature_tr13,label_tr13,feature_val3,label_val3,four_class_label_val3);

avg_1=nanmean([perf1_b; perf1_h; perf1_d; perf1_m]);
avg_2=nanmean([perf2_b; perf2_h; perf2_d; perf2_m]);
avg_3=nanmean([perf3_b; perf3_h; perf3_d; perf3_m]);


ensemble_b=[perf1_b-avg_1; perf2_b-avg_2; perf3_b-avg_3];
ensemble_h=[perf1_h-avg_1; perf2_h-avg_2; perf3_h-avg_3];
ensemble_d=[perf1_d-avg_1; perf2_d-avg_2; perf3_d-avg_3];
ensemble_m=[perf1_m-avg_1; perf2_m-avg_2; perf3_m-avg_3];

bins=min(ensemble_b):(max(ensemble_m) - min(ensemble_b))/32:(max(ensemble_m) - min(ensemble_b));
figure;
histogram(ensemble_b,bins,'FaceColor',[0 1 0],'EdgeColor','none','FaceAlpha',0.5);
hold on;
histogram(ensemble_h,bins,'FaceColor',[0 1 0],'EdgeColor','none','FaceAlpha',0.5);
hold on;
histogram(ensemble_d,bins,'FaceColor',[1 0 0],'EdgeColor','none','FaceAlpha',0.5);
hold on;
histogram(ensemble_m,bins,'FaceColor',[1 0 0],'EdgeColor','none','FaceAlpha',0.5);

xlim([-0.4 0.6]);