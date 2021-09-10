clear all, close all, clc;
load hall.mat
hall_gray = double(hall_gray);
[proc_graph,blocks,block_num,height,width] = GraphicsDivide(hall_gray-128);
tr_blocks = zeros(8,8,block_num);
rot90_blocks = zeros(8,8,block_num);
rot180_blocks = zeros(8,8,block_num);
temp = zeros(8,8);
for i = 1 : 1 : block_num
    temp = DCT(blocks(:,:,i)); 
    tr_blocks(:,:,i) = temp.';
    tr_blocks(:,:,i) = IDCT(tr_blocks(:,:,i));
    rot90_blocks(:,:,i) = rot90(temp,1);
    rot90_blocks(:,:,i) = IDCT(rot90_blocks(:,:,i));
    rot180_blocks(:,:,i) = rot90(temp,2);
    rot180_blocks(:,:,i) = IDCT(rot180_blocks(:,:,i));
end
image_tr = BlockReform(tr_blocks,height,width);
image_tr = uint8(image_tr+128);
figure;
imshow(image_tr);
image_rot90 = BlockReform(rot90_blocks,height,width);
image_rot90 = uint8(image_rot90+128);
figure;
imshow(image_rot90);
image_rot180 = BlockReform(rot180_blocks,height,width);
image_rot180 = uint8(image_rot180+128);
figure;
imshow(image_rot180);
%imwrite(image_tr,'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\TransferDCT.jpg');
%imwrite(image_rot90,'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\Rotate90DCT.jpg');
%imwrite(image_rot180,'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\Rotate180DCT.jpg');