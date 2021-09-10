function [recog_pic,cnt] = FaceRecognition(prim_pic,std_vector,L)
    [proc_pic,blocks,block_num,height,width] = GraphicsDivideRGB(prim_pic);
    cnt = 0;
    detec_gray = zeros(height,width);
    for i = 1 : 1 : block_num
        temp = blocks(:,:,:,i);
        [face_flag] = IsFace(temp,std_vector,L);
        if face_flag == 1
            detec_gray(floor((i-1)/width)+1,mod(i-1,width)+1) = 255;
        end
    end
    detec_gray = medfilt2(detec_gray,[8,8]);
    recog_pic = RedBoundary(detec_gray,proc_pic); 
    recog_pic = uint8(recog_pic);
end


