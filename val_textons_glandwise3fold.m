function val_textons_glandwise3fold(flag,val_set_number)
%nrows=2355;
%ncols=2355;
radius=60;
windowsize=60;
if(flag==0)
    path_lm='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Benign\texdir\';
    path_lbl=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\val%d\\Benign\\',val_set_number);
    path_save_val=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Texton_separate_valandtrain\\val%d\\Benign\\',val_set_number);
    else
    path_lm='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Malignant\texdir\';
    path_lbl=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\val%d\\Malignant\\',val_set_number);
    path_save_val=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Texton_separate_valandtrain\\val%d\\Malignant\\',val_set_number);
end
   
    path_save_train=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Texton_separate_valandtrain\\train%d\\',val_set_number);
    %path_save_val='E:\FTLS\All_Cores\Core Images\16bit\texdir\val\';
    training_list_lm=dir(path_lm);
    training_list_lbl=dir(path_lbl);
    load(strcat(path_save_train,'kmeans_res_50_clusters.mat'));
    nfiles = size(training_list_lm,1)-2
    for fileidx=1:nfiles
       
        core_number=fileidx;
        label_file_name=training_list_lbl(core_number+2).name;
        label_image=imread(strcat(path_lbl,label_file_name));
        [nrows,ncols]=size(label_image)
        clear label_image;
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