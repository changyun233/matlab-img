function [] = HuffTreeBuildAC()
    load ../../res/JpegCoeff.mat;
    HuffTree = zeros(2^17-1,5);             %dim 1 : left child;  
                                            %dim 2 : right child;   
                                            %dim 3 : leaf flag;  1 for leaf
                                            %dim 4 : run 
                                            %dim 5 : size   
    for i = 1 : 1 : 2^17 - 1
        if i < 2^16
            HuffTree(i,1) = 2*i;
            HuffTree(i,2) = 2*i+1;
        else
            HuffTree(i,1) = -1;
            HuffTree(i,2) = -1;
        end
    end
    root_num = 1;  
    for i = 1 : 1 : length(ACTAB)
        code_len = ACTAB(i,3);
        AC_code = ACTAB(i,4:3+code_len);
        current_num = root_num;
        for j = 1 : 1 : code_len
            if AC_code(j) == 0
                current_num = 2*current_num;
            else
                current_num = 2*current_num + 1;
            end
            if j == code_len 
                HuffTree(current_num,3) = 1;
                HuffTree(current_num,4) = ACTAB(i,1);
                HuffTree(current_num,5) = ACTAB(i,2);
            end
        end
    end
    HuffTree(26,3:5) = [1,0,0];
    HuffTree(4089,3:5) = [1,15,0];
    save('HuffmanTreeAC.mat','HuffTree');
end

