function [image] = BlockReform(blocks,height,width)
%UNTITLED7 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    block_size = size(blocks);
    image = zeros(height*8,width*8);
    for i = 1 : 1 : block_size(3)
        image(8*floor((i-1)/width)+1:8*floor((i-1)/width)+8,8*mod((i-1),width)+1:8*mod((i-1),width)+8) = blocks(:,:,i);
    end
end

