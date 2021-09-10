function [proc_graph,blocks,block_num,height,width] = GraphicsDivide(prim_graph)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    prim_graph = double(prim_graph);
    prim_size = size(prim_graph);
    height = ceil(prim_size(1)/8);
    width = ceil(prim_size(2)/8);
    block_num = height*width;
    proc_graph = zeros(height*8,width*8);
    proc_graph(1:prim_size(1),1:prim_size(2)) = prim_graph;
    blocks = zeros(8,8,block_num);
    for i = 1 : 1 : 8*height
        if i <= prim_size(1)
            %proc_graph(i,1:prim_size(2)) = prim_graph(i,:);
            proc_graph(i,prim_size(2)+1:8*width) = prim_graph(i,prim_size(2))*ones(1,8*width-prim_size(2));
        else
            proc_graph(i,:) = proc_graph(prim_size(1),:);
        end           
    end
    %proc_graph = uint8(proc_graph);
    for i = 1 :  block_num
        blocks(:,:,i) =  proc_graph(8*floor((i-1)/width)+1:8*floor((i-1)/width)+8,8*mod((i-1),width)+1:8*mod((i-1),width)+8);
    end
end

