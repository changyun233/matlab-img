clear all,close all, clc;
load hall.mat;
load JpegCoeff.mat;
hall_gray = double(hall_gray);
[proc_graph,blocks,block_num,height,width] = GraphicsDivide(hall_gray-128);
origin_info = 'signal and system is fun';
info_bin = dec2bin(double(origin_info));
info_size = size(info_bin);
quanti_mat_DCT = zeros(8,8,block_num);
quanti_mat = zeros(64,block_num);
for i = 1 : 1 : block_num
    quanti_mat_DCT(:,:,i) = round(DCT(blocks(:,:,i))./QTAB);
end
quanti_mat = int16(quanti_mat);
quanti_mat_DCT = int16(quanti_mat_DCT);
list = [];
for i = 1 : 1 : info_size(1)
    for j = 1 : 1 : info_size(2)
        num = info_size(2)*(i-1)+j;
        index_3 = floor((num-1)/64)+1;
        index_1 = floor((num - 64*(index_3-1)-1)/8)+1;
        index_2 = mod(num - 64*(index_3-1)-1,8)+1;
        temp = quanti_mat_DCT(index_1,index_2,index_3);
        temp = Mydec2bin(temp);
        temp(length(temp)) = info_bin(i,j);
        quanti_mat_DCT(index_1,index_2,index_3) = Mybin2dec(temp);
    end
end
for i = 1 : 1 : block_num
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
code_AC = str2num(code_AC(:))';
code_DC = str2num(code_DC(:))';
[dct_AC_seq] = DecodeAC(code_AC);
[dct_DC_seq] = DecodeDC(code_DC);
dct_AC_mat = zeros(8,8,block_num);
for i = 1 : 1 : block_num
    dct_AC_mat(:,:,i) = InverseZiZag(dct_AC_seq(63*(i-1)+1:63*i));
end
[dct_mat] = DctMatReform(dct_AC_mat,dct_DC_seq);
[image_DCT_1] = ImageReform(dct_mat,height,width);
imshow(uint8(image_DCT_1));
%imwrite(uint8(image_DCT_1),'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_3\\dct_1.jpg');
[proc_graph_1,blocks_1,block_num_1,height_1,width_1] = GraphicsDivide(image_DCT_1-128);
for i = 1 : 1 : block_num
    dct_mat(:,:,i) = round(DCT(blocks_1(:,:,i))./QTAB);
end
info_trans = zeros(info_size(1),info_size(2));
for i = 1 : 1 : info_size(1)
    for j = 1 : 1 : info_size(2)
        num = info_size(2)*(i-1)+j;
        index_3 = floor((num-1)/64)+1;
        index_1 = floor((num - 64*(index_3-1)-1)/8)+1;
        index_2 = mod(num - 64*(index_3-1)-1,8)+1;
        list = [list,[index_1;index_2;index_3]];
        temp = dct_mat(index_1,index_2,index_3);
        temp = Mydec2bin(temp);
        info_trans(i,j) = temp(length(temp));
    end
end
rate = 0;
cnt = 0;
for i = 1 : 1 : info_size(1)
    for j = 1 : 1 : info_size(2)
        if  info_trans(i,j) == info_bin(i,j)
            cnt = cnt + 1;
        end
    end
end
pixel_num = 64*block_num;
MSE = 1/pixel_num*sum(sum((image_DCT_1-double(hall_gray)).*(image_DCT_1-double(hall_gray))));
PSNR = 10*log10(255^2/MSE);
display(PSNR);
rate = cnt/(info_size(1)*info_size(2));
display(rate);
info_trans = char(bin2dec(char(info_trans)))';
display(info_trans);