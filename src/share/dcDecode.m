function [output] = DecodeDC(input)
    load ./HuffmanTreeDC.mat;
    output = [];
    i = 1;
    cursor = 1;

    while i <= length(input)

        if input(i) == 0
            cursor = 2 * cursor;

            if HuffTree(cursor, 3) == 1

                if HuffTree(cursor, 4) == 0
                    output = [output, 0];
                    i = i + 2;
                    cursor = 1;
                    continue;
                else
                    len = HuffTree(cursor, 4);
                    dct_DC_seq =
                    [output, Complement2Dec(input(i + 1:i + len))];
                    i = i + len + 1;
                    cursor = 1;
                    continue;
                end

            else
                i = i + 1;
                continue;
            end

        else
            cursor = 2 * cursor + 1;

            if HuffTree(cursor, 3) == 1

                if HuffTree(cursor, 4) == 0
                    output = [output, 0];
                    i = i + 2;
                    cursor = 1;
                    continue;
                else
                    len = HuffTree(cursor, 4);
                    dct_DC_seq =
                    [output, Complement2Dec(input(i + 1:i + len))];
                    i = i + len + 1;
                    cursor = 1;
                    continue;
                end

            else
                i = i + 1;
                continue;
            end

        end

    end

    for i = 2:1:length(output)
        output(i) = output(i - 1) - output(i);
    end

end
