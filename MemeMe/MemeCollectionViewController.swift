//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Humberto Aquino on 4/4/15.
//  Copyright (c) 2015 Humberto Aquino. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        memes = applicationDelegate.memes
    }
}