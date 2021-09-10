function [image_decode] = ImageDecode(code_AC,code_DC,height,width)
    code_AC = str2num(code_AC(:))';
    code_DC = str2num(code_DC(:))';
    [dct_AC_seq] = DecodeAC(code_AC);
    [dct_DC_seq] = DecodeDC(code_DC);
    block_num = height*width;
    dct_AC_mat = zeros(8,8,block_num);
    for i = 1 : 1 : block_num
        dct_AC_mat(:,:,i) = InverseZiZag(dct_AC_seq(63*(i-1)+1:63*i));
    end
    [dct_mat] = DctMatReform(dct_AC_mat,dct_DC_seq);
    [image_decode] = ImageReform(dct_mat,height,width);
    image_decode = uint8(image_decode);
end

