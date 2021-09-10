function [dec_out] = Mybin2dec(bin_in)
    if bin_in(1) == '1'
        N = length(bin_in);
        dec_out = bin2dec(bin_in)-2^N;
    else
        dec_out = bin2dec(bin_in);
    end
end

