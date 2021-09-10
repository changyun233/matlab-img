function [face_flag] = face(face_block,std_vector)
    threshold = 0.69;
    %threshold = 0.82;
    %threshold = 0.905;
    my_vector = SingleFaceTranning(face_block);
    distance = 1 - sqrt(my_vector)*(sqrt((std_vector).'));
    if distance <= threshold
    face_flag = 1;
    else
    face_flag = 0;
    end
   end