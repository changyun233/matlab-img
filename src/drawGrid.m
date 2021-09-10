load ../res/hall.mat
hall_color = double(hall_color);
sizee = size(hall_color);
gridLength = 18;

for i = 1:1:sizee(1)

    for j = 1:1:sizee(2)
        hall_color(i, j, 1) = hall_color(i, j, 1) * mod(floor(i / gridLength) + floor(j / gridLength), 2);
        hall_color(i, j, 2) = hall_color(i, j, 2) * mod(floor(i / gridLength) + floor(j / gridLength), 2);
        hall_color(i, j, 3) = hall_color(i, j, 3) * mod(floor(i / gridLength) + floor(j / gridLength), 2);
    end

end
hall_color=uint8(hall_color);
imshow(hall_color);

