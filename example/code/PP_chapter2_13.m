clear all,close all,clc;
load JpegCoeff.mat
load snow.mat
snow = double(snow);
[proc_graph,blocks,block_num,height,width] = GraphicsDivide(snow-128);
quanti_mat_DCT = zeros(8,8,block_num);
quanti_mat = zeros(64,block_num);
temp = zeros(8,8,block_num);
for i = 1 : 1 : block_num
    quanti_mat_DCT(:,:,i) = round(DCT(blocks(:,:,i))./QTAB);
    temp(:,:,i) = DCT(blocks(:,:,i));
    quanti_mat(:,i) = [quanti_mat_DCT(1,1,i);(ZigZag(quanti_mat_DCT(:,:,i))).'];
end
quanti_mat = int16(quanti_mat);
seq_DC = zeros(1,block_num);
seq_AC = zeros(block_num,63);
code_AC = [];
for i = 1 : 1 : block_num
    if i == 1
        seq_DC(i) = quanti_mat(1,i);
    else
        seq_DC(i) = quanti_mat(1,i-1)-quanti_mat(1,i);
    end
    seq_AC(i,:) = (quanti_mat(2:64,i)).';
end
code_DC = EncodeDC(seq_DC);
for i = 1 : 1 : block_num
    code_AC = [code_AC,EncodeAC(seq_AC(i,:))];
end
code_AC = logical(str2num(code_AC(:))');
code_DC = logical(str2num(code_DC(:))');
[dct_AC_seq] = DecodeAC(code_AC);
[dct_DC_seq] = DecodeDC(code_DC);
block_num = height*width;
dct_AC_mat = zeros(8,8,block_num);
cnt = 0;
for i = 1 : 1 : block_num
    dct_AC_mat(:,:,i) = InverseZiZag(dct_AC_seq(63*(i-1)+1:63*i));
end
[dct_mat] = DctMatReform(dct_AC_mat,dct_DC_seq);
[image] = ImageReform(dct_mat,height,width);
%imwrite(uint8(image),'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\snow_1.jpg');
imshow(uint8(image));
prim_size = size(snow);
pixel_num = prim_size(1)*prim_size(2);
MSE = 1/pixel_num*sum(sum((image-double(snow)).*(image-double(snow))));
PSNR = 10*log10(255*255/MSE);
display(PSNR);