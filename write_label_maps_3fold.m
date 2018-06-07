function write_label_maps_3fold(gland_part_benign,gland_part_malignant,flag,partnumber)
%flag is 0 for training and 1 for val
%partnumber is 1 for tr12 2 for tr23 and 3 for tr13
path_label_benign='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Partition_glands\label_maps_new\Benign\';
path_label_malignant='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Partition_glands\label_maps_new\Malignant\';
if(flag==0)
path_save=strcat('Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Partition_glands\',sprintf('tr%d\\',partnumber));
else
path_save=strcat('Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Partition_glands\',sprintf('val%d\\',partnumber));
end
list_benign=dir(path_label_benign);
list_malignant=dir(path_label_malignant);
core_numbers_benign=gland_part_benign(:,2);
core_numbers_malignant=gland_part_malignant(:,2);
size(list_benign,1)-3
size(list_malignant,1)-3

for num=1:1:size(list_benign,1)-3
idx_of_current_core=find(core_numbers_benign==num);
label_map=imread(strcat(path_label_benign,list_benign(num+2).name));
[m,n]=size(label_map);
CC_gland = bwconncomp(label_map);
label_map_train=zeros(m,n);
for gland=1:1:length(idx_of_current_core)
label_map(CC_gland.PixelIdxList{1,gland_part_benign(idx_of_current_core(gland),1)})=2;
label_map_train(CC_gland.PixelIdxList{1,gland_part_benign(idx_of_current_core(gland),1)})=1;
gland_part_benign(idx_of_current_core(gland),:)
end
dot_pos=strfind(list_benign(num+2).name,'.');
corestring=list_benign(num+2).name;
writeTIFF(label_map_train,strcat(path_save,corestring(1:dot_pos-1),'_train.tif'));
%writeTIFF(label_map,strcat(path_save,corestring(1:dot_pos-1),'_train_mod.tif'));
clear label_map label_map_train CC_gland idx_of_current_core;
disp(num);
end

for num=1:1:size(list_malignant,1)-3
idx_of_current_core=find(core_numbers_malignant==num);
label_map=imread(strcat(path_label_malignant,list_malignant(num+2).name));
[m,n]=size(label_map);
CC_gland = bwconncomp(label_map);
label_map_train=zeros(m,n);
for gland=1:1:length(idx_of_current_core)
label_map(CC_gland.PixelIdxList{1,gland_part_malignant(idx_of_current_core(gland),1)})=2;
label_map_train(CC_gland.PixelIdxList{1,gland_part_malignant(idx_of_current_core(gland),1)})=1;
gland_part_malignant(idx_of_current_core(gland),:)
end
dot_pos=strfind(list_malignant(num+2).name,'.');
corestring=list_malignant(num+2).name;
writeTIFF(label_map_train,strcat(path_save,corestring(1:dot_pos-1),'_train.tif'));
%writeTIFF(label_map,strcat(path_save,corestring(1:dot_pos-1),'_train_mod.tif'));
clear label_map label_map_train CC_gland idx_of_current_core;
disp(num);
end

end