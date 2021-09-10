function output = preProc(input)
    imgmat = double(input);
    sizee = size(imgmat);
    height = ceil(sizee(1) / 8);
    widthh = ceil(sizee(2) / 8);

    if mod(sizee(2), 8) ~= 0
        imgmat = [imgmat, zeros(sizee(2), widthh * 8 - sizee(1))];
    end

    if mod(sizee(1), 8) ~= 0
        imgmat = [imgmat; zeros(height * 8 - sizee(1), widthh * 8)];
    end
    output=imgmat-128*ones(height*8,widthh*8);
end
