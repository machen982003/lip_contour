function wpts = apply(pts, p)
    M = p2M(p); % Get the warp matrix 
    11111
    size(pts)
    size(M)
    11111
    wpts = M(1:2,:)*[pts;ones(1,size(pts,2))]; % Apply the warp function 
end