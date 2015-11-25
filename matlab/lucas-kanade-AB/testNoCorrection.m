vid = VideoReader('enxhi.mov');
frame = readFrame(vid);

imshow(frame);
[x,y] = ginput(2);

rect = [x(1) y(1) x(2) y(2)];
width = abs(rect(1) - rect(3));
height = abs(rect(2) - rect(4));

base_rect = rect;
base_template = rgb2gray(im2double(frame));

while(hasFrame(vid))
    img = rgb2gray(im2double(frame));
    imshow(img);
    hold on;
    rectangle('Position',[rect(1), rect(2), width, height], 'LineWidth',2, 'EdgeColor', 'g');
    hold off;

    pause(0.0001);
    
    It = img;
    frame1 = readFrame(vid);
    It1 = rgb2gray(im2double(frame1));
    
    [u,v] = LucasKanade(It, It1, rect);
    rect = [rect(1)+u, rect(2)+v, rect(3)+u, rect(4)+v];
    rect = round(rect);
    
    frame = frame;
end

