close all; clear all;
img = imread('mouth.jpg'); 
img= im2double(img);
win = size(img,2);
hin = size(img,1);
w = 200;
h = ceil((w/win)*hin);
img = imresize(img,w/win);
A = [0.299    0.587     0.114;...
    0.595716 -0.274453 -0.321263 ;...
    0.211456 -0.522591 0.31135];
img_flat = reshape(img, 1,w*h,3);
img_flat_2d = squeeze(img_flat(1,:,:))';
yiq_flat_2d = A*(img_flat_2d);
yiq_flat = reshape(yiq_flat_2d(3,:),h,w);
img = uint8(yiq_flat*255);
demo_acwe(img,5);