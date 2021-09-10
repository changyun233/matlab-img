function [face_flag] = IsFace(face_block,std_vector,L)
    %threshold = 0.69;
    threshold = [0.69,0.82,0.905];
    %threshold = 0.905;
    my_vector = SingleFaceTranning(face_block,L);
    distance = 1 - sqrt(my_vector)*(sqrt((std_vector).'));
    if distance <= threshold(L-2)
        face_flag = 1;
    else
        face_flag = 0;
    end
end

