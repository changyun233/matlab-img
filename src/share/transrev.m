function [dec_out] = transrev(complement)
    len = length(complement);
    if complement(1) == 0
        for i = 1 : 1 : len
            complement(i) = 1 - complement(i);
        end
        complement = char(complement+48);
        dec_out = -bin2dec(complement);
    else
        complement = char(complement+48);
        dec_out = bin2dec(complement);
    end
end

