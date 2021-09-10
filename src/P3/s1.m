clear all,close all, clc;
load ../../res/hall.mat;
[proc_graph,blocks,block_num,height,width] = GraphicsDivide(hall_gray);
origin_info = 'signal and system is very fun';
info_bin = dec2bin(double(origin_info));
info_size = size(info_bin);
for i = 1 : 1 : info_size(1)
    for j = 1 : 1 : info_size(2)
        temp = dec2bin(proc_graph(i,j));
        temp(length(temp)) = info_bin(i,j);
        proc_graph(i,j) = bin2dec(temp);
    end
end
%imwrite(uint8(proc_graph),'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_3\\figure3.1(¼ÓÃÜ).jpg');
figure;
imshow(uint8(proc_graph));
info_trans_1 = InfoTranslate(proc_graph,info_size);
display(info_trans_1);

[code_AC,code_DC] = ImageEncode(proc_graph);
[image_hide_decode] = ImageDecode(code_AC,code_DC,height,width);
%imwrite(uint8(image_hide_decode),'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_3\\figure3.1(½âÂë).jpg');
figure;
imshow(uint8(image_hide_decode));
pixel_num = 64*block_num;
MSE = 1/pixel_num*sum(sum((proc_graph-double(hall_gray)).*(proc_graph-double(hall_gray))));
PSNR = 10*log10(255^2/MSE);
display(PSNR);
[info_trans_2] = InfoTranslate(image_hide_decode,info_size);
display(info_trans_2);