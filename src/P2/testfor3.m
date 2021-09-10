load ../../res/hall.mat;
addpath ../share;

imgmat=preProc(hall_gray);
    sizee = size(imgmat);
    height = sizee(1) / 8;
    widthh = sizee(2) / 8;
for i=1:widthh
    for j=1:height
        mattoproc=imgmat(j*8-7:j*8,i*8-7:i*8);
        outmat(j*8-7:j*8,i*8-7:i*8)=dct_40(mattoproc);
    end
end
out1mat=outmat+128*ones(120,168);
subplot(121),imshow(hall_gray);
subplot(122),imshow(uint8(out1mat));