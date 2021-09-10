function [chara_vector] = SingleFaceTranning(face,L)
% face training
    %L = 3;
    %L = 4;
    %L = 5;
    face_size = size(face);
    u_R = zeros(1,2^(3*L));
    face = double(face);
    for i = 1 : 1 : face_size(1)
        for j = 1 : 1 : face_size(2)
            Rxy = floor(face(i,j,1)/(2^(8-L)));
            Gxy = floor(face(i,j,2)/(2^(8-L)));
            Bxy = floor(face(i,j,3)/(2^(8-L)));
            n = 2^(2*L)*Rxy+(2^L)*Gxy+Bxy+1;
            u_R(n) = u_R(n) + 1;
        end
    end
    chara_vector = 1/(face_size(1)*face_size(2))*u_R;
end

