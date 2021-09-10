clear all, close all, clc;
prim_pic = imread('new.jpg');
L = 5;
[std_vector,temp] = FaceTraining(L);
[recog_pic,cnt] = FaceRecognition(prim_pic,std_vector,L);
imshow(recog_pic);
%imwrite(recog_pic,'C:\\Users\\HJSF\\Desktop\\Dynamic\\matlab\\PP_chapter_4\\L5.jpg');