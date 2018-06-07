function train_textons_glandwise(train_set_number,ntextons)
%nrows=4006;
%ncols=4006;
   
    path_lm_b='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Benign\texdir\';
    path_lbl_b=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\tr%d\\Benign\\',train_set_number);
   
    path_lm_m='Z:\Hassaan\HE_Scanner\Standard_Normal\Testing_LM_comparison_stained_unstained\stained_core_bigger_dataset\Malignant\texdir\';
    path_lbl_m=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Partitioned_glands\\tr%d\\Malignant\\',train_set_number);
    path_save_train=sprintf('Z:\\Hassaan\\HE_Scanner\\Standard_Normal\\Testing_LM_comparison_stained_unstained\\stained_core_bigger_dataset\\Texton_separate_valandtrain\\train%d\\',train_set_number);
    training_list_lm_b=dir(path_lm_b);
    training_list_lbl_b=dir(path_lbl_b);
    training_list_lm_m=dir(path_lm_m);
    training_list_lbl_m=dir(path_lbl_m);
    nspectraperclass = 10000;
    nbands = 18; %The number of filter response
    resamplefilterresponse = 0;
    filter_response = zeros(0,nbands);
    label_vect = zeros(0,nbands);
    nfiles_b = size(training_list_lm_b,1)-2%Number of tiff files
    nfiles_m =size(training_list_lm_m,1)-2
    %Create a dataset of filter responses for all the classes
    %benign      
        for fileidx=1:nfiles_b
            %{
            cur_file_name = training_list{fileidx,1};
            dot_pos = strfind(cur_file_name,'.'); %Get the position of the dot
            slash_pos = strfind(cur_file_name,'\');
            label_name = cur_file_name(slash_pos(end)+1:dot_pos(1)-1); %Extract the sa
            fr_file_name = strcat(pwd,'\texdir\',label_name,'_lm_fr.mat');%Name of the filter response
            label_file_name = strcat(labelpath,label_name,'_lbl.tif');
            %}
            core_number=fileidx;
            label_file_name=training_list_lbl_b(core_number+2).name;
            fr_file_name=training_list_lm_b(core_number+2).name;
            %if (exist(label_file_name))
                disp(['Adding random samples of: ' label_file_name ' ...']);
                load(strcat(path_lm_b,fr_file_name),'mr_data');
                %Load the label image
                lblim = imread(strcat(path_lbl_b,label_file_name));
                glandidx = find(lblim==1);
                nglandpix = length(glandidx) %Get number of gland and stroma pixs
                if(nglandpix<10000)
                    %selectedglandidx=nglandpix;
                    selectedglandidx = randperm(nglandpix);
                    nspectraperclass=nglandpix;
                else
                selectedglandidx = randperm(nglandpix);
                nspectraperclass=10000;
                end
                gland_subset=mr_data(...
                glandidx(selectedglandidx(1:nspectraperclass)),1:nbands);
                                       
                filter_response(end+1:end+nspectraperclass,:)=gland_subset;
                label_vect(end+1:end+nspectraperclass)=1;
          %end
          clear core_number label_file_name fr_file_name mr_data lblim glandidx selectedglandidx nspectraperclass nglandpix;
        end
        %malignant
               for fileidx=1:nfiles_m
            %{
            cur_file_name = training_list{fileidx,1};
            dot_pos = strfind(cur_file_name,'.'); %Get the position of the dot
            slash_pos = strfind(cur_file_name,'\');
            label_name = cur_file_name(slash_pos(end)+1:dot_pos(1)-1); %Extract the sa
            fr_file_name = strcat(pwd,'\texdir\',label_name,'_lm_fr.mat');%Name of the filter response
            label_file_name = strcat(labelpath,label_name,'_lbl.tif');
            %}
            core_number=fileidx;
            label_file_name=training_list_lbl_m(core_number+2).name;
            fr_file_name=training_list_lm_m(core_number+2).name;
            %if (exist(label_file_name))
                disp(['Adding random samples of: ' label_file_name ' ...']);
                load(strcat(path_lm_m,fr_file_name),'mr_data');
                %Load the label image
                lblim = imread(strcat(path_lbl_m,label_file_name));
                glandidx = find(lblim==1);
                nglandpix = length(glandidx); %Get number of gland and stroma pixs
                if(nglandpix<10000)
                    selectedglandidx = randperm(nglandpix);
                    nspectraperclass=nglandpix;
                else
                selectedglandidx = randperm(nglandpix);
                nspectraperclass=10000;
                end
                gland_subset=mr_data(...
                glandidx(selectedglandidx(1:nspectraperclass)),1:nbands);
                                       
                filter_response(end+1:end+nspectraperclass,:)=gland_subset;
                label_vect(end+1:end+nspectraperclass)=2;
          %end
          clear core_number label_file_name fr_file_name mr_data lblim glandidx nspectraperclass;
        end
        save(strcat(path_save_train,'texton_before_kmeans_training.mat'),'filter_response','label_vect');
        
     
    disp('Finding cluster centers...');
    retrain=1;
    computing_platform=0; %OpenCV-Mex functions (1) and MATLAB 0
    k_means_file_name = strcat(path_save_train,'kmeans_res_',num2str(ntextons),'_clusters.mat');
    %form filter response over images
    if ((~exist(k_means_file_name,'file'))||(retrain==1))
        tic
        load(strcat(path_save_train,'texton_before_kmeans_training.mat'));
        tic
        if (computing_platform==0) %Matlab k-means, which is 20x-60x slower than OpenCVMex k-means
            opts = statset('Display','iter', 'MaxIter',200);               
            [newidxmap,texton,compactness]=kmeans(filter_response,ntextons,'Options',opts,'Replicates',1,'Start','sample');
        else
            [newidxmap, texton,compactness] = kmeans(filter_response,ntextons,'Attempts',10); %Compactness is the empirical error
        end
        save(k_means_file_name,'texton','newidxmap','compactness');
        timeElapse= toc;
        disp(['Training time: ' num2str(timeElapse), ' (s)']);
    end
    
  
    
    
  
end