//
//  OpenCVWrapper.mm
//  OpenCVTest
//
//  Created by Peter Entwistle on 03/10/2016.
//  Copyright © 2016 Peter Entwistle. All rights reserved.
//

#include "OpenCVWrapper.h"
#import <opencv2/highgui/ios.h>
using namespace cv;
using namespace std;

@implementation OpenCVWrapper : NSObject

CascadeClassifier face_cascade;
CascadeClassifier eyes_cascade;

cv::CascadeClassifier cascade;

- (id)init {
    self = [super init];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *pathFace = [bundle pathForResource:@"haarcascade_frontalface_alt" ofType:@"xml"];
    std::string faceCascadePath = (char *)[pathFace UTF8String];
    
    if(!face_cascade.load(faceCascadePath)) {
        return nil;
    }

    NSString *pathEye = [bundle pathForResource:@"haarcascade_eye_tree_eyeglasses" ofType:@"xml"];
    std::string eyeCascadePath = (char *)[pathEye UTF8String];
    
    if(!eyes_cascade.load(eyeCascadePath)) {
        return nil;
    }
    
    return self;
}

+ (UIImage *)processImageWithOpenCV:(UIImage*)inputImage {
	//Mat mat = [inputImage CVMat];
	
	// do your processing here
	//...
	
	//return [UIImage imageWithCVMat:mat];
	return UIGraphicsGetImageFromCurrentImageContext();
}
/*
void detectAndDisplay(Mat frame) {
    std::vector<cv::Rect> faces;
    Mat frame_gray;

    cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
    equalizeHist(frame_gray, frame_gray);

    //-- Detect faces
    face_cascade.detectMultiScale(frame_gray, faces, 1.1, 2, 0|CASCADE_SCALE_IMAGE, cv::Size(30, 30));

    for (size_t i = 0; i < faces.size(); i++) {
        cv::Point center(faces[i].x + faces[i].width/2, faces[i].y + faces[i].height/2);
        ellipse(frame, center, cv::Size(faces[i].width/2, faces[i].height/2), 0, 0, 360, Scalar(255, 0, 255), 4, 8, 0);

        Mat faceROI = frame_gray(faces[i]);
        std::vector<cv::Rect> eyes;

        //-- In each face, detect eyes
        eyes_cascade.detectMultiScale(faceROI, eyes, 1.1, 2, 0 |CASCADE_SCALE_IMAGE, cv::Size(30, 30));

        for (size_t j = 0; j < eyes.size(); j++) {
            cv::Point eye_center(faces[i].x + eyes[j].x + eyes[j].width/2, faces[i].y + eyes[j].y + eyes[j].height/2);
            int radius = cvRound((eyes[j].width + eyes[j].height)*0.25);
            circle(frame, eye_center, radius, Scalar(255, 0, 0), 4, 8, 0);
        }
    }
    //-- Show what you got
    imshow(window_name, frame);
}
*/

typedef struct _vectorOfCvRect
{
	std::vector<cv::Rect> val;
} *vectorOfCvRectPtr;

- (UIImage *)detectAndDisplay:(UIImage*)input {
    std::vector<cv::Rect> faces;
    Mat frame_gray;
    Mat frame;
    
    UIImageToMat(input, frame);
    
    cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
    equalizeHist(frame_gray, frame_gray);
    
    //-- Detect faces
    face_cascade.detectMultiScale(frame_gray, faces, 1.1, 2, 0|CASCADE_SCALE_IMAGE, cv::Size(30, 30));
    
    for (size_t i = 0; i < faces.size(); i++) {
        cv::Point center(faces[i].x + faces[i].width/2, faces[i].y + faces[i].height/2);
        ellipse(frame, center, cv::Size(faces[i].width/2, faces[i].height/2), 0, 0, 360, Scalar(255, 0, 255), 4, 8, 0);
        
        Mat faceROI = frame_gray(faces[i]);
        std::vector<cv::Rect> eyes;
        
        //-- In each face, detect eyes
        eyes_cascade.detectMultiScale(faceROI, eyes, 1.1, 2, 0 |CASCADE_SCALE_IMAGE, cv::Size(30, 30));
        
        for (size_t j = 0; j < eyes.size(); j++) {
            cv::Point eye_center(faces[i].x + eyes[j].x + eyes[j].width/2, faces[i].y + eyes[j].y + eyes[j].height/2);
            int radius = cvRound((eyes[j].width + eyes[j].height)*0.25);
            circle(frame, eye_center, radius, Scalar(255, 0, 0), 4, 8, 0);
        }
    }
    //-- Show what you got
    UIImage *resultImage = MatToUIImage(frame);
    return resultImage;
}


/*
 WORKING VERSION 
 
 
 
 - (UIImage *)detectAndDisplay:(UIImage*)input {
 std::vector<cv::Rect> faces;
 Mat frame_gray;
 Mat frame;
 
 UIImageToMat(input, frame);
 
 cvtColor(frame, frame_gray, COLOR_BGR2GRAY);
 equalizeHist(frame_gray, frame_gray);
 
 //-- Detect faces
 face_cascade.detectMultiScale(frame_gray, faces, 1.1, 2, 0|CASCADE_SCALE_IMAGE, cv::Size(30, 30));
 
 for (size_t i = 0; i < faces.size(); i++) {
 cv::Point center(faces[i].x + faces[i].width/2, faces[i].y + faces[i].height/2);
 ellipse(frame, center, cv::Size(faces[i].width/2, faces[i].height/2), 0, 0, 360, Scalar(255, 0, 255), 4, 8, 0);
 
 Mat faceROI = frame_gray(faces[i]);
 std::vector<cv::Rect> eyes;
 
 //-- In each face, detect eyes
 eyes_cascade.detectMultiScale(faceROI, eyes, 1.1, 2, 0 |CASCADE_SCALE_IMAGE, cv::Size(30, 30));
 
 for (size_t j = 0; j < eyes.size(); j++) {
 cv::Point eye_center(faces[i].x + eyes[j].x + eyes[j].width/2, faces[i].y + eyes[j].y + eyes[j].height/2);
 int radius = cvRound((eyes[j].width + eyes[j].height)*0.25);
 circle(frame, eye_center, radius, Scalar(255, 0, 0), 4, 8, 0);
 }
 }
 //-- Show what you got
 UIImage *resultImage = MatToUIImage(frame);
 return resultImage;
 }

 */



/*
+ (UIImage *)recognizeFace:(UIImage *)image {
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat mat(rows, cols, CV_8UC4);
    
    CGContextRef contextRef = CGBitmapContextCreate(mat.data,
                                                    cols,
                                                    rows,
                                                    8,
                                                    mat.step[0],
                                                    colorSpace,
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    
    std::vector<cv::Rect> faces;
    cascade.detectMultiScale(mat, faces,
                             1.1, 2,
                             CV_HAAR_SCALE_IMAGE,
                             cv::Size(30, 30));

    std::vector<cv::Rect>::const_iterator r = faces.begin();
    for(; r != faces.end(); ++r) {
        cv::Point center;
        int radius;
        center.x = cv::saturate_cast<int>((r->x + r->width*0.5));
        center.y = cv::saturate_cast<int>((r->y + r->height*0.5));
        radius = cv::saturate_cast<int>((r->width + r->height) / 2);
        cv::circle(mat, center, radius, cv::Scalar(80,80,255), 3, 8, 0 );
    }
    
    UIImage *resultImage = MatToUIImage(mat);
    
    return resultImage;
}
*/

@end
