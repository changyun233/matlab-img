function [dct_mat] = DctMatReform(dct_AC_mat,dct_DC_seq)
    mat_num = length(dct_DC_seq);
    dct_mat = zeros(8,8,mat_num);
    dct_mat = dct_AC_mat;
    for i = 1 : 1 :  mat_num
        dct_mat(1,1,i) = dct_DC_seq(i);
    end
end

