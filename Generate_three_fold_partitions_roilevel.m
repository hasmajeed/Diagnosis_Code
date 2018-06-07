clear all;
close all;
clc;

%path to the label_maps
path_label_benign='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Partition_glands\label_maps_new\Benign\';
path_label_malignant='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Partition_glands\label_maps_new\Malignant\';
path_save='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Partition_glands\';
path_save_gland_index='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Partition_glands\gland_index_map\';
%path_save_label_map_new='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\unstained_core_bigger_dataset\Partitioned_glands\label_map_new\';
%list of cores at paths
list_benign=dir(path_label_benign);
list_malignant=dir(path_label_malignant);

gland_num_core_num_benign=[];
%Open each label map, assign a gland number and core number
for num=1:1:size(list_benign,1)-3
label_map=imread(strcat(path_label_benign,list_benign(num+2).name));
gland_index=label_map;
label_map_new=label_map;
CC_gland = bwconncomp(label_map);
gland_num_core_num_benign=[gland_num_core_num_benign; (1:CC_gland.NumObjects)' num*ones(CC_gland.NumObjects,1)];
disp(CC_gland.NumObjects)

for count=1:CC_gland.NumObjects
gland_index(CC_gland.PixelIdxList{1,count})=count;
if(count==1||count==6)
label_map_new(CC_gland.PixelIdxList{1,count})=0;
end
end
writeTIFF(gland_index,strcat(path_save_gland_index,list_benign(num+2).name));
%writeTIFF(label_map_new,strcat(path_save_label_map_new,list_benign(num+2).name));

clear CC_gland label_map gland_index label_map_new;
end

gland_num_core_num_malignant=[];
%Open each label map, assign a gland number and core number
for num=1:1:size(list_malignant,1)-3
label_map=imread(strcat(path_label_malignant,list_malignant(num+2).name));
gland_index=label_map;
label_map_new=label_map;
CC_gland = bwconncomp(label_map);
gland_num_core_num_malignant=[gland_num_core_num_malignant; (1:CC_gland.NumObjects)' num*ones(CC_gland.NumObjects,1)];
disp(CC_gland.NumObjects)

for count=1:CC_gland.NumObjects
gland_index(CC_gland.PixelIdxList{1,count})=count;
if(count==2||count==10||count==6||count==9||count==5||count==11||count==15||count==16||count==23)
label_map_new(CC_gland.PixelIdxList{1,count})=0;
end
end
writeTIFF(gland_index,strcat(path_save_gland_index,list_malignant(num+2).name));
%writeTIFF(label_map_new,strcat(path_save_label_map_new,list_malignant(num+2).name));

clear CC_gland label_map gland_index;
end

k=3;
%Partition 2/3rd
[gland_tr_benign,idx_tr_benign]=datasample(gland_num_core_num_benign,ceil(((k-1)/(k))*length(gland_num_core_num_benign)),1,'Replace',false);
[gland_tr_malignant,idx_tr_malignant]=datasample(gland_num_core_num_malignant,ceil(((k-1)/(k))*length(gland_num_core_num_malignant)),1,'Replace',false);

gland_val1_benign=gland_num_core_num_benign;
gland_val1_benign(idx_tr_benign,:)=[];
gland_val1_malignant=gland_num_core_num_malignant;
gland_val1_malignant(idx_tr_malignant,:)=[];
gland_tr3_benign=gland_val1_benign;
gland_tr3_malignant=gland_val1_malignant;

[gland_tr1_benign,idx_tr1_benign]=datasample(gland_tr_benign,ceil(((k-2)/(k-1))*length(gland_tr_benign)),1,'Replace',false);
[gland_tr1_malignant,idx_tr1_malignant]=datasample(gland_tr_malignant,ceil(((k-2)/(k-1))*length(gland_tr_malignant)),1,'Replace',false);

gland_tr2_benign=gland_tr_benign;
gland_tr2_benign(idx_tr1_benign,:)=[];
gland_tr2_malignant=gland_tr_malignant;
gland_tr2_malignant(idx_tr1_malignant,:)=[];

%All three training sets
gland_tr12_benign=[gland_tr1_benign; gland_tr2_benign];
gland_tr12_malignant=[gland_tr1_malignant; gland_tr2_malignant];
gland_tr23_benign=[gland_tr2_benign; gland_tr3_benign];
gland_tr23_malignant=[gland_tr2_malignant; gland_tr3_malignant];
gland_tr13_benign=[gland_tr1_benign; gland_tr3_benign];
gland_tr13_malignant=[gland_tr1_malignant; gland_tr3_malignant];

%All three validation sets
gland_val2_benign=gland_tr1_benign;
gland_val2_malignant=gland_tr1_malignant;
gland_val3_benign=gland_tr2_benign;
gland_val3_malignant=gland_tr2_malignant;

save(strcat(path_save,'gland_tr12_benign.mat'),'gland_tr12_benign');
save(strcat(path_save,'gland_tr12_malignant.mat'),'gland_tr12_malignant');
save(strcat(path_save,'gland_tr23_benign.mat'),'gland_tr23_benign');
save(strcat(path_save,'gland_tr23_malignant.mat'),'gland_tr23_malignant');
save(strcat(path_save,'gland_tr13_benign.mat'),'gland_tr13_benign');
save(strcat(path_save,'gland_tr13_malignant.mat'),'gland_tr13_malignant');
save(strcat(path_save,'gland_val1_benign.mat'),'gland_val1_benign');
save(strcat(path_save,'gland_val1_malignant.mat'),'gland_val1_malignant');
save(strcat(path_save,'gland_val2_benign.mat'),'gland_val2_benign');
save(strcat(path_save,'gland_val2_malignant.mat'),'gland_val2_malignant');
save(strcat(path_save,'gland_val3_benign.mat'),'gland_val3_benign');
save(strcat(path_save,'gland_val3_malignant.mat'),'gland_val3_malignant');