
function [my_vector,temp] = FaceTraining()
    L = 3;
    %L = 4;
    %L = 5;
    my_vector = zeros(1,2^(3*L));
    temp = zeros(33,2^(3*L));
    for i = 1 : 1 : 33
    file_name = strcat('../../res/Faces/',int2str(i),'.bmp');
    face = imread(file_name,'bmp');
    my_vector = my_vector + SingleFaceTranning(face);
    temp(i,:) = SingleFaceTranning(face);
    end
    my_vector = my_vector/33;
   end