clear all,close all, clc;
load ../../res/hall.mat;
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
for i = 1 : 1 : info_size(1)
    for j = 1 : 1 : info_size(2)
        num = info_size(2)*(i-1)+j;
        temp = quanti_mat_DCT(1,1,num);
        temp = Mydec2bin(temp);
        temp(length(temp)) = info_bin(i,j);
        quanti_mat_DCT(1,1,num) = Mybin2dec(temp);
    end
end
for i = 1 : 1 : block_num
    quanti_mat(:,i) = [quanti_mat_DCT(1,1,i);(ZigZag(quanti_mat_DCT(:,:,i))).'];
end
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
[image_DCT_2] = ImageReform(dct_mat,height,width);
imshow(uint8(image_DCT_2));
%imwrite(uint8(image_DCT_2),'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\dct_2.jpg');
[proc_graph_1,blocks_1,block_num_1,height_1,width_1] = GraphicsDivide(image_DCT_2-128);
for i = 1 : 1 : block_num
    dct_mat(:,:,i) = round(DCT(blocks_1(:,:,i))./QTAB);
end
info_trans = zeros(info_size(1),info_size(2));
for i = 1 : 1 : info_size(1)
    for j = 1 : 1 : info_size(2)
        num = info_size(2)*(i-1)+j;
        temp = dct_mat(1,1,num);
        temp = Mydec2bin(temp);
        info_trans(i,j) = temp(length(temp));
    end
end
cnt = 0;
for i = 1 : 1 : info_size(1)
    for j = 1 : 1 : info_size(2)
        if  info_trans(i,j) == info_bin(i,j)
            cnt = cnt + 1;
        end
    end
end
pixel_num = 64*block_num;
MSE = 1/pixel_num*sum(sum((image_DCT_2-double(hall_gray)).*(image_DCT_2-double(hall_gray))));
PSNR = 10*log10(255^2/MSE);
display(PSNR);
rate = cnt/(info_size(1)*info_size(2));
display(rate);
info_trans = char(bin2dec(char(info_trans)))';
display(info_trans);