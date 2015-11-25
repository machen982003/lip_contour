function [ u,v ] = LucasKanadeBasis( It, It1, rect, bases, init_guess )
%LUCASKANADEBASIS Summary of this function goes here
%   Detailed explanation goes here

if (~exist('init_guess', 'var') || isempty(init_guess))
    init_guess = [0;0];
end

deltaP = init_guess;
u = 0;
v = 0;
lambda = zeros(1, size(bases,3));
epsilon = 0.01;

[Xs, Ys] = meshgrid(rect(1):rect(3), rect(2):rect(4));

template = interp2(It, Xs, Ys);
[dTx, dTy] = gradient(template);
gradT = double([dTx(:), dTy(:)]);

A = zeros(size(bases,1) * size(bases,2), size(bases,3));
gradA = zeros(size(A,1), size(A,2)*2);
for i=1:size(bases,3)
   temp = bases(:,:,i);
   A(:,i) = temp(:);
   [dxb,dyb] = gradient(temp);
   gradA(:,2*i-1) = double(dxb(:));
   gradA(:,2*i) = double(dyb(:));
end

count = 0;
while count < 50 || norm(deltaP) > epsilon
    x = (rect(1)+u) : (rect(3)+u);
    y = (rect(2)+v) : (rect(4)+v);
    [X, Y] = meshgrid(x, y);
    warpimg = interp2(It1, X, Y);

    sumA = 0;
    for i = 1:size(bases,3)
        sumA = sumA + lambda(i) * A(:,i);
    end
    sumA = reshape(sumA, size(template));
    error = template + sumA - warpimg;
    error = error(:);
    
    grad = 0;
    for i = 1:size(bases,3)
        tempA = [gradA(:,2*i-1), gradA(:,2*i)];
        grad = grad + lambda(i)*tempA;
    end
    grad = grad + gradT;
    
    SD = [grad A];

    H = SD'*SD;
    
    s7 = SD'*error;
    deltaq = -H\s7;

    deltaP = deltaq(1:2);

    u = u - deltaP(1);
    v = v - deltaP(2);

    lambda = lambda + deltaq(3:end)';
    count = count + 1;
end
end

