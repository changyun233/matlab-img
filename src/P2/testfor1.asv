load ../../res/hall.mat;

image_test = double(hall_gray(1:8, 1:8));

dct1Proc= mydct2(image_test);
dct2Proc = dct1Proc - mydct2(128 * ones(8, 8));
dctgrayimg = myidct2(dct2Proc);
