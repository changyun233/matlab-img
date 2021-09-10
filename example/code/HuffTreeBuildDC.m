function [] = HuffTreeBuildDC()
    load JpegCoeff.mat;
    HuffTree = zeros(2^10-1,4);             %dim 1 : left child;  
                                            %dim 2 : right child;   
                                            %dim 3 : leaf flag;  1 for leaf
                                            %dim 4 : category  
    for i = 1 : 1 : 2^10 - 1
        if i < 2^9
            HuffTree(i,1) = 2*i;
            HuffTree(i,2) = 2*i+1;
        else
            HuffTree(i,1) = -1;
            HuffTree(i,2) = -1;
        end
    end
    root_num = 1;  
    for i = 1 : 1 : 12
        code_len = DCTAB(i,1);
        DC_code = DCTAB(i,2:1+code_len);
        current_num = root_num;
        for j = 1 : 1 : code_len
            if DC_code(j) == 0
                current_num = 2*current_num;
            else
                current_num = 2*current_num + 1;
            end
            if j == code_len 
                HuffTree(current_num,3) = 1;
                HuffTree(current_num,4) = i-1;
            end
        end
    end
    save('HuffmanTreeDC.mat','HuffTree');
end

