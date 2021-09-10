function [single_code_AC] = RuleAC(run,seq_val)
    load JpegCoeff.mat
    if seq_val == 0
       size = 0; 
    else
       size = floor(log2(abs(seq_val)))+1; 
    end
    code_end = 3+ACTAB(run*10+size,3);
    single_code_AC = char((ACTAB(run*10+size,4:code_end))+48);
end

