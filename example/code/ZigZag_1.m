function [seq_AC] = ZigZag_1(mat_AC)
    temp_AC = rot90(mat_AC);
    AC_size = size(temp_AC);
    seq_AC = [];
    for i = -AC_size(1)+2 : 1 : AC_size(2)-1
        temp = diag(temp_AC,i);
        if mod(abs(i),2) == 0
            seq_AC = [seq_AC;temp];
        else
            seq_AC = [seq_AC;flipud(temp)];
        end
    end
    seq_AC = seq_AC.';
end

