# lip_contour

Title: 

Lip Countour Detection and Tracking

Team Members: 

Chen Ma, Enxhell Luzhnica, Aditya Sharma

Summary: 

The aim of this project is to implement an algorithm for real-time lip contour detection and tracking and develop an iOS app that can use the contour for one, or if time permits, both of the following applications:

1. Lip Reading: Use machine learning on the contour data to classify 10 words/phrases/sentences.
2. Virtual Lipstick Tester: Use the contour to apply lipstick of the selected color to the users face using the front camera as a mirror.

Background: 

We plan to use the jumping snake algorithm to find the lip contour. We will use OpenCV first to locate the position of the face and mouth, then use the algorithm to find the contour, and finally, use correlation filters to track these key points. 

We will use the correlation filters to track the corner points of the lips, since it is really fast.
We might also use the high speed camera, which allow less movement between frames, such that we can get better tracking results, especially when it comes to deformable objects.

The Challenge: 

1. The jumping snake algorithm is an iterative optimization algorithm, we might need revise it to make it run in a parallel manner on a GPU. Hopefully, the OpenGL library we learned in class can help us out here.
2. Lips are deformable objects, which might pose to be a problem while tracking them. We will have to deal with this very carefully while using the corner detection algorithm.

Goals & Deliverables:

PLAN TO ACHIEVE (In that order):

1. Successfully perform lip contour detection on a static image.
2. Extend the detections above to real-time incoming video stream to enable tracking of the contours.

HOPE TO ACHIEVE (Any one and in best case scenario, both):

3. Create a virtual lipstick tester app.
4. Create a lip reading app.

Evaluation of success:

In the scenarios described above, the project will be considered a success if, and would be demonstrated as:
1. Take an image using the iPad camera and perform lip contour detection on it. This can be shown as videos or screenshots.

2. Take a live video stream, detect and track the lip contour. This can be shown as a video.

3. Take a live video stream, let the user select a color, and display virtual lipstick of that color on the user's lips in the stream. This can be shown as a video or a live demonstration.

4. Let the user speak one of ten pre-decided words, and have the app guess the user's spoken word by reading his/her lips. This can be shown as a video or a live demonstration.


Schedule:
11.8 - 11.14 : apply mouth detection, jump snake algorithm to find the interest points

11.14 - 11.21 : contour detection

11.21 - 11.28 : real-time tracking

11.28 - 12.05 : Virtual Lipstick tester app / Lip reading app

12.05 - 12.10 : final testing, documentation, presentations etc.

