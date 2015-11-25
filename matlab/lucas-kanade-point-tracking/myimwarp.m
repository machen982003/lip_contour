function wimg = myimwarp(img, p, dsize)
    % Form the transform matrix 
    % Note it is the inverse since it transforming from the image to the template 
    M = inv(p2M(p)); 
    tform = maketform('affine',M'); % Set the transform
    % Apply the transformation (using bilinear interpolation)
    
    %FIX xdata to data under polygon
    wimg = imtransform(img, tform,'bilinear','xdata',[0,dsize(2)-1],'ydata',[0,dsize(1)-1]);  
end