//
//  CollectionViewController.swift
//  LAHACKS
//
//  Created by Angela Chen on 3/30/19.
//  Copyright © 2019 Angela Chen. All rights reserved.
//

import UIKit

protocol CollectionViewControllerDelegate: class {
    func getInfo() -> (String, UIImage)?
}

class CollectionViewController: UIViewController {

    @IBOutlet weak var latestCollectionImage: UIImageView!
    @IBOutlet weak var latestCollectionName: UILabel!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var thirdName: UILabel!
    
    weak var delegate: CollectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        latestCollectionName.text = delegate?.getInfo()?.0 ?? latestCollectionName.text
        thirdName.text = delegate?.getInfo()?.0 ?? "?"
        latestCollectionImage.image = delegate?.getInfo()?.1 ?? latestCollectionImage.image
        thirdImage.image = delegate?.getInfo()?.1 ?? UIImage(named: "Grey.png")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
