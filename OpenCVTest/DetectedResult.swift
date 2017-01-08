//
//  DetectedResult.swift
//  OpenCVTest
//
//  Created by Peter Entwistle on 08/01/2017.
//  Copyright © 2017 Peter Entwistle. All rights reserved.
//

@objc class DetectedResult: NSObject {
    private var _detectedEmotion: DetectedEmotion
    private var _frame: UIImage
    
    var detectedEmotion: DetectedEmotion? {
        return _detectedEmotion
    }
    
    var frame: UIImage? {
        return _frame
    }
    
    init(detectedEmotion: DetectedEmotion, frame: UIImage) {
        _detectedEmotion = detectedEmotion
        _frame = frame
    }
    
}
