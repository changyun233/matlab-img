clear all, close all, clc;
addpath ../share;
load ../../res/JpegCoeff.mat
load ../../res/hall.mat
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
lengthh=length(matQuant(1,:))
seq_DC = zeros(1,lengthh);
seq_AC = zeros(lengthh,63);
code_AC = [];
for i = 1 : 1 : lengthh
    if i == 1
        seq_DC(i) = matQuant(1,i);
    else
        seq_DC(i) = matQuant(1,i-1)-matQuant(1,i);
    end
    seq_AC(i,:) = (matQuant(2:64,i)).';
end
code_DC = dcCoder(seq_DC);
for i = 1 : 1 : lengthh
    code_AC = [code_AC,acCoder(seq_AC(i,:))];
end
code_AC = logical(str2num(code_AC(:))');
code_DC = logical(str2num(code_DC(:))');
save('jpegcodes.mat');
