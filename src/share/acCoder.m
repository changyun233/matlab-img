function [output] = acCoder(input)
    output = [];              % 1:non_zeros sequence,0:zeros sequence 
    run = 0;
    last_non_zero = 63;
    for i = 63 : -1 : 1
        if input(i) ~= 0
            last_non_zero = i;
            break;
        end
        if (i == 1)&&(input(i) == 0)
            last_non_zero = -1;
            break;
        end
    end
    for i = 1 : 1 : last_non_zero
        if input(i) ~= 0
            output = [output,acRule(run,input(i)),trans(input(i))];
            run = 0;
        else
            run = run + 1;
            if (run == 16)&&(i ~= 63)
                output = [output,'11111111001'];
                run = 0;
            end
        end
    end
    if last_non_zero ~= 63
        output = [output,'1010'];
    end
end

