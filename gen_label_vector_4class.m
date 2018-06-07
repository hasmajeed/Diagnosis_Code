function gland_labels=gen_label_vector_4class(label_map,flag)
[m,n]=size(label_map);
gland_labels=[];
    CC_gland = bwconncomp(label_map);
    for regions=1:1:size(CC_gland.PixelIdxList,2)
        if(flag==0)
        if(m==2048)
        gland_labels=[gland_labels 1];
        else
        gland_labels=[gland_labels 2];
        end
        end
        if(flag==1)
        if(m==2048)
        gland_labels=[gland_labels 4];
        else
        gland_labels=[gland_labels 3];
        end
        end
    end



end