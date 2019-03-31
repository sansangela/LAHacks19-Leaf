//
//  ImageProcessor.swift
//  LEAF
//
//  Created by 王传正 on 2019/3/30.
//  Copyright © 2019 gpa4. All rights reserved.
//

import UIKit
import AVFoundation

protocol ImageProcessorDelegate: class {
    func setupCameraView(with layer: AVCaptureVideoPreviewLayer)
}

class ImageProcessor: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let captureSession = AVCaptureSession()
    private let captureDevice = AVCaptureDevice.default(for: .video)!
    var capturedFrame = UIImage()
    var flowerImage = UIImage()
    
    var flower: String?
    var probability: Int?
    
    weak var delegate: ImageProcessorDelegate?
    let classifier = FlowerClassifier()
    
    func reset() {
        flower = nil
        probability = nil
    }
    
    func setupCaptureSession() {
        
        let input = try! AVCaptureDeviceInput(device: captureDevice)
        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoQueue"))
        let connection = output.connection(with: .video)
        connection?.videoOrientation = .portrait
        captureSession.addInput(input)
        captureSession.addOutput(output)
        
        let layer = AVCaptureVideoPreviewLayer(session: captureSession)
        delegate?.setupCameraView(with: layer)
        
        captureSession.startRunning()
        
    }
    
    func startCaptureSession() { captureSession.startRunning() }
    func stopCaptureSession() { captureSession.stopRunning() }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let outputImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer)
        capturedFrame = outputImage//cropImage(outputImage)
    }
    
    func classify() {
        
        flowerImage = cropImage()
        let buffer = flowerImage.buffer()!
        guard let output = try? classifier.prediction(data: buffer) else {
            print("Failed")
            return
        }
        
        let prob = Int(output.prob[output.classLabel]!*100)
        
        flower = output.classLabel
        probability = prob
        
        //return "I think it's a \(output.classLabel) at \(prob)%"
        
    }
    
    //Crop image to 227*227. Final crop.
    func cropImage() -> UIImage {
        let cropped = capturedFrame.cropsToSquare()
        let final = cropped.resized(toWidth: CGFloat(227))
        return final!
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage {
        
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        
        let ciImage = CIImage(cvPixelBuffer: imageBuffer!)
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent)
        let image = UIImage(cgImage: cgImage!)
        
        return image
        
    }
    
}
