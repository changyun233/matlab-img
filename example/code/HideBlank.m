function [image_hide,info_size] = HideBlank(origin_info,prim_image)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
    %load C:\\Users\\HJSF\\Desktop\\Dynamic\\图像处理大作业\\图像处理所需资源\\hall.mat;
    temp_info = dec2bin(double(origin_info));
    info_size = size(temp_info);
    info = zeros(info_size(1),info_size(2));
    for i = 1 : 1 : info_size(1)
        for j = 1 : 1 : info_size(2)
            info(i,j) = temp_info(i,j)-48;
        end
    end
    image_hide = prim_image;
    for i = 1 : 1 : info_size(1)
        for j = 1 : 1 : info_size(2)
            if info(i,j) == 0
                if mod(prim_image(i,j),2) == 1
                    image_hide(i,j) = prim_image(i,j) - 1;
                end
            else
                if mod(prim_image(i,j),2) == 0
                    image_hide(i,j) = prim_image(i,j)+1;
                end
            end
        end
    end
end

