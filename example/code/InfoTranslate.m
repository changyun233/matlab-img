function [info_out] = InfoTranslate(image_hide_decode,info_size)
    info_out = [];
    for i = 1 : 1 : info_size(1)
        info_out = [info_out,char(bin2dec(char(mod(image_hide_decode(i,1:info_size(2)),2)+48)))];
    end
end

