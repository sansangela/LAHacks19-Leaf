//
//  ViewController.swift
//  LAHACKS
//
//  Created by Angela Chen on 3/29/19.
//  Copyright © 2019 Angela Chen. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate: class {
    func getFlower() -> String?
    func getProb() -> Int?
    func getImage() -> UIImage
    func reset()
}

class ViewController: UIViewController {
    
    var myPoints: Int = 36;
    var myFlower: (String, UIImage)?

    @IBOutlet weak var myPointLabel: UILabel!
    
    @IBOutlet weak var No1: UIImageView!
    @IBOutlet weak var No2: UIImageView!
    @IBOutlet weak var hint1: UITextView!
    @IBOutlet weak var hint2: UITextView!
    @IBOutlet weak var hint3: UITextView!
    @IBOutlet weak var hint4: UITextView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 180
    var timer = Timer()
    var isTimerRunning = false
    
    weak var delegate: ViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hint1.isHidden = true
        hint2.isHidden = true
        hint3.isHidden = true
        hint4.isHidden = true
//        if let prob = delegate?.getProb() {
//            if prob >= 70 {
//                myPoints += 5
//            }
//            myFlower = ((delegate?.getFlower())!, (delegate?.getImage())!)
//            delegate?.reset()
//        } else {
//            print("delegate is nil")
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
        print("VIEW LOADED")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if myFlower != nil {
//            myPoints += 5
//            print("POINTS ADDED!")
//        }
//        updateLabels()
//        print("APPEAR!")
//    }
    
    
    
    @IBAction func startCountdown(_ sender: Any) {
        hint1.isHidden = false
        DispatchAfter(after: 2) {
            self.hint2.isHidden = false
        }
        DispatchAfter(after: 4) {
            self.hint3.isHidden = false
        }
        DispatchAfter(after: 6) {
            self.hint4.isHidden = false
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:(#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    // func win points
    
    @objc func updateTimer() {
        seconds -= 1
        timerLabel.text = "\(seconds)"
    }
    
    func updateLabels() {
        myPointLabel.text = String(myPoints)
        print("UPDATED!")
    }
    
    public func DispatchAfter(after: Double, handler:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handler()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Camera" {
            let vc = segue.destination as! MainViewController
            vc.delegate = self
        }
        if let v = self.tabBarController?.viewControllers![3] {
            let cv = v as! CollectionViewController
            cv.delegate = self
        }
    }
    
}

extension ViewController: CollectionViewControllerDelegate {
    func getInfo() -> (String, UIImage)? {
        return myFlower
    }
}

extension ViewController: MainViewControllerDelegate {
    func refresh(_ info: (String, UIImage)) {
        myFlower = info
        
        myPoints += 5
        updateLabels()
        
        if myPoints >= 41 {
            No1.image = UIImage(named: "friend1.png")
            No2.image = UIImage(named: "friend2.png")
        }
        
    }
}
