//
//  DetectedEmotion.swift
//  OpenCVTest
//
//  Created by Peter Entwistle on 08/01/2017.
//  Copyright © 2017 Peter Entwistle. All rights reserved.
//

@objc class DetectedEmotion: NSObject {
    private var _frame: UIImage
    private var _emotion: Emotion
    
    var frame: UIImage {
        return _frame
    }
    
    var emotion: Emotion {
        return _emotion
    }
    
    
    init(frame: UIImage, emotion: Emotion) {
        _frame = frame
        _emotion = emotion
    }
    
}
