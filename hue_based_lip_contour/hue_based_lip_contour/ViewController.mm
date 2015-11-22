//
//  ViewController.m
//  Intro_iOS_OpenCV
//
//  Created by Simon Lucey on 9/7/15.
//  Copyright (c) 2015 CMU_16432. All rights reserved.
//

#import "ViewController.h"

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import "opencv2/highgui/ios.h"
#endif
const cv::Scalar RED = cv::Scalar(255,0,0);
const cv::Scalar GREEN = cv::Scalar(0,255,0);
const cv::Scalar PINK = cv::Scalar(230,130,255);


// Include iostream and std namespace so we can mix C++ code in here
#include <iostream>
using namespace std;

@interface ViewController () {
    // Setup the view
    UIImageView *imageView_;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image = [UIImage imageNamed:@"lena.png"]; //Load the Image and store it in 'image' variable
    if(image != nil) imageView_.image = image; // Display the image if it is there....
    else cout << "Cannot read in the file" << endl;    // Loading image and frame sizes
    
    
    float image_height = image.size.height;
    float image_width = image.size.width;
    float frame_height = self.view.frame.size.height;
    float frame_width = self.view.frame.size.width;
    float screen_height = self.view.frame.size.height;
    float screen_width = self.view.frame.size.width;
    float x_pos = 0.0;
    float y_pos = 0.0;
    float aspect_ratio = image_height/image_width; // here aspect ratio is defined as the height divided by the width and this definition is maintained throughout the project.
    /*
     // The following piece of code scales the image to occupy the middle portion of the screen keeping the aspect ratio of the origininal image intact.
     if(image_width <= frame_width && image_height <= frame_height) {frame_width = image_width; frame_height = image_height;}
     
     else if (image_height > frame_height) {
     frame_width = frame_height/aspect_ratio;
     if (frame_width > screen_width) {frame_width = screen_width; frame_height = frame_width*aspect_ratio;}
     }
     
     else if (image_width > frame_width) {
     frame_height = frame_width*aspect_ratio;
     if (frame_height > screen_height){frame_height = screen_height; frame_width = frame_height/aspect_ratio;
     }
     }
     
     x_pos = (screen_width - frame_width)/2;
     y_pos = (screen_height - frame_height)/2;
     */
    
    // Setup the your OpenCV view, so it takes up the entire App screen......
    //imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(x_pos, y_pos, frame_width, frame_height)];
    imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView_.contentMode = UIViewContentModeScaleAspectFit;
    
    // 2. Important: add OpenCV_View as a subview
    [self.view addSubview:imageView_];
    
    
    
    
    // 4. Next convert to a cv::Mat
    cv::Mat cvImage; UIImageToMat(image, cvImage);
    
    // 5. Now apply some OpenCV operations
    cv::Mat gray; cv::cvtColor(cvImage, gray, CV_RGBA2GRAY); // Convert to grayscale
    //cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2, 1.2); // Apply Gaussian blur
    //cv::Mat edges; cv::Canny(gray, edges, 0, 50); // Estimate edge map using Canny edge detector
    
    //New code here
    //Face Detection
    
    cv::CascadeClassifier face_cascade;
    
    
    std::string face_search_string = [[[NSBundle mainBundle] pathForResource: @"haarcascade_frontalface_alt" ofType: @"xml"] UTF8String];
    
    if (!face_cascade.load(face_search_string)) {
        cout << "No file loaded" << endl;
    }
    
    vector<cv::Rect> faces;
    face_cascade.detectMultiScale(gray, faces, 1.1, 2, 0 | CV_HAAR_SCALE_IMAGE, cv::Size(30,30));
    
    cout << "Detected " << faces.size() << " faces!" << endl;
    
    //Eyes Detection
    cv::CascadeClassifier eye_cascade;
    
    
    std::string eye_search_string = [[[NSBundle mainBundle] pathForResource: @"haarcascade_eye" ofType: @"xml"] UTF8String];
    
    if (!eye_cascade.load(eye_search_string)) {
        cout << "No file loaded" << endl;
    }
    
    vector<cv::Rect> eyes;
    eye_cascade.detectMultiScale(gray, eyes, 1.1, 2, 0 | CV_HAAR_SCALE_IMAGE, cv::Size(3,3));
    
    cout << "Detected " << eyes.size() << " eyes!" << endl;
    
    
    
    //Drawing on the figure
    bool draw_flag = 0;
    cv::Mat display_image;
    //if (gray.channels() == 3) display_image = cvImage.clone();
    //else cv::cvtColor(gray, display_image, CV_GRAY2BGR);
    display_image = cvImage.clone();
    
    if(draw_flag)
    {
        
        
        if (faces.size()>0) {
            for(int i=0;i<faces.size(); i++)
                cv::rectangle(display_image, faces[i] , RED);
        }
        
        if (eyes.size()>0) {
            for(int i=0;i<eyes.size(); i++)
            {
                cv::Point center = cv::Point(eyes[i].x+0.5*eyes[i].width,eyes[i].y+0.5*eyes[i].height);
                int radius = eyes[i].width/4+eyes[i].height/4;
                cv::circle(display_image, center, radius, GREEN);
            }
        }
        
        cv::Point text_org = cv::Point(0.3*image_width, 0.95*image_height);
        cv::putText(display_image, "adityas2", text_org, cv::FONT_HERSHEY_COMPLEX, 1.5, PINK);
        
    }
    
    // 6. Finally display the result
    imageView_.image = MatToUIImage(display_image);
    
    // ALL DONE :)
}
@end