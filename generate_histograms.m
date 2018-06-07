function generate_histograms(training_core_list,flag,train_or_val,train_set_number)
    
    nrows=2048;
    ncols=2048;
    ws=60;
    ntextons=20;   
    h = waitbar(0,'Calculating textons...');
    radius = ws;%In the 3072 x 3072 pixels image
    nsamples = size(training_core_list,1);
   
    if(flag==0)&&(train_or_val==0)
    path_lbl='W:\Hassaan\Breast_TMA\Breast_Diagnosis_Code_repository\16bit\label\Benign\';
    path_save_train=sprintf('W:\\Hassaan\\Breast_TMA\\Breast_Diagnosis_Code_repository\\16bit\\roundtwo_dim50\\train%d\\Benign\\',train_set_number);
    elseif(flag==0)&&(train_or_val==1)
    path_lbl='W:\Hassaan\Breast_TMA\Breast_Diagnosis_Code_repository\16bit\label\Benign\';
    path_save_train=sprintf('W:\\Hassaan\\Breast_TMA\\Breast_Diagnosis_Code_repository\\16bit\\roundtwo_dim50\\train%d\\Benign\\',train_set_number);
        elseif(flag==1)&&(train_or_val==0)
    path_lbl='W:\Hassaan\Breast_TMA\Breast_Diagnosis_Code_repository\16bit\label\Malignant\';
    path_save_train=sprintf('W:\\Hassaan\\Breast_TMA\\Breast_Diagnosis_Code_repository\\16bit\\roundtwo_dim50\\train%d\\Malignant\\',train_set_number);
    else
     path_lbl='W:\Hassaan\Breast_TMA\Breast_Diagnosis_Code_repository\16bit\label\Malignant\';
     path_save_train=sprintf('W:\\Hassaan\\Breast_TMA\\Breast_Diagnosis_Code_repository\\16bit\\roundtwo_dim50\\train%d\\Malignant\\',train_set_number);   
    end
    training_list_lbl=dir(path_lbl);
    for sampleIdx=1:nsamples
           waitbar(sampleIdx/nsamples,h,'Progress...')
           core_number=training_core_list(sampleIdx);
           
           % cur_file_name = filenames{classidx,1}{sampleIdx,1};
            label_file_name=training_list_lbl(core_number+2).name;
            period_pos = strfind(label_file_name,'.');
            texton_idx_file_name = strcat(label_file_name(1:period_pos-1),'_texton.tif'); %This is the label in large dataset
            texton_hist_file_name =  strcat(label_file_name(1:period_pos-1),'_texton_hist_',num2str(radius),'.mat');
            
            disp(['Processing image: ' label_file_name ' ...']);
            %lbl_file_name = strcat(label_name,'_resized.mat');
            computingPlatform = 0;
            new_text_map = imread(strcat(path_save_train,texton_idx_file_name));
            if ((~exist(strcat(path_save_train,texton_hist_file_name)))||(retrain==1))
                
                %Downsample the texton index image and the lbl image to
                %save some space
                new_text_map = imresize(new_text_map,[nrows ncols],'nearest');
                %Convert into the pixel-wise distribution
                tic;
                histim = computehistogramoftexton(new_text_map,ntextons,radius);
                save(strcat(path_save_train,texton_hist_file_name),'histim','-v7.3');             
                timeElap = toc;
                disp(['Time elapse: ' num2str(timeElap)]);
                          
            end       
    end

    close(h);



end