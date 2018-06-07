function [new_text_map]=vect_quant(mr_data,texton,nrows,ncols,computing_platform)
    %Perform vector quantization on the data return the map of nearest
    %textons
    ntextons = size(texton,1);
     npixels = size(mr_data,1);
     nbands = size(texton,2);
     if (computing_platform==0)
             dist_map = 1e+20*ones(npixels,1); %This matrix store the distance from current filter response to all the new texton
             new_text_map=ones(nrows,ncols);
             for newtextonIdx=1:ntextons
                 disp(['Checking texton ' num2str(newtextonIdx)])
                 cur_dist = sum((mr_data(:,1:nbands)-repmat(texton(newtextonIdx,:),[npixels 1])).^2,2); %Compute the distance to the current label                        )).^2,2); %Computing distance from the set of current texton to the common set
                 bestTextonIdx = find(cur_dist<dist_map);
                 new_text_map(bestTextonIdx)=newtextonIdx;
                 dist_map( bestTextonIdx)=cur_dist(bestTextonIdx); 
              end
      else
             %Compute the label with openCV using 1-NN - 12x
             %faster. 10 s/image
             kn=KNearest(texton,[1:ntextons]);
             new_text_map=kn.predict(mr_data(:,1:nbands));
             new_text_map=reshape(new_text_map,[nrows ncols]);
     end                   
end


    