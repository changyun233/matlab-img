function [code_AC] = EncodeAC(seq_AC)
    code_AC = [];              % 1:non_zeros sequence,0:zeros sequence 
    run = 0;
    last_non_zero = 63;
    for i = 63 : -1 : 1
        if seq_AC(i) ~= 0
            last_non_zero = i;
            break;
        end
        if (i == 1)&&(seq_AC(i) == 0)
            last_non_zero = -1;
            break;
        end
    end
    for i = 1 : 1 : last_non_zero
        if seq_AC(i) ~= 0
            code_AC = [code_AC,RuleAC(run,seq_AC(i)),Dec2Complement(seq_AC(i))];
            run = 0;
        else
            run = run + 1;
            if (run == 16)&&(i ~= 63)
                code_AC = [code_AC,'11111111001'];
                run = 0;
            end
        end
    end
    if last_non_zero ~= 63
        code_AC = [code_AC,'1010'];
    end
end

