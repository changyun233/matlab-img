clear all,close all, clc;
load ../../res/hall.mat;
load JpegCoeff.mat;
hall_gray = double(hall_gray);
[proc_graph,blocks,block_num,height,width] = GraphicsDivide(hall_gray-128);
origin_info = 'signal and system is fun';
info_bin = dec2bin(double(origin_info));
info_size = size(info_bin);
bin_num = info_size(1)*info_size(2);
temp = info_bin';
bin_seq = reshape(temp,[1,info_size(1)*info_size(2)]);
quanti_mat_DCT = zeros(8,8,block_num);
quanti_mat = zeros(64,block_num);
for i = 1 : 1 : block_num
    quanti_mat_DCT(:,:,i) = round(DCT(blocks(:,:,i))./QTAB);
    quanti_mat(:,i) = [quanti_mat_DCT(1,1,i);(ZigZag(quanti_mat_DCT(:,:,i))).'];
end
quanti_mat = int16(quanti_mat);
bin_cnt = 1;
for i = 1 : 1 : block_num
    for j = 64 : -1 : 2
        if quanti_mat(j,i) ~= 0
            if j~= 64
                if bin_seq(bin_cnt) == '1'
                    quanti_mat(j+1,i) = 1;
                else
                    quanti_mat(j+1,i) = -1;
                end
            else
                if bin_seq(bin_cnt) == '1'
                    quanti_mat(j,i) = 1;
                else
                    quanti_mat(j,i) = -1;
                end
            end
            bin_cnt = bin_cnt + 1;
            break;
        end
    end
    if bin_cnt > bin_num
        break;
    end
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
[image_DCT_3] = ImageReform(dct_mat,height,width);
imshow(uint8(image_DCT_3));
%imwrite(uint8(image_DCT_3),'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\dct_3.jpg');
[proc_graph_1,blocks_1,block_num_1,height_1,width_1] = GraphicsDivide(image_DCT_3-128);
for i = 1 : 1 : block_num
    dct_mat(:,:,i) = round(DCT(blocks_1(:,:,i))./QTAB);
end
dct_AC_seq = [];
for i = 1 : 1 : block_num
    dct_AC_seq = [dct_AC_seq,ZigZag(dct_mat(:,:,i))];
end
trans_bin = zeros(1,bin_num);
bin_cnt = 1;
i = 1;
while bin_cnt <= bin_num
    for j = 63*i : -1 : 63*(i-1)+1
        if dct_AC_seq(j) == 1
            trans_bin(bin_cnt) = 1;
            bin_cnt = bin_cnt + 1;
            break;
        end
        if dct_AC_seq(j) == -1
            trans_bin(bin_cnt) = 0;
            bin_cnt = bin_cnt + 1;
            break;
        end
    end
    i = i + 1;
end
info_trans = zeros(info_size(1),info_size(2));
for i = 1 : 1 : info_size(1)
    for j = 1 : 1 : info_size(2)
        info_trans(i,j) = char(trans_bin(info_size(2)*(i-1)+j)+48);
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
MSE = 1/pixel_num*sum(sum((image_DCT_3-double(hall_gray)).*(image_DCT_3-double(hall_gray))));
PSNR = 10*log10(255^2/MSE);
display(PSNR);
rate = cnt/(info_size(1)*info_size(2));
display(rate);
info_trans = char(bin2dec(char(info_trans)))';
display(info_trans);