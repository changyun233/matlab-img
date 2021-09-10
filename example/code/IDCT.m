function MatP = IDCT(MatC)
    sizeC = size(MatC);
    if sizeC(1) ~= sizeC(2)
        disp("Error! MatC is not a square matrix!");
        return;
    end
    dim = length(MatC);
    MatD = zeros(dim,dim);
    for i = 1 : 1 : dim
        if i == 1
            MatD(i,:) = sqrt(1/2)*ones(1,dim);
        else
            MatD(i,:) = cos(pi/(2*dim)*(i-1:2*(i-1):(i-1)*(2*dim-1)));
        end
    end
    MatP = 2/dim*(MatD.')*MatC*MatD;
end

