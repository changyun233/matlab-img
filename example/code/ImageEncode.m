function [code_AC,code_DC] = ImageEncode(image)
    image = double(image);
    load JpegCoeff.mat;
    [proc_graph,blocks,block_num,height,width] = GraphicsDivide(image-128);
    quanti_mat_DCT = zeros(8,8,block_num);
    quanti_mat = zeros(64,block_num);
    for i = 1 : 1 : block_num
        quanti_mat_DCT(:,:,i) = round(DCT(blocks(:,:,i))./QTAB);
        quanti_mat(:,i) = [quanti_mat_DCT(1,1,i);(ZigZag(quanti_mat_DCT(:,:,i))).'];
    end
    quanti_mat = int16(quanti_mat);
    seq_DC = zeros(1,block_num);
    seq_AC = zeros(block_num,63);
    code_AC = [];
    for i = 1 : 1 : block_num
        if i == 1
            seq_DC(i) = quanti_mat(1,i);
        else
            seq_DC(i) = quanti_mat(1,i-1)-quanti_mat(1,i);
        end
        seq_AC(i,:) = (quanti_mat(2:64,i)).';
    end
    code_DC = EncodeDC(seq_DC);
    for i = 1 : 1 : block_num
        code_AC = [code_AC,EncodeAC(seq_AC(i,:))];
    end
end

