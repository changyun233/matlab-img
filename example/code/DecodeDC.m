function [dct_DC_seq] = DecodeDC(seq_DC)
    load HuffmanTreeDC.mat;
    dct_DC_seq = [];
    i = 1;
    cursor = 1;
    while i <= length(seq_DC)
        if seq_DC(i) == 0
            cursor = 2*cursor;
            if HuffTree(cursor,3) == 1
               if HuffTree(cursor,4) == 0
                   dct_DC_seq = [dct_DC_seq,0];
                   i = i + 2;
                   cursor = 1;
                   continue;
               else
                   len = HuffTree(cursor,4);
                   dct_DC_seq = [dct_DC_seq,Complement2Dec(seq_DC(i+1:i+len))];
                   i =  i + len + 1;
                   cursor = 1;
                   continue;
               end
            else
                i = i + 1;
                continue;
            end
        else
            cursor = 2*cursor+1;
            if HuffTree(cursor,3) == 1
               if HuffTree(cursor,4) == 0
                   dct_DC_seq = [dct_DC_seq,0];
                   i = i + 2;
                   cursor = 1;
                   continue;
               else
                   len = HuffTree(cursor,4);
                   dct_DC_seq = [dct_DC_seq,Complement2Dec(seq_DC(i+1:i+len))];
                   i =  i + len + 1;
                   cursor = 1;
                   continue;
               end
            else
                i = i + 1;
                continue;
            end
        end
    end
    for i = 2 : 1 : length(dct_DC_seq)
        dct_DC_seq(i) = dct_DC_seq(i-1)-dct_DC_seq(i);
    end
end


