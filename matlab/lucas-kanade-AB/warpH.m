function warp_im = warpH(im, H, out_size,fill_value)
if ~exist('fill_value', 'var') || isempty(fill_value)
    fill_value = 0;
end

tform = maketform( 'affine', H'); 
warp_im = imtransform( im, tform, 'bilinear', 'XData', [1 out_size(2)], 'YData', [1 out_size(1)], 'Size', out_size(1:2), 'FillValues', fill_value*ones(size(im,3),1));

end
