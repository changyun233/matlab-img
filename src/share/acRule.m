function output = RuleAC(run,seqVal)
    load ../../res/JpegCoeff.mat
    if seqVal == 0
       size = 0; 
    else
       size = floor(log2(abs(seqVal)))+1; 
    end
    code_end = 3+ACTAB(run*10+size,3);
    output = char((ACTAB(run*10+size,4:code_end))+48);
end

