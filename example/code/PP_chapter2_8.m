clear all, close all, clc;
load JpegCoeff.mat
load hall.mat
hall_gray = double(hall_gray);
[proc_graph,blocks,block_num,height,width] = GraphicsDivide(hall_gray-128);
mat_DCT = zeros(8,8,block_num);
quanti_mat = zeros(64,block_num);
for i = 1 : 1 : block_num
    mat_DCT(:,:,i) = DCT(blocks(:,:,i));
    quanti_mat(:,i) = [mat_DCT(1,1,i);(ZigZag(mat_DCT(:,:,i))).'];
end
quanti_mat = int16(quanti_mat);
