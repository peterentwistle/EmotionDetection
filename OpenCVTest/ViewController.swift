//
//  ViewController.swift
//  OpenCVTest
//
//  Created by Peter Entwistle on 03/10/2016.
//  Copyright © 2016 Peter Entwistle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
	
	@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var detectedEmotion: UILabel!
    
    var openCVWrapper: OpenCVWrapper!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        openCVWrapper = OpenCVWrapper()
        
        let captureSession = AVCaptureSession()
        let devices = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera],
                                                      mediaType: AVMediaTypeVideo,
                                                      position: AVCaptureDevicePosition.front).devices
        let device = devices?.first
    
        do {
            try captureSession.addInput(AVCaptureDeviceInput(device: device))
        } catch {
            print("Can't find camera")
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
 
        //previewLayer?.frame = imageView.bounds
        imageView.layer.addSublayer(previewLayer!)
 
        captureSession.startRunning()
        
        let myOutput = AVCaptureVideoDataOutput()
        myOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_32BGRA)]
        
        let queue: DispatchQueue = DispatchQueue(label: "myqueue",  attributes: [])
        myOutput.setSampleBufferDelegate(self, queue: queue)
        
        captureSession.addOutput(myOutput)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        DispatchQueue.main.sync(execute: {

            let image = CameraUtil.imageFromSampleBuffer(sampleBuffer)

            let response = openCVWrapper.detectAndDisplay(image)
            self.imageView.image = response?.frame
            
            if let emotion = response?.detectedEmotion {
                
                if emotion.emotion == .happiness {
                    detectedEmotion.text = "Happiness!"
                    detectedEmotion.textColor = UIColor.red
                    detectedEmotion.font = detectedEmotion.font.withSize(30)
                } else {
                    detectedEmotion.text = "None"
                    detectedEmotion.textColor = UIColor.black
                    detectedEmotion.font = detectedEmotion.font.withSize(17)
                }
                //self.emotionImageView.image = emotion.frame
            }
        })
    }
	
	/*var camera: CvVideoCamera
	
	init() {
	camera = CvVideoCamera(parentView: imageView)
	super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
	camera = CvVideoCamera(parentView: imageView)
	super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
	super.viewDidLoad()
	// Do any additional setup after loading the view, typically from a nib.
	
	camera.defaultAVCaptureDevicePosition = AVCaptureDevicePosition.back
	camera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480
	camera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientation.portrait
	camera.defaultFPS = 30
	camera.grayscaleMode = false
	camera.delegate = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
	camera.start()
	}
	
	override func didReceiveMemoryWarning() {
	super.didReceiveMemoryWarning()
	// Dispose of any resources that can be recreated.
	}*/

}
