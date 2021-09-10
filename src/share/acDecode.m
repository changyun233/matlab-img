function [dct_AC_seq] = DecodeAC(seq_AC)
    load ./HuffmanTreeAC.mat;
    dct_AC_seq = [];
    i = 1;
    cursor = 1;
    cnt = 0;

    while i <= length(seq_AC)

        if seq_AC(i) == 0
            cursor = 2 * cursor;

            if HuffTree(cursor, 3) == 1
                size = HuffTree(cursor, 5);
                run = HuffTree(cursor, 4);

                if size > 0
                    amplitude = Complement2Dec(seq_AC(i + 1:i + size));
                    dct_AC_seq = [dct_AC_seq, zeros(1, run), amplitude];
                    i = i + 1 + size;
                    cnt = cnt + run + 1;
                    cursor = 1;
                elseif (size == 0) && (run == 15)
                    dct_AC_seq = [dct_AC_seq, zeros(1, 16)];
                    i = i + 1;
                    cnt = cnt + 16;
                    cursor = 1;
                else
                    dct_AC_seq = [dct_AC_seq, zeros(1, 63 - cnt)];
                    i = i + 1;
                    cnt = 0;
                    cursor = 1;
                    continue;
                end

                if cnt == 63
                    cnt = 0;
                end

            else
                i = i + 1;
                continue;
            end

        else
            cursor = 2 * cursor + 1;

            if HuffTree(cursor, 3) == 1
                size = HuffTree(cursor, 5);
                run = HuffTree(cursor, 4);

                if size > 0
                    amplitude = Complement2Dec(seq_AC(i + 1:i + size));
                    dct_AC_seq = [dct_AC_seq, zeros(1, run), amplitude];
                    i = i + 1 + size;
                    cnt = cnt + run + 1;
                    cursor = 1;
                elseif (size == 0) && (run == 15)
                    dct_AC_seq = [dct_AC_seq, zeros(1, 16)];
                    i = i + 1;
                    cnt = cnt + 16;
                    cursor = 1;
                else
                    dct_AC_seq = [dct_AC_seq, zeros(1, 63 - cnt)];
                    i = i + 1;
                    cnt = 0;
                    cursor = 1;
                    continue;
                end

                if cnt == 63
                    cnt = 0;
                end

            else
                i = i + 1;
                continue;
            end

        end

    end

end
