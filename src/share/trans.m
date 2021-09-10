function output = trans(input)
    if input == 0
        N = 1;
    else
        N = floor(log2(abs(input)))+1;
    end
    if input >= 0
        output = dec2bin(input,N);
    else
        output = dec2bin(2^N-1+input,N);
    end
end

