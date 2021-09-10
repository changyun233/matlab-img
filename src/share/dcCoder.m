function output = coderDC(input)
    len_DC = length(input);
    for i = 1 : 1 : len_DC
        errorr = input(i);
        category = ceil(log2(abs(errorr)+1));
        if category == 0
            huffman = '00';
        elseif category == 1
            huffman = '010';
        elseif category == 2
            huffman = '011';
        elseif category == 3
            huffman = '100';
        elseif category == 4
            huffman = '101';
        elseif category == 5
            huffman = '110';
        elseif category == 6
            huffman = '1110';
        elseif category == 7
            huffman = '11110';
        elseif category == 8
            huffman = '111110';
        elseif category == 9
            huffman = '1111110';
        elseif category == 10
            huffman = '11111110';
        elseif category == 11
            huffman = '111111110';
        end
        output = [huffman,trans(errorr)];
    end
end

