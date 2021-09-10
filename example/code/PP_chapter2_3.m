load hall.mat
hall_gray = double(hall_gray);
[proc_graph,blocks,block_num,height,width] = GraphicsDivide(hall_gray-128);
l_blocks = zeros(8,8,block_num);
r_blocks = zeros(8,8,block_num);
for i = 1 : 1 : block_num
    l_blocks(:,:,i) = DCT(blocks(:,:,i)).*[zeros(8,4),ones(8,4)];
    l_blocks(:,:,i) = IDCT(l_blocks(:,:,i));
    r_blocks(:,:,i) = DCT(blocks(:,:,i)).*[ones(8,4),zeros(8,4)];
    r_blocks(:,:,i) = IDCT(r_blocks(:,:,i));
end
image_rz = BlockReform(r_blocks,height,width);
image_rz = uint8(image_rz+128);
image_lz = BlockReform(l_blocks,height,width);
image_lz = uint8(image_lz+128);
figure;
imshow(image_rz);
figure;
imshow(image_lz);
%imwrite(image_rz,'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\RightZeroDCT.jpg');
%imwrite(image_lz,'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_2\\LeftZeroDCT.jpg');
