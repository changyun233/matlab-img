load ../../res/hall.mat;
addpath ../share;
imgmat=preProc(hall_gray);
    sizee = size(imgmat);
    height = sizee(1) / 8;
    widthh = sizee(2) / 8;
for i=1:widthh
    for j=1:height
        mattoproc=imgmat(j*8-7:j*8,i*8-7:i*8);
        matT(j*8-7:j*8,i*8-7:i*8)=dctT(mattoproc);
        matr90(j*8-7:j*8,i*8-7:i*8)=dctr90(mattoproc);
        matr180(j*8-7:j*8,i*8-7:i*8)=dctr180(mattoproc);
    end
end


matT=matT+128*ones(120,168);
matr90=matr90+128*ones(120,168);
matr180=matr180+128*ones(120,168);
subplot(221),imshow(hall_gray);
subplot(222),imshow(uint8(matT));
subplot(223),imshow(uint8(matr90));
subplot(224),imshow(uint8(matr180));