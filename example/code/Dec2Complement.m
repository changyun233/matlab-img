function [complement] = Dec2Complement(dec_in)
    if dec_in == 0
        N = 1;
    else
        N = floor(log2(abs(dec_in)))+1;
    end
    if dec_in >= 0
        complement = dec2bin(dec_in,N);
    else
        complement = dec2bin(2^N-1+dec_in,N);
    end
end

