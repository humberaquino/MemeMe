//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Humberto Aquino on 4/4/15.
//  Copyright (c) 2015 Humberto Aquino. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var memedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = memedImage
    }
    
}