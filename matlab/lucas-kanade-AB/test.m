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
    size(It)
    size(It1)
    
    [u,v] = LucasKanade(It, It1, rect);
    rect1 = [rect(1)+u, rect(2)+v, rect(3)+u, rect(4)+v];
    rect1 = round(rect1);
    [u1,v1] = LucasKanade(base_template, It1, base_rect, ...
                        [rect(1) - base_rect(1) + u; rect(2) - base_rect(2) + v]);
                    
    rect2 = [base_rect(1)+u1, base_rect(2)+v1, base_rect(3)+u1, base_rect(4)+v1];
    rect2 = round(rect2);
    
    c = norm(rect2 - rect1);
    if(c<4)
       rect = rect2;
    end
    
    frame = frame1;
end

