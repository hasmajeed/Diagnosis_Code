%Code for calculating parameters over segmented areas%
function [ls_glands_benign,ls_glands_malignant,solidity_benign,solidity_malignant,phase_std_benign,phase_std_malignant]=ls_Analysis_3fold_glandwise(tr_or_val,set_number)
%tr_or_val =0 for training data and tr_or_val=1 for validation data
path_ls_benign = 'Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Benign\ls\';
path_ls_malignant = 'Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Malignant\ls\';
path_phase_benign =  'Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Benign\32bit\';
path_phase_malignant = 'Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Malignant\32bit\';
if(tr_or_val)==0
path_label_benign=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\tr%d\\Benign\\',set_number);
path_label_malignant=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\tr%d\\Malignant\\',set_number);
else
path_label_benign=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\val%d\\Benign\\',set_number);
path_label_malignant=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\val%d\\Malignant\\',set_number);
end

label_list_benign=dir(path_label_benign);
label_list_malignant=dir(path_label_malignant);
ls_list_benign=dir(path_ls_benign);
ls_list_malignant=dir(path_ls_malignant);
phase_list_benign = dir(path_phase_benign);
phase_list_malignant = dir(path_phase_malignant);


ls_glands_benign = [];
ls_glands_malignant = [];
solidity_benign = [];
solidity_malignant = [];
s_benign = [];
s_malignant = [];
phase_std_benign=[];
phase_std_malignant=[];
phase_med_benign=[];
phase_med_malignant=[];

core_number=0;
core_index_benign=0;
core_label_benign=[];


size(ls_list_benign,1)-3
size(ls_list_malignant,1)-3

for num=1:1:(size(ls_list_benign,1)-3)
label_map = imread(strcat(path_label_benign,label_list_benign(num+2).name));
[m,n]=size(label_map);
ls_map =imresize(imread(strcat(path_ls_benign,ls_list_benign(num+2).name)),[m n],'nearest');
phase_map = imresize(imread(strcat(path_phase_benign,phase_list_benign(num+2).name)),[m n],'nearest');
[gland_ls_benign,solidity_benign_gland,s_benign_gland,gland_phase_std_benign,gland_phase_med_benign]=ls_extraction_glandwise_3fold(label_map,ls_map,label_list_benign(num+2).name,core_number,phase_map,20);
phase_std_benign=[phase_std_benign gland_phase_std_benign];
core_label_benign = [core_label_benign; (num)*ones(length(gland_ls_benign),1)];
ls_glands_benign=[ls_glands_benign gland_ls_benign];
solidity_benign=[solidity_benign solidity_benign_gland];
s_benign = [s_benign s_benign_gland];
phase_med_benign=[phase_med_benign gland_phase_med_benign];
%ls_core_wise_benign(num)=nanmedian(gland_ls_benign);
ls_core_wise_benign(num)=nanmean(gland_ls_benign);
%solidity_core_wise_benign(num)=nanmedian(solidity_benign_gland);
solidity_core_wise_benign(num)=nanmean(solidity_benign_gland);
%phase_benign = [phase_benign median_phase_benign]; 
core_number=core_number+2;
%product=phase_map.*label_map;
%writeTIFF(product,strcat(path_feature_benign,label_list_benign(num+2).name));
clear solidity_benign_gland gland_ls_benign label_map ls_map median_phase_benign phase_map gland_phase_std_benign product gland_phase_med_benign m n;
disp(sprintf('Benign %d',num));
end
%end
core_number=0;
core_label_malignant=[];
core_index_malignant=0;
for num=1:1:(size(ls_list_malignant,1)-3)
label_map = imread(strcat(path_label_malignant,label_list_malignant(num+2).name));
[m,n]=size(label_map);
ls_map = imresize(imread(strcat(path_ls_malignant,ls_list_malignant(num+2).name)),[m n],'nearest');
phase_map = imresize(imread(strcat(path_phase_malignant,phase_list_malignant(num+2).name)),[m n],'nearest');
[gland_ls_malignant,solidity_malignant_gland,s_malignant_gland,gland_phase_std_malignant,gland_phase_med_malignant]=ls_extraction_glandwise_3fold(label_map,ls_map,label_list_malignant(num+2).name,core_number,phase_map,20);
phase_std_malignant=[phase_std_malignant gland_phase_std_malignant];
core_label_malignant = [core_label_malignant; (num)*ones(length(gland_ls_malignant),1)];
ls_glands_malignant=[ls_glands_malignant (gland_ls_malignant)];
solidity_malignant=[solidity_malignant (solidity_malignant_gland)];
s_malignant = [s_malignant s_malignant_gland];
phase_med_malignant=[phase_med_malignant gland_phase_med_malignant];
ls_core_wise_malignant(num)=nanmean(gland_ls_malignant);
solidity_core_wise_malignant(num)=nanmean(solidity_malignant_gland);
%ls_core_wise_malignant(num)=nanmedian(gland_ls_malignant);
%solidity_core_wise_malignant(num)=nanmedian(solidity_malignant_gland);
core_number=core_number+2;
%product=phase_map.*label_map;
%writeTIFF(product,strcat(path_feature_malignant,label_list_malignant(num+2).name));
%phase_malignant = [phase_malignant median_phase_malignant];
clear median_phase_malignant solidity_malignant_gland gland_ls_malignant label_map ls_map phase_map product gland_phase_med_malignant m n;
disp(sprintf('Malignant %d',num));
end
end
