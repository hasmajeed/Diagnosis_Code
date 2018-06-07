clc;
clear all;
close all;
path_save='Z:\Hassaan\HE_Scanner\BR1003_11_11_2017\RGB2GRAY\SLIM\Cores\Partitioned_glands\';
for val=1:1:3
path_lbl_benign=strcat('Z:\Hassaan\HE_Scanner\BR1003_11_11_2017\RGB2GRAY\SLIM\Cores\Partitioned_glands\',sprintf('val%d\\Benign\\',val));
path_lbl_malignant=strcat('Z:\Hassaan\HE_Scanner\BR1003_11_11_2017\RGB2GRAY\SLIM\Cores\Partitioned_glands\',sprintf('val%d\\Malignant\\',val));
list_benign=dir(path_lbl_benign);
list_malignant=dir(path_lbl_malignant);
gland_labels_benign=[];
gland_labels_malignant=[];
for num=1:1:size(list_benign,1)-3
    label_map=imread(strcat(path_lbl_benign,list_benign(num+2).name));
    gland_labels=gen_label_vector_4class(label_map,0);
    gland_labels_benign=[gland_labels_benign; gland_labels' num*ones(length(gland_labels),1)];
    clear label_map gland_labels;
    disp(num)
end
for num=1:1:size(list_malignant,1)-2
    label_map=imread(strcat(path_lbl_malignant,list_malignant(num+2).name));
    gland_labels=gen_label_vector_4class(label_map,1);
    gland_labels_malignant=[gland_labels_malignant; gland_labels' num*ones(length(gland_labels),1)];
    clear label_map gland_labels;
    disp(num)
end
save(strcat(path_save,sprintf('gland_labels_benign_val%d_w_core',val)),'gland_labels_benign');
save(strcat(path_save,sprintf('gland_labels_malignant_val%d_w_core',val)),'gland_labels_malignant');
end