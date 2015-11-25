function points = warpPoints(x,y, p)
    M = p2M(p);
    pts = [x,y, ones(numel(y),1)];
    size(M)
    size(pts)
    points = [];
    for i=1:size(pts,1)
       np = M*pts(i,:)';
       np(1) = np(1) / np(3);
       np(2) = np(2) / np(3);
       points = [points, np(1:2)];
    end
end
