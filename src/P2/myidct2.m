function output = myidct2(input)
    sizeInput = size(input);
    if sizeInput(1) ~= sizeInput(2)
        return;
    end
    lengthInput = length(input);
    temp = zeros(lengthInput, lengthInput);
    for i = 1:1:lengthInput
        if i == 1
            temp(i, :) = sqrt(1/2) * ones(1, lengthInput);
        else
            temp(i, :) = cos(pi / (2 * lengthInput) * (i - 1:2 * (i - 1):(i - 1) * (2 * lengthInput - 1)));
        end
    end
    output = 2 / lengthInput * (temp.') * input * temp;
end
