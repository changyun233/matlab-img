clear all, close all, clc;
load ../../res/JpegCoeff.mat
load ../../res/hall.mat;
addpath ../share;
imgmat=preProc(hall_gray);
    sizee = size(imgmat);
    height = sizee(1) / 8;
    widthh = sizee(2) / 8;
    matDct=[];
    matQuant=[];
for i=1:widthh
    for j=1:height
        mattoproc=imgmat(j*8-7:j*8,i*8-7:i*8);
        newDct=mydct2(mattoproc)
        matDct=cat(3,matDct,newDct);
        newQuant=[newDct(1,1),(zigzag(newDct))];
        matQuant=[matQuant;newQuant];
    end
end

matQuant = int16(matQuant');