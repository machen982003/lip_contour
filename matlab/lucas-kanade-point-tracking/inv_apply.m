function wpts = inv_apply(pts, p)
    M = inv(p2M(p)); % Get the inverse warp matrix 
    wpts = M(1:2,:)*[pts;ones(1,size(pts,2))]; % Apply the warp function 
end  