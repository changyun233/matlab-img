clear all, close all, clc;
load hall.mat
image_test = zeros(8,8);
for i = 1 : 1 : 8
    for j = 1 : 1 : 8
        image_test(i,j) = hall_gray(i,j);
    end
end
MatC = DCT(image_test);
AC = MatC - DCT(128*ones(8,8));
pre_image = IDCT(AC);
dif = image_test - pre_image - 128;