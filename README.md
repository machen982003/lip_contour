# lip_contour

Title: 

Lipstick Professor 

Team Member: 

Chen Ma, Enxhell Luzhnica

Summary: 

In this project, we plan to develop an app which can tracking human face and segment the lip real time. We plan apply the jumping snake algorithm to find the key point and the contour of lip. We plan to use OpenCV first to locate the position of face and mouth, then use algorithm to find contour, finally, use correlation filters to track these key points.

Background: 

We will use the correlation filters to tracking the corner points of lip, since it is really fast.
We might also use the high speed camera, which allow less movement between frames, such that we can get better tracking result, especially when it comes to the deformable object.

The Challenge: 

1. The jumping snake algorithm is a iterate optimization algorithm, might need revise it to take use of GPU parralle calculation.
2. The lip is deformable, so 

Goals & Deliverables:

Plan to achieve:  find human lip contour and add color on the lip, make it seems like make up lip stick, on a static image.
Hope to achieve: Make above goal into realtime on IOS.

Evaluate: 

If we can find the lip contour on a photo, and apply the lip stick on it, then this project is success, we will provide a screen shot of the face apply different lipsticks.
Further, if we can do it in real time, we will provide a video with moving human face, with different color lipsticks.

Schedual:
11.8 - 11.14 : apply the mouth detection, jump snake algorithm to find the middle key points on upper lip and lower lip.
11.14 - 11.21 : apply the algorithm to find the left and right conner points, and fit the contour
11.21 - 11.28 : add the color to lip according to the light condition, add control bar to adjust color
11.28 - 12.05 : write the code to tracking the key points, and calculate the new contour realtime
12.05 - 12.10 : test and prepare the final presentation

