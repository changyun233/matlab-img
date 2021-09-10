clear all, close all, clc;
load JpegCoeff.mat
load hall.mat
QTAB = 0.5*QTAB;
hall_gray = double(hall_gray);
[proc_graph,blocks,block_num,height,width] = GraphicsDivide(hall_gray-128);
quanti_mat_DCT = zeros(8,8,block_num);
quanti_mat = zeros(64,block_num);
for i = 1 : 1 : block_num
    quanti_mat_DCT(:,:,i) = round(DCT(blocks(:,:,i))./QTAB);
    quanti_mat(:,i) = [quanti_mat_DCT(1,1,i);(ZigZag_1(quanti_mat_DCT(:,:,i))).'];
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
[dct_DC_seq] = DecodeDC(code_DC);
[dct_AC_seq] = DecodeAC(code_AC);
block_num = height*width;
dct_AC_mat = zeros(8,8,block_num);
for i = 1 : 1 : block_num
    dct_AC_mat(:,:,i) = InverseZiZag(dct_AC_seq(63*(i-1)+1:63*i));
end
[dct_mat] = DctMatReform(dct_AC_mat,dct_DC_seq);
[image] = ImageReform_half(dct_mat,height,width);
%imwrite(uint8(image),'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\my.jpg');
imshow(uint8(image));
prim_size = size(hall_gray);
pixel_num = prim_size(1)*prim_size(2);
MSE = 1/pixel_num*sum(sum((image-double(hall_gray)).*(image-double(hall_gray))));
PSNR = 10*log10(255^2/MSE);
display(PSNR);
