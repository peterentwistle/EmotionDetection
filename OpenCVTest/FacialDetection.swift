//
//  FacialDetection.swift
//  OpenCVTest
//
//  Created by Peter Entwistle on 24/10/2016.
//  Copyright © 2016 Peter Entwistle. All rights reserved.
//

import Foundation


let test: CvMat = CvMat()

class FacialDetection {

  /*  init() {
        
        let bundle = Bundle.main
        
        let pathFace = bundle.path(forResource: "haarcascade_frontalface_alt", ofType:"xml")
        
        std::string faceCascadePath = (char *)[pathFace UTF8String]
        
        if(!face_cascade.load(faceCascadePath)) {
            return nil
        }
        
        NSString *pathEye = [bundle pathForResource:@"haarcascade_eye_tree_eyeglasses" ofType:@"xml"]
        std::string eyeCascadePath = (char *)[pathEye UTF8String]
        
        if(!eyes_cascade.load(eyeCascadePath)) {
            return nil
        }
    }
*/
    func detectAndDisplay(input: UIImage) -> UIImage {
        //std::vector<cv::Rect> faces;

        var openCVWrapper = OpenCVWrapper()

        var faces: VectorOfCvRect
        
        let frameGray: UnsafeMutablePointer<CvMatrix?> =  UnsafeMutablePointer<CvMatrix?>.allocate(capacity: 1)
        let frame: UnsafeMutablePointer<CvMatrix?> =  UnsafeMutablePointer<CvMatrix?>.allocate(capacity: 1)
        
        OpenCVWrapper.uiImage(toMat: input, frame: frame)
        
        OpenCVWrapper.cvtColor(frame, output: frameGray, color: OpenCVWrapper.color_BGR2GRAY)
        OpenCVWrapper.equalizeHist(frameGray, output: frameGray)
        
        // Deinitialise
        frame.deinitialize()
        frameGray.deinitialize()
		
		/*
		// test 
		let cppObject = UnsafeMutableRawPointer(initializeTest("haarcascade_frontalface_alt.xml"))
		let type = String.fromCString(imageType(cppObject))
		let dump = String.fromCString(hexdump(cppObject))
		self.imageTypeLabel.stringValue = type!
		self.dumpDisplay.stringValue = dump!
        */
        return input
    }

}
