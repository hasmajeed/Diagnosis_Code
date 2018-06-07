function histim = computehistogramoftexton(new_text_map,ntextons,radius)
    %Compute the histogram of texons
      nrows = size(new_text_map,1);
      ncols = size(new_text_map,2);
     npixels = nrows*ncols;    
    pixelidx=[1:npixels];
    pixelidx=pixelidx(:); %Line up current coordinates of the pixels
    x_offset = [-radius radius radius -radius];
    y_offset = [-radius -radius radius radius];
    [y_coord,x_coord]=ind2sub([nrows ncols], pixelidx); %Row and column indices of current pixels
    y_coord = y_coord(:);
    x_coord = x_coord(:);
    diff_coord = x_offset*nrows+y_offset; %Difference to the center pixel
    %Calculate the coordinates of 4 corners of all pixels
    neigh_x = repmat(x_coord,[1 4])+ones(npixels,1)*x_offset;
    neigh_y = repmat(y_coord,[1 4])+ones(npixels,1)*y_offset;
    %Check for boundary conditions
    idx = find(neigh_x<1);
    neigh_x(idx)=1;
    idx = find(neigh_x>ncols);
    neigh_x(idx)=ncols;
    idx = find(neigh_y<1);
    neigh_y(idx)=1;
    idx = find(neigh_y>nrows);
    neigh_y(idx)=nrows;
    %Convert into linear indexing....
    neigh_coord=sub2ind([nrows ncols],neigh_y,neigh_x);
    %Compute the number of neighbors for each pixels
    nneighbors = (neigh_x(:,2)-neigh_x(:,1)+1).*(neigh_y(:,3)-neigh_y(:,2)+1);
      histim = zeros(nrows,ncols,ntextons);
      disp('Calculating histogram of texton....');
      hist_filter = fspecial('gaussian',[round(2*radius) round(2*radius)],radius/5);
      for textonIdx=1:ntextons %Go through every texton
        disp(['Working with texton index ' num2str(textonIdx)])
        idxIm = zeros(nrows,ncols);
        idx = find(new_text_map==textonIdx);
        idxIm(idx)=1;
        idxIm = imfilter(idxIm,hist_filter,'same');
        idxIm = integralImage(idxIm);
        idxIm = cast(idxIm(1:end-1,1:end-1),'single');
        curim = zeros(nrows,ncols);
        curintIm = idxIm;
        curim(pixelidx) = curintIm(neigh_coord(:,3))+curintIm(neigh_coord(:,1))-...
        curintIm(neigh_coord(:,4))-curintIm(neigh_coord(:,2));
                    %Normalize by how many pixels in the neighborhood
                   %curim(pixelidx)= curim(pixelidx)./nneighbors;
        histim(:,:,textonIdx)=cast(curim,'uint16');
      end
end