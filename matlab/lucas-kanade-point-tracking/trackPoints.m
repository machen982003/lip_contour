%TRACKPOINTS Summary of this function goes here
%   Detailed explanation goes here

v = VideoReader('enxhi.mov');
frame = readFrame(v);

imshow(frame);
%[x,y] = ginput(8);

load('budha.mat');

pointTracker = vision.PointTracker;
initialize(pointTracker, [x,y], frame);

while(hasFrame(v))
   frame = readFrame(v);
   a = Affine; % Define an Affine object
   gnd_p = a.fit(tmplt_pts, pts); % Get the ground-truth warp
   [points,~] = step(pointTracker, frame);
   imshow(frame);
   hold on;
   plot(points(:,1), points(:,2),'r.','MarkerSize',10);
   hold off;
   pause(0.000001);
end