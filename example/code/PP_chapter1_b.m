clear all;
load hall.mat
hall_color = double(hall_color);
flag = hall_color;
dim = size(hall_color);
len = 8;
for i = 1 : 1 : dim(1)
    for j = 1 : 1 : dim(2)
        hall_color(i,j,1) = hall_color(i,j,1)*mod(floor(i/len)+floor(j/len),2);
        hall_color(i,j,2) = hall_color(i,j,2)*mod(floor(i/len)+floor(j/len),2);
        hall_color(i,j,3) = hall_color(i,j,3)*mod(floor(i/len)+floor(j/len),2);
    end
end
imshow(uint8(hall_color));
%imwrite(uint8(hall_color),'C:\\Users\\HJSF\\Desktop\\Dynamic\\hall_chessmap.jpg');