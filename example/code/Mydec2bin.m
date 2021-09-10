function [bin_out] = Mydec2bin(dec_in)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    if dec_in == 0
        bin_out = '0';
    else
        temp = double(abs(dec_in));
        N = floor(log2(temp))+2;
        if dec_in > 0
            bin_out = dec2bin(dec_in,N);
        else
            bin_out = dec2bin(2^N + dec_in,N);
        end
    end
end

