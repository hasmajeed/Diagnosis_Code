
clear all;
close all;
clc;
k=3;

cd('E:\FTLS\All_Cores\Core Images\16bit\');
load('Correct_Texton_threefold_validation_workspace_5102017.mat');

%load('Z:\Hassaan\Breast_TMA\Breast_Diagnosis_Code_repository\16bit\round3_workspace_20textons.mat');

%%    
%Glandwise analysis    
for count=1:1:50
%[feature_training12,feature_training23,feature_training13,feature_val1,feature_val2,feature_val3,...
         %labels_training12,labels_training23,labels_training13,labels_val1,labels_val2,labels_val3]=feature_extraction_tuning_04_24_17(k);
[feature_training,labels_training,feature_val,labels_val]=feature_extraction_tuning(2,count);
[Sens,Spec,T,AUC,OPT]=LDA_Biomax(feature_training,labels_training,feature_val,labels_val,count+2);
A(count)=AUC;
Operatin_pt(count,:)=OPT;
end
mean(A)
mean(Operatin_pt,1)
%Corewise with random partitioning    
[feature_training,labels_training,feature_val,labels_val]=feature_extraction_corebased(3,18);
feature_set_size(count)=size(feature_training,1);
val_set_size(count)=size(feature_val,1);
[labels_core,Sens,Spec,T,AUC]=LDA_Biomax_corewise(feature_training,labels_training,feature_val,labels_val,20);
hold on;
plot(Sens,Spec);
A(count)=AUC;
%%
Nan_index1=isnan(feature_training12(:,2));
Nan_index2=isnan(feature_training23(:,2));
Nan_index3=isnan(feature_training13(:,2));

feature_training12(find(Nan_index1==1),:)=[];
feature_training23(find(Nan_index2==1),:)=[];
feature_training13(find(Nan_index3==1),:)=[];
labels_training12(find(Nan_index1==1))=[];
labels_training23(find(Nan_index2==1))=[];
labels_training13(find(Nan_index3==1))=[];

Nan_index1_val=isnan(feature_val1(:,2));
Nan_index2_val=isnan(feature_val2(:,2));
Nan_index3_val=isnan(feature_val3(:,2));

feature_val1(find(Nan_index1_val==1),:)=[];
feature_val2(find(Nan_index2_val==1),:)=[];
feature_val3(find(Nan_index3_val==1),:)=[];
labels_val1(find(Nan_index1_val==1))=[];
labels_val2(find(Nan_index2_val==1))=[];
labels_val3(find(Nan_index3_val==1))=[];

 a=1;
 for dim=52:1:52
for threshold=1:0.01:1
    
[labels_core1,Sens1,Spec1,T1,AUC1,score1,case_diagnosis1,ground_truth1,opt1,perf_scores_val1,std_core_1,gland_scores_b1,gland_scores_m1]=LDA_Biomax_corewise(feature_training12,labels_training12,feature_val1,labels_val1,dim,threshold);
[labels_core2,Sens2,Spec2,T2,AUC2,score2,case_diagnosis2,ground_truth2,opt2,perf_scores_val2,std_core_2,gland_scores_b2,gland_scores_m2]=LDA_Biomax_corewise(feature_training23,labels_training23,feature_val2,labels_val2,dim,threshold);
[labels_core3,Sens3,Spec3,T3,AUC3,score3,case_diagnosis3,ground_truth3,opt3,perf_scores_val3,std_core_3,gland_scores_b3,gland_scores_m3]=LDA_Biomax_corewise(feature_training13,labels_training13,feature_val3,labels_val3,dim,threshold);
Perf1(:,dim)=perf_scores_val1';
Perf2(:,dim)=perf_scores_val2';
Perf3(:,dim)=perf_scores_val3';
end
 end
TP1_index = find(ground_truth1==2);
TP2_index = find(ground_truth2==2);
TP3_index = find(ground_truth3==2);

TP1 = length(find(case_diagnosis1(TP1_index)==2));
TP2 = length(find(case_diagnosis2(TP2_index)==2));
TP3 = length(find(case_diagnosis3(TP3_index)==2));

P1=length(find(ground_truth1==2));
P2=length(find(ground_truth2==2));
P3=length(find(ground_truth3==2));

case_sens1(a) = TP1/P1;
case_sens2(a) = TP2/P2;
case_sens3(a) = TP3/P3;

TN1_index = (find(ground_truth1==1));
TN2_index = (find(ground_truth2==1));
TN3_index = (find(ground_truth3==1));

TN1 = length(find(case_diagnosis1(TN1_index)==1));
TN2 = length(find(case_diagnosis2(TN2_index)==1));
TN3 = length(find(case_diagnosis3(TN3_index)==1));

N1 = length(find(ground_truth1==1));
N2 = length(find(ground_truth2==1));
N3 = length(find(ground_truth3==1));

case_spec1(a)=TN1/N1;
case_spec2(a)=TN2/N2;
case_spec3(a)=TN3/N3;

error1=ground_truth1 - case_diagnosis1';
error2=ground_truth2 - case_diagnosis2';
error3=ground_truth3 - case_diagnosis3';

count1(a)=length(find(error1~=0));
count2(a)=length(find(error2~=0));
count3(a)=length(find(error3~=0));
a=a+1;
clear error1 error2 error3 TP1_index TP2_index TP3_index TP1 TP2 TP3 P1 P2 P3 TN1_index TN2_index TN3_index TN1 TN2 TN3 N1 N2 N3;


figure; plot(0:0.01:1,case_sens1,'b*',0:0.01:1,case_spec1,'r*');title('1');
figure; plot(0:0.01:1,case_sens2,'b*',0:0.01:1,case_spec2,'r*');title('2');
figure; plot(0:0.01:1,case_sens3,'b*',0:0.01:1,case_spec3,'r*');title('3');


figure;
subplot(2,1,1)
plot(case_diagnosis1,'r*');
subplot(2,1,2)
plot(ground_truth1,'r*');
title('Accuracy1');
figure;
subplot(2,1,1)
plot(case_diagnosis2,'r*');
subplot(2,1,2)
plot(ground_truth2,'r*');
title('Accuracy2');
figure;
subplot(2,1,1);
plot(case_diagnosis3,'r*');
subplot(2,1,2)
plot(ground_truth3,'r*');
title('Accuracy3');



idxb_12=find(labels_training12==1);
idxb_23=find(labels_training23==1);
idxb_13=find(labels_training13==1);
idxb_val1=find(labels_val1==1);
idxb_val2=find(labels_val2==1);
idxb_val3=find(labels_val3==1);


figure;
plot3(feature_training12(1:length(idxb_12),1),feature_training12(1:length(idxb_12),2),feature_training12(1:length(idxb_12),3),'b*',feature_training12(length(idxb_12)+1:end,1),feature_training12(length(idxb_12)+1:end,2),feature_training12(length(idxb_12)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,1000]);
title('12');
figure;
plot3(feature_training23(1:length(idxb_23),1),feature_training23(1:length(idxb_23),2),feature_training23(1:length(idxb_23),3),'b*',feature_training23(length(idxb_23)+1:end,1),feature_training23(length(idxb_23)+1:end,2),feature_training23(length(idxb_23)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,1000]);
title('23');
figure;
plot3(feature_training13(1:length(idxb_13),1),feature_training13(1:length(idxb_13),2),feature_training13(1:length(idxb_13),3),'b*',feature_training13(length(idxb_13)+1:end,1),feature_training13(length(idxb_13)+1:end,2),feature_training13(length(idxb_13)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,1000]);
title('13');


figure;
plot3(feature_val1(1:length(idxb_val1),1),feature_val1(1:length(idxb_val1),2),feature_val1(1:length(idxb_val1),3),'b*',feature_val1(length(idxb_val1)+1:end,1),feature_val1(length(idxb_val1)+1:end,2),feature_val1(length(idxb_val1)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,1000]);
title('1');
figure;
plot3(feature_val2(1:length(idxb_val2),1),feature_val2(1:length(idxb_val2),2),feature_val2(1:length(idxb_val2),3),'b*',feature_val2(length(idxb_val2)+1:end,1),feature_val2(length(idxb_val2)+1:end,2),feature_val2(length(idxb_val2)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,1000]);
title('2');
figure;
plot3(feature_val3(1:length(idxb_val3),1),feature_val3(1:length(idxb_val3),2),feature_val3(1:length(idxb_val3),3),'b*',feature_val3(length(idxb_val3)+1:end,1),feature_val3(length(idxb_val3)+1:end,2),feature_val3(length(idxb_val3)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,1000]);
title('3');
%}
%%
%for two-fold
Nan_index1=isnan(feature_training1(:,2));
Nan_index2=isnan(feature_training2(:,2));

feature_training1(find(Nan_index1==1),:)=[];
feature_training2(find(Nan_index2==1),:)=[];
labels_training1(find(Nan_index1==1))=[];
labels_training2(find(Nan_index2==1))=[];

Nan_index1_val=isnan(feature_val1(:,2));
Nan_index2_val=isnan(feature_val2(:,2));

feature_val1(find(Nan_index1_val==1),:)=[];
feature_val2(find(Nan_index2_val==1),:)=[];
labels_val1(find(Nan_index1_val==1))=[];
labels_val2(find(Nan_index2_val==1))=[];

idxb_1=find(labels_training1==1);
idxb_2=find(labels_training2==1);
idxb_val1=find(labels_val1==1);
idxb_val2=find(labels_val2==1);


figure;
plot3(feature_training1(1:length(idxb_1),1),feature_training1(1:length(idxb_1),2),feature_training1(1:length(idxb_1),3),'b*',feature_training1(length(idxb_1)+1:end,1),feature_training1(length(idxb_1)+1:end,2),feature_training1(length(idxb_1)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,100]);
title('12');
figure;
plot3(feature_training2(1:length(idxb_2),1),feature_training2(1:length(idxb_2),2),feature_training2(1:length(idxb_2),3),'b*',feature_training2(length(idxb_2)+1:end,1),feature_training2(length(idxb_2)+1:end,2),feature_training2(length(idxb_2)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,100]);
title('23');

figure;
plot3(feature_val1(1:length(idxb_val1),1),feature_val1(1:length(idxb_val1),2),feature_val1(1:length(idxb_val1),3),'b*',feature_val1(length(idxb_val1)+1:end,1),feature_val1(length(idxb_val1)+1:end,2),feature_val1(length(idxb_val1)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,100]);
title('1');
figure;
plot3(feature_val2(1:length(idxb_val2),1),feature_val2(1:length(idxb_val2),2),feature_val2(1:length(idxb_val2),3),'b*',feature_val2(length(idxb_val2)+1:end,1),feature_val2(length(idxb_val2)+1:end,2),feature_val2(length(idxb_val2)+1:end,3),'r+');
ylim([0,0.1]);
xlim([0,100]);
title('2');
threshold=0.8;
[labels_core1,Sens1,Spec1,T1,AUC1(count),score1,case_diagnosis1,ground_truth1,opt1]=LDA_Biomax_corewise(feature_training1,labels_training1,feature_val1,labels_val1,52,threshold);
[labels_core2,Sens2,Spec2,T2,AUC2(count),score2,case_diagnosis2,ground_truth2,opt2]=LDA_Biomax_corewise(feature_training2,labels_training2,feature_val2,labels_val2,52,threshold);

TP1_index = find(ground_truth1==2);
TP2_index = find(ground_truth2==2);


TP1 = length(find(case_diagnosis1(TP1_index)==2));
TP2 = length(find(case_diagnosis2(TP2_index)==2));


P1=length(find(ground_truth1==2));
P2=length(find(ground_truth2==2));


case_sens1(a) = TP1/P1;
case_sens2(a) = TP2/P2;


TN1_index = (find(ground_truth1==1));
TN2_index = (find(ground_truth2==1));


TN1 = length(find(case_diagnosis1(TN1_index)==1));
TN2 = length(find(case_diagnosis2(TN2_index)==1));

N1 = length(find(ground_truth1==1));
N2 = length(find(ground_truth2==1));


case_spec1(a)=TN1/N1;
case_spec2(a)=TN2/N2;


figure;
plot(Spec1,Sens1,'--or',Spec2,Sens2,'-.b');
xlim([0 1.2]);
ylim([0 1.2]);
text(0.5,0.4,sprintf('AUC2=%0.2f',AUC2));
text(0.5,0.5,sprintf('AUC1=%0.2f',AUC1));
%{
text(0.3,0.4,sprintf('Sens2=%0.2f',opt2(2)));
text(0.3,0.5,sprintf('Sens1=%0.2f',opt1(2)));
text(0.3,0.7,sprintf('Spec2=%0.2f',1-opt2(1)));
text(0.3,0.8,sprintf('Spec1=%0.2f',1-opt1(1)));
%}
text(0.3,0.4,sprintf('Sens2=%0.2f',case_sens2));
text(0.3,0.5,sprintf('Sens1=%0.2f',case_sens1));
text(0.3,0.7,sprintf('Spec2=%0.2f',case_spec2));
text(0.3,0.8,sprintf('Spec1=%0.2f',case_spec1));

%%
%hold on;
plot(Spec1,Sens1,'--or',Spec2,Sens2,'-.b',Spec3,Sens3,':*g');
xlim([0 1.2]);
ylim([0 1.2]);


likelihood1=Sens1./Spec1;
likelihood2=Sens2./Spec2;
likelihood3=Sens3./Spec3;

text(0.5,0.3,sprintf('AUC3=%0.2f',AUC3));
text(0.5,0.4,sprintf('AUC2=%0.2f',AUC2));
text(0.5,0.5,sprintf('AUC1=%0.2f',AUC1));

text(0.3,0.3,sprintf('Sens3=%0.2f',opt3(2)));
text(0.3,0.4,sprintf('Sens2=%0.2f',opt2(2)));
text(0.3,0.5,sprintf('Sens1=%0.2f',opt1(2)));
text(0.3,0.6,sprintf('Spec3=%0.2f',1-opt3(1)));
text(0.3,0.7,sprintf('Spec2=%0.2f',1-opt2(1)));
text(0.3,0.8,sprintf('Spec1=%0.2f',1-opt1(1)));
%{
text(0.3,0.3,sprintf('Sens3=%0.2f',case_sens3));
text(0.3,0.4,sprintf('Sens2=%0.2f',case_sens2));
text(0.3,0.5,sprintf('Sens1=%0.2f',case_sens1));
text(0.3,0.6,sprintf('Spec3=%0.2f',case_spec3));
text(0.3,0.7,sprintf('Spec2=%0.2f',case_spec2));
text(0.3,0.8,sprintf('Spec1=%0.2f',case_spec1));

figure;
plot(T1,Spec1,T1,Sens1,T2,Spec2,T2,Sens2,T3,Spec3,T3,Sens3);
legend('Spec1','Sens1','Spec2','Sens2','Spec3','Sens3');
%}

%ensemble_perf_score=[perf_scores_val1 perf_scores_val2 perf_scores_val3];
for dim=52:1:52
ensemble_perf_score=[Perf1(:,dim)' Perf2(:,dim)' Perf3(:,dim)'];
ensemble_ground_truth=[ground_truth1; ground_truth2; ground_truth3];
[Spec,Sens,T,AUC,OPTROCPT] = perfcurve(ensemble_ground_truth,ensemble_perf_score,2);
Final_A(dim)=AUC;
Findal_opt(dim,:)=OPTROCPT;
end
figure;
plot(Spec,Sens,'r:');
OPTROCPT
%median(A)
%std(A)
malignant_index1=find(ground_truth1==2);
malignant_index2=find(ground_truth2==2);
malignant_index3=find(ground_truth3==2);

benign_index1=find(ground_truth1==1);
benign_index2=find(ground_truth2==1);
benign_index3=find(ground_truth3==1);

benign_core_std_glands=max([std_core_1(benign_index1) std_core_2(benign_index2) std_core_3(benign_index3)])
malignant_core_std_glands= max([std_core_1(malignant_index1) std_core_2(malignant_index2) std_core_3(malignant_index3)])

ensemble_std_core=[std_core_1 std_core_2 std_core_3];
diagnosed_malignant=find(ensemble_perf_score>-0.0372);
diagnosed_benign=find(ensemble_perf_score<-0.0372);
malignant_core_std_glands_diag=median(ensemble_std_core(diagnosed_malignant))
benign_core_std_glands_diag=median(ensemble_std_core(diagnosed_benign))

mean_gland_scores_1=mean([gland_scores_b1; gland_scores_m1]);
mean_gland_scores_2=mean([gland_scores_b2; gland_scores_m2]);
mean_gland_scores_3=mean([gland_scores_b3; gland_scores_m3]);
mean_gland_scores_1=0;
mean_gland_scores_2=0;
mean_gland_scores_3=0;
overall_score_b_glands_std=std([(gland_scores_b1-mean_gland_scores_1); (gland_scores_b2-mean_gland_scores_2); (gland_scores_b3-mean_gland_scores_3)])
overall_score_m_glands_std=std([(gland_scores_m1-mean_gland_scores_2); (gland_scores_m2-mean_gland_scores_2); (gland_scores_m3-mean_gland_scores_3)])
overall_score_b_glands_mean=median([(gland_scores_b1-mean_gland_scores_1); (gland_scores_b2-mean_gland_scores_2); (gland_scores_b3-mean_gland_scores_3)])
overall_score_m_glands_mean=median([(gland_scores_m1-mean_gland_scores_2); (gland_scores_m2-mean_gland_scores_2); (gland_scores_m3-mean_gland_scores_3)])

