function [image] = ImageReform_half(dct_mat,height,width)
    load JpegCoeff.mat;
    QTAB = QTAB*0.5;
    mat_size = size(dct_mat);
    mat_num = mat_size(3);
    image_blocks = zeros(8,8,mat_num);
    for i = 1 : 1 : mat_num
        image_blocks(:,:,i) = IDCT(dct_mat(:,:,i).*QTAB);
    end
    for i = 1 : 1 : mat_num
        image(floor((i-1)/width)*8+1:floor((i-1)/width)*8+8,mod(i-1,width)*8+1:mod(i-1,width)*8+8) = image_blocks(:,:,i);
    end
    image = image + 128;
end


