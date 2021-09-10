function MatC = DCT(MatP)
%   get 2d dct transform
%   MatP is a square matrix
    sizeP = size(MatP);
    if sizeP(1) ~= sizeP(2)
        disp("Error! MatP is not a square matrix!");
        return;
    end
    dim = length(MatP);
    MatD = zeros(dim,dim);
    for i = 1 : 1 : dim
        if i == 1
            MatD(i,:) = sqrt(1/2)*ones(1,dim);
        else
            MatD(i,:) = cos(pi/(2*dim)*(i-1:2*(i-1):(i-1)*(2*dim-1)));
        end
    end
    MatC = 2/dim*MatD*MatP*(MatD.');
end

