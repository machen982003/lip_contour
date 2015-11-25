function [ p ] = LuKa( tmplt, img, pinit)
%TESTWITHDYNAMICTEMPLATE Summary of this function goes here
%   Detailed explanation goes here
% author : Enxhell Luzhnica (code modified from Simon Lucey) 

P = 6;
p = pinit;

if isinteger(tmplt)
    tmplt = im2double(tmplt); 
end

T_0 = tmplt; 
dsize = size(tmplt); 

% Set the pixel coordinates within the template 
[x,y] = meshgrid(0:size(tmplt,2)-1,0:size(tmplt,1)-1);
x = x(:); y = y(:);

bimg = imfilter(img, fspecial('gaussian',[5,5], 3)); % Blur image before hand
Ix = imfilter(bimg, [-1,1]); % Get the x-gradient
Iy = imfilter(bimg, [-1;1]); % Get the y-gradient

num_iter=30;
% Now apply number of iterations
for n = 1:num_iter               
    % Visualize the result if h is not empty

    % Step 1. warp the images and the gradients 
    I_p = myimwarp(bimg, p, dsize); % Warp the image
    %imshow(I_p);
    %pause(0.01);
    Ix_p = myimwarp(Ix, p, dsize); % Warp the x-gradient
    Iy_p = myimwarp(Iy, p, dsize); % Warp the y-gradient

    % Get the error and display the result
    diff = I_p(:) - T_0(:); 

    % Step 2. Form the Jacobian with the current estimate of p
    [dWx,dWy] = dWx_dp(x, y, p); % Estimate the derivative of the warp w.r.t p

    % Step 3.  the image gradients with the derivative (i.e chain
    % rule style as covered in class)
    J = dWx.*repmat(Ix_p(:),[1,P]) + dWy.*repmat(Iy_p(:),[1,P]);

    % Step 4. now solve the linear system
    dp = J\(T_0(:) - I_p(:)); 

    % Step 5. update
    p = p + dp;                 
end

end

function p = M2p(M)
    p(1) = 1 - M(1,1); 
    p(2) = M(1,2); 
    p(3) = M(1,3); 
    p(4) = M(2,1); 
    p(5) = 1 - M(2,2); 
    p(6) = M(2,3);
    p = p(:); 
end



