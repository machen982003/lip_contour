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
Img = reshape(yiq_flat_2d(3,:),h,w);

iterNum = 5;
Img = medfilt2(Img, [5, 5]);
%setting the initial level set function 'u':
truncated_len = 50;
c0=2;
u = ones(size(Img, 1), size(Img, 2))*c0;
u([truncated_len:end-truncated_len], [truncated_len:end-truncated_len])=-c0; 
%setting the parameters in ACWE algorithm:
mu=1;
lambda1=1; lambda2=1;
timestep = .1; v=10; epsilon=1;
%show the initial 0-level-set contour:
figure;imshow(Img, []);hold on;axis off,axis equal
title('Initial contour');
[c,h] = contour(u,[0 0],'r');
pause(0.1);
% start level set evolution
for n=1:iterNum
    u=acwe(u, Img,  timestep,...
             mu, v, lambda1, lambda2, 1, epsilon, 5);
    if mod(n,10)==0
        pause(0.1);
        imshow(Img, []);hold on;axis off,axis equal
        [c,h] = contour(u,[0 0],'r');
        iterNum=[num2str(n), ' iterations'];
        title(iterNum);
        hold off;
    end
end
imshow(Img, []);hold on;axis off,axis equal
[c,h] = contour(u,[0 0],'r');
totalIterNum=[num2str(n), ' iterations'];
title(['Final contour, ', totalIterNum]);

figure;
imagesc(u);axis off,axis equal;
title('Final level set function');