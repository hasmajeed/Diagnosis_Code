function val_textons(val_core_list,flag,val_set_number)
nrows=2048;
ncols=2048;
radius=60;
windowsize=60;
if(flag==0)
    path_lm='W:\Hassaan\Breast_TMA\Breast_Diagnosis_Code_repository\16bit\texdir\Max_response\Benign\';
    path_lbl='W:\Hassaan\Breast_TMA\Breast_Diagnosis_Code_repository\16bit\label\Benign\';
    path_save_val=sprintf('W:\\Hassaan\\Breast_TMA\\Breast_Diagnosis_Code_repository\\16bit\\roundtwo_dim50\\val%d\\Benign\\',val_set_number);
    else
    path_lm='W:\Hassaan\Breast_TMA\Breast_Diagnosis_Code_repository\16bit\texdir\Max_response\Malignant\';
    path_lbl='W:\Hassaan\Breast_TMA\Breast_Diagnosis_Code_repository\16bit\label\Malignant\';
    path_save_val=sprintf('W:\\Hassaan\\Breast_TMA\\Breast_Diagnosis_Code_repository\\16bit\\roundtwo_dim50\\val%d\\Malignant\\',val_set_number);
end
   
    path_save_train=sprintf('W:\\Hassaan\\Breast_TMA\\Breast_Diagnosis_Code_repository\\16bit\\roundtwo_dim50\\train%d\\',val_set_number);
    %path_save_val='E:\FTLS\All_Cores\Core Images\16bit\texdir\val\';
    training_list_lm=dir(path_lm);
    training_list_lbl=dir(path_lbl);
    load(strcat(path_save_train,'kmeans_res_50_clusters.mat'));
    nfiles = size(val_core_list,1);
    for fileidx=1:nfiles
       
        core_number=val_core_list(fileidx);
        label_file_name=training_list_lbl(core_number+2).name;
        period_pos = strfind(label_file_name,'.');
        fr_file_name=training_list_lm(core_number+2).name;
        load(strcat(path_lm,fr_file_name),'mr_data');
        new_text_map = vect_quant(mr_data,texton,nrows,ncols,0); %Vector quantization on the texton
        subplot(222);imagesc(new_text_map);colormap jet;title('Texton indexing map');
        ntextons = size(texton,1);
        histim = computehistogramoftexton(new_text_map,ntextons,windowsize);
        texton_hist_file_name =  strcat(label_file_name(1:period_pos-1),'_texton_hist_',num2str(radius),'.mat');
        save(strcat(path_save_val,texton_hist_file_name),'histim','-v7.3'); 
    end
end