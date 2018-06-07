function [all_benign_textons,all_malignant_textons]=gland_texton_medians(flag,core_list_b,core_list_m,set_number)
if(flag==0)
path_textons_benign=sprintf('Z:\\Hassaan\\DCIS\\Unstained\SLIM\\texton_train\\Texton_separate_valandtrain\\train%d\\Benign\\',set_number);
path_labels_benign=sprintf('Z:\\Hassaan\\DCIS\\Unstained\\SLIM\\texton_train\\Partitioned_glands\\tr%d\\Benign\\',set_number);
path_textons_malignant=sprintf('Z:\\Hassaan\\DCIS\\Unstained\SLIM\\texton_train\\Texton_separate_valandtrain\\train%d\\Malignant\\',set_number);
path_labels_malignant=sprintf('Z:\\Hassaan\\DCIS\\Unstained\\SLIM\\texton_train\\Partitioned_glands\\tr%d\\Malignant\\',set_number);    
else
path_textons_benign=sprintf('Z:\\Hassaan\\DCIS\\Unstained\SLIM\\texton_train\\Texton_separate_valandtrain\\val%d\\Benign\\',set_number);
path_labels_benign=sprintf('Z:\\Hassaan\\DCIS\\Unstained\\SLIM\\texton_train\\Partitioned_glands\\val%d\\Benign\\',set_number);
path_textons_malignant=sprintf('Z:\\Hassaan\\DCIS\\Unstained\SLIM\\texton_train\\Texton_separate_valandtrain\\val%d\\Malignant\\',set_number);
path_labels_malignant=sprintf('Z:\\Hassaan\\DCIS\\Unstained\\SLIM\\texton_train\\Partitioned_glands\\val%d\\Malignant\\',set_number);    
end

list_label_benign=dir(path_labels_benign);
list_textons_benign=dir(path_textons_benign);
list_label_malignant=dir(path_labels_malignant);
list_textons_malignant=dir(path_textons_malignant);
gland_textons_benign = [];
gland_textons_malignant = [];
nbenign=length(core_list_b);
nmalignant=length(core_list_m);

for num=1:1:nbenign
core_name=list_label_benign(core_list_b(num)+2).name
period_pos = strfind(core_name,'.');
image_label_benign = double(imread(strcat(path_labels_benign,core_name)));
data_texton_benign = load(strcat(path_textons_benign,core_name(1:period_pos-1),'_texton_hist_60.mat')); 
[sample_stroma_benign,sample_gland_benign] = texton_comparison(data_texton_benign,image_label_benign);
gland_textons_benign=[gland_textons_benign; (sample_gland_benign)];
%stroma_textons_benign=[stroma_textons_benign; (sample_stroma_benign)];
disp(sprintf('Benign %d',num));
clear core_name period_pos image_label_benign data_texton_benign sample_stroma_benign sample_gland_benign;
end

for num=1:1:nmalignant
core_name=list_label_malignant(core_list_m(num)+2).name
period_pos = strfind(core_name,'.');
image_label_malignant = double(imread(strcat(path_labels_malignant,core_name)));
data_texton_malignant = load(strcat(path_textons_malignant,core_name(1:period_pos-1),'_texton_hist_60.mat')); 
[sample_stroma_malignant,sample_gland_malignant] = texton_comparison(data_texton_malignant,image_label_malignant);
gland_textons_malignant=[gland_textons_malignant; (sample_gland_malignant)];

disp(sprintf('Malignant %d',num));
clear core_name period_pos image_label_benign data_texton_benign sample_stroma_benign sample_gland_benign;
end
all_benign_textons=gland_textons_benign;
all_malignant_textons=gland_textons_malignant;

end