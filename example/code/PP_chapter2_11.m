clear all, close all, clc;
load hall.mat;
load jpegcodes.mat;
[dct_DC_seq] = DecodeDC(code_DC);
[dct_AC_seq] = DecodeAC(code_AC);
block_num = height*width;
dct_AC_mat = zeros(8,8,block_num);
for i = 1 : 1 : block_num
    dct_AC_mat(:,:,i) = InverseZiZag(dct_AC_seq(63*(i-1)+1:63*i));
end
[dct_mat] = DctMatReform(dct_AC_mat,dct_DC_seq);
[image] = ImageReform(dct_mat,height,width);
%imwrite(uint8(image),'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\my.jpg');
imshow(uint8(image));
prim_size = size(hall_gray);
pixel_num = prim_size(1)*prim_size(2);
MSE = 1/pixel_num*sum(sum((image-double(hall_gray)).*(image-double(hall_gray))));
PSNR = 10*log10(255^2/MSE);
display(PSNR);
