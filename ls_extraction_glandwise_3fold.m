function [gland_ls,gland_curve,solidity,phase_std,phase_med]=ls_extraction_glandwise_3fold(label_map,ls_map,core_string,core_number,phase_map,tune)
 %test=ls_map;
 %glands=find(label_map==1);
 %non_gland=find(label_map~=1);
 %label_map(non_gland)=0;

 CC_gland = bwconncomp(label_map);
 period_pos = strfind(core_string,'.');
 
 stats = regionprops(CC_gland,'solidity');
 curve_image = zeros(size(label_map));
 ls_image = zeros(size(label_map));
 
 
 for regions=1:1:size(CC_gland.PixelIdxList,2)
     dummy = zeros(size(label_map));
     ls_avg_region(regions) = median(ls_map(CC_gland.PixelIdxList{1,regions}));
     %ls_avg_region(regions) = nanmean(ls_map(CC_gland.PixelIdxList{1,regions}));
     phase_std(regions)= 5./((nanstd(phase_map(CC_gland.PixelIdxList{1,regions}))).^2);
     phase_med(regions) = nanmedian(phase_map(CC_gland.PixelIdxList{1,regions}));
     dummy(CC_gland.PixelIdxList{1,regions})=1;
     B=bwboundaries(dummy);
     V=B{1,1};
     Vertices=V(1:tune:end,:);
     %disp(length(V))
     Lines_new=[(1:size(Vertices,1))' (2:size(Vertices,1)+1)']; Lines_new(end,2)=1;
     curvature=LineCurvature2D(Vertices,Lines_new);
     gland_curve(regions) = nanmedian(abs(curvature));
     %gland_curve(regions) = nanmean(abs(curvature));
     solidity(regions) = stats(regions).Solidity;
     %curve_image(CC_gland.PixelIdxList{1,regions})=gland_curve(regions);
     %ls_image(CC_gland.PixelIdxList{1,regions})=ls_avg_region(regions);
     %median_phase(regions)= median(phase_map(CC_gland.PixelIdxList{1,regions}));
     %test(CC_gland.PixelIdxList{1,regions})=regions*1000;
     %disp(regions)
 end
 %{
 disp(sprintf('regions=%d',length(gland_curve)));
 writeTIFF(curve_image,strcat(path,core_string(1:period_pos-1),'curve.tif'));
 writeTIFF(ls_image,strcat(path,core_string(1:period_pos-1),'ls.tif'));

 xlswrite(strcat(path,'curve.xlsx'),char(core_string)',1,strcat(char(97+core_number),'1'));
 xlswrite(strcat(path,'ls.xlsx'),char(core_string)',1,strcat(char(97+core_number),'1'));
 xlswrite(strcat(path,'curve.xlsx'),gland_curve',1,strcat(char(98+core_number),'1:',char(98+core_number),sprintf('%d',length(gland_curve))));
 xlswrite(strcat(path,'ls.xlsx'),ls_avg_region',1,strcat(char(98+core_number),'1:',char(98+core_number),sprintf('%d',length(ls_avg_region))));
 
 save(strcat(path,core_string(1:period_pos-1),'curve.mat'),'gland_curve');
 save(strcat(path,core_string(1:period_pos-1),'ls.mat'),'ls_avg_region');
%}
 if(size(CC_gland.PixelIdxList,2)>0)
   gland_ls=ls_avg_region; 
 else
     gland_ls=[];
     gland_curve=[];
     solidity=[];
     phase_med=[];
     phase_std=[];
  end
 %gland_ls = ls_map(glands);
 stroma_ls=0;
 %figure;
 %imagesc(test);
 %figure;
 %imagesc(test2);
 %title('test2');
 %stroma_ls=ls_map(stroma);
 
 %pixels_gland=find(gland_ls_temp>7281.7);
 %pixels_stroma=find(stroma_ls_temp>7281.7);
 
 %gland_ls = gland_ls_temp(pixels_gland);
 %stroma_ls = stroma_ls_temp(pixels_stroma);

 
end