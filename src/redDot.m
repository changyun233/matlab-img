function output = redDot(input)
    load . ./ res / hall.mat
    inputProc = double(input);
    r = min(size(input(:, :, 1))) / 2;
    sizee = size(inputProc);

    for i = 1:1:sizee(1)

        for j = 1:1:sizee(2)

            if (i - sizee(1) / 2)^2 + (j - sizee(2) / 2)^2 < r^2
                inputProc(i, j, :) = [255 0 0];
            end

        end

    end

    output = uint8(inputProc);
end
