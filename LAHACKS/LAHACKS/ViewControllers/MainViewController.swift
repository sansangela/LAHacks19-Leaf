//
//  ViewController.swift
//  LEAF
//
//  Created by 王传正 on 2019/3/30.
//  Copyright © 2019 gpa4. All rights reserved.
//

import UIKit
import AVFoundation

protocol MainViewControllerDelegate: class {
    func refresh(_ info: (String, UIImage))
}

class MainViewController: UIViewController {

    @IBOutlet weak var cameraView: UIImageView!
    
    private let captureDevice = AVCaptureDevice.default(for: .video)!
    private let imageProcessor = ImageProcessor()
    
    weak var delegate: MainViewControllerDelegate?
    
    private var shouldDismiss = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProcessor.delegate = self
        imageProcessor.setupCaptureSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imageProcessor.stopCaptureSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageProcessor.startCaptureSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if shouldDismiss {
            dismiss(animated: true, completion: {
                self.delegate!.refresh((self.imageProcessor.flower!, self.imageProcessor.cropImage()))
            })
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        getResult()
        let correctFlowers = [
            "cyclamen "//, "thorn apple", "fox glove", "magnolia", "sweet pea"
        ]
        if imageProcessor.probability! >= 60 && correctFlowers.contains(imageProcessor.flower!) {
            shouldDismiss = true
        }
        if segue.identifier == "Result" {
            let vc = segue.destination as! ImageResultViewController
            vc.delegate = self
        }
    }

}

extension MainViewController: ImageProcessorDelegate {
    func setupCameraView(with layer: AVCaptureVideoPreviewLayer) {
        let layerToAdd = layer
        layerToAdd.frame = cameraView.bounds
        cameraView.layer.addSublayer(layerToAdd)
    }
}

extension MainViewController: ImageResultViewControllerDelegate, ViewControllerDelegate {
    func getResult() {
        imageProcessor.classify()
    }
    func getImage() -> UIImage {
        return imageProcessor.cropImage()
    }
    func getFlower() -> String? {
        return imageProcessor.flower ?? nil
    }
    func getProb() -> Int? {
        return imageProcessor.probability ?? nil
    }
    func reset() {
        imageProcessor.reset()
    }
}

