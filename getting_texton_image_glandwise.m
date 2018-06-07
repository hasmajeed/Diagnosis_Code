function getting_texton_image_glandwise(flag,train_set_number,texton_number)
%nrows=2355;
%ncols=2355;
computing_platform=0; %OpenCV-Mex functions (1) and MATLAB 0   
if(flag==0)
path_lm='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Benign\texdir\';
path_lbl=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\tr%d\\Benign\\',train_set_number);
path_save_texton=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Texton_separate_valandtrain\\train%d\\Benign\\',train_set_number);
else   
path_lm='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Malignant\texdir\';
path_lbl=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\tr%d\\Malignant\\',train_set_number);    
path_save_texton=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Texton_separate_valandtrain\\train%d\\Malignant\\',train_set_number);
end
retrain=1;
ntextons=texton_number; 
training_list_lm=dir(path_lm)
training_list_lbl=dir(path_lbl);

            %Load the dictionary of texton and find the best matching index for
            %each pixel in the dataset
            path_save_train=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Texton_separate_valandtrain\\train%d\\',train_set_number);
            k_means_file_name=strcat(path_save_train,'kmeans_res_',num2str(ntextons),'_clusters.mat');
            load(k_means_file_name);
              
            %Vector quantization on the dictionary of the overall textons. 
            nsamples = size(training_list_lm,1)-2;
            for fileidx=1:nsamples
                     core_number=fileidx;
                     label_file_name=training_list_lbl(core_number+2).name;
                     label_image=imread(strcat(path_lbl,label_file_name));
                     [nrows,ncols]=size(label_image)
                     clear label_image;
                     period_pos = strfind(label_file_name,'.');
                     tx_file_name = strcat(path_save_texton,label_file_name(1:period_pos-1),'_texton.tif'); %Load the texton map for current image
                     fr_file_name=training_list_lm(core_number+2).name;%Name of the filter response
                     disp(['Re-assigning index based on general textons: ' label_file_name ' ...']);
                     if ((~exist(strcat(tx_file_name)))||(retrain==1))
                          tic
                           load(strcat(path_lm,fr_file_name),'mr_data'); %Load the current texton map and the maximum response data
                           new_text_map = vect_quant(mr_data,texton,nrows,ncols,computing_platform); %Vector quantization on the texton
                           timeElap = toc;
                           disp(['Vector quantization time: ' num2str(timeElap)]);
                      else
                               load(strcat(tx_file_name));
                      end
                      figure(1);
                      imagesc(new_text_map);
                      colorbar
                      drawnow
                      title('New indexing map');
                      writeTIFF(new_text_map,tx_file_name); %Save the texton indexing image 
             end
    end 