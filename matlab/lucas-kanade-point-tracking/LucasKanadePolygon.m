function [ p ] = LucasKanadePolygon( T_0, img, mask, pinit)
%TESTWITHDYNAMICTEMPLATE Summary of this function goes here
%   Detailed explanation goes here
% author : Enxhell Luzhnica

dsize = [size(T_0,1), size(T_0,2)];
P = 6;
p = pinit;

T_0 = imfilter(T_0, fspecial('gaussian',[5,5], 3) ,'replicate'); % Blur the template before hand
%T_0 = T_0 .* mask;

Tx_0 = imfilter(T_0, [-1 1],'replicate'); % Get the x-gradient
Ty_0 = imfilter(T_0,[-1,1]','replicate'); % Get the y-gradient

[x,y] = meshgrid(0:size(T_0,2)-1,0:size(T_0,1)-1);
x = x(:); y = y(:); % Store the vectorized coordinates
% Form the Jacobian with the current estimate of p
[dWx,dWy] = dWx_dp(x, y); % Estimate the derivative of the warp w.r.t p

% Apply the gradients with the derivative of the warp (i.e chain rule style as covered in class)
J = dWx.*repmat(Tx_0(:),[1,P]) + dWy.*repmat(Ty_0(:),[1,P]);

% Pre-compute the update matrix
R = inv(J'*J)*J'; 

num_iter = 30;
for n = 1:num_iter

    I_p = myimwarp(img, p, dsize); % Warp the image
    imshow(I_p)
    pause(0.1);

    %I_p_temp = I_p .* mask;
    %imshow(I_p_temp);
    
    %pause(0.1);
    %T_0_temp = T_0 .* mask;
    % Get the error and display the result
    diff = I_p(:) - T_0(:); 
    norm(diff)
    % Apply the update
    dp = R*(diff);

    M = p2M(p);
    M_1 = p2M(dp);
    M_i = M/M_1;
    p = M2p(M_i);
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



