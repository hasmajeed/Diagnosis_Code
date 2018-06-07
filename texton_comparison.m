function [consolidated_stroma consolidated_gland]=texton_comparison(data_texton,image_label,texton_num)
%stroma_pixels = find(image_label==2);
gland_pixels = find(image_label==1);

%test_stroma = image_label;
test_gland = image_label;

non_gland_pixels = find(image_label~=1);
test_gland(non_gland_pixels)=0;
CC_glands = bwconncomp(test_gland);

%non_stroma_pixels = find(image_label~=2);
%test_stroma(non_stroma_pixels)=0;
%CC_stroma = bwconncomp(test_stroma);

consolidated_stroma=[];
consolidated_gland=[];

for regions=1:1:size(CC_glands.PixelIdxList,2)
for texton_num=1:1:texton_num
temp = data_texton.histim(:,:,texton_num);
gland_textons(:,texton_num)= (temp(CC_glands.PixelIdxList{1,regions}));
clear temp;
end
%{
if(size(gland_textons,1)>50)
sample_gland = datasample(gland_textons,10,1,'Replace',false);
else
sample_gland = gland_textons;
end
%}
sample_gland = median(gland_textons,1);
%sample_gland = mean(gland_textons,1);
consolidated_gland = [consolidated_gland; sample_gland];
clear gland_textons sample_gland;
end
%{
for regions=1:1:size(CC_stroma.PixelIdxList,2)
for texton_num=1:1:50
temp = data_texton.histim(:,:,texton_num);
stroma_textons(:,texton_num) = (temp(CC_stroma.PixelIdxList{1,regions}));
clear temp;
end
if(size(stroma_textons,1)>50)
sample_stroma = datasample(stroma_textons,50,1,'Replace',false);
else
sample_stroma = stroma_textons;
end
consolidated_stroma = [consolidated_stroma; sample_stroma];
clear stroma_textons sample_stroma;
end
%}

%sample_stroma = consolidated_stroma;
%sample_gland = consolidated_gland;
end