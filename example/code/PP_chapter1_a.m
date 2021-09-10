
load ../../res/hall.mat
hall_color = double(hall_color);
r = min(size(hall_gray))/2;
dim = size(hall_color);
for i = 1 : 1 : dim(1)
    for j = 1 : 1 : dim(2)
        if (i-dim(1)/2)^2 + (j-dim(2)/2)^2 < r^2
            hall_color(i,j,:) = 255,0,0;
        else
        end
    end
end
hall_color=uint8(hall_color);
imshow(hall_color);
