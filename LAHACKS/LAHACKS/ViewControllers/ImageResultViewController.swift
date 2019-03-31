//
//  ImageResultViewController.swift
//  LEAF
//
//  Created by 王传正 on 2019/3/30.
//  Copyright © 2019 gpa4. All rights reserved.
//

import UIKit

protocol ImageResultViewControllerDelegate: class {
    func getResult()
    func getImage() -> UIImage
    func getFlower() -> String?
    func getProb() -> Int?
}

class ImageResultViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var flowerLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    weak var delegate: ImageResultViewControllerDelegate?
    private let correctFlowers = [
        "cyclamen "//, "thorn apple", "fox glove", "magnolia", "sweet pea"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = delegate?.getImage()
        if delegate!.getProb()! < 60 {
            flowerLabel.text = "Sorry, I don't see any plants. \nCare to try again? "//(\(delegate!.getProb()!))"
            doneButton.setTitle("Again", for: .normal)
        } else {
            if correctFlowers.contains(delegate!.getFlower()!) {
                flowerLabel.text = "You found \(delegate!.getFlower()!)! Yay for you!"
                doneButton.setTitle("OK", for: .normal)
            } else {
                flowerLabel.text = "Sorry, that's not the right one! \nCare to try again? "//(\(delegate!.getFlower()!))"
                doneButton.setTitle("Again", for: .normal)
            }
        }
        //flowerLabel.text = delegate?.getResult()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

