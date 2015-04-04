//
//  Meme.swift
//  MemeMe
//
//  Created by Humberto Aquino on 4/4/15.
//  Copyright (c) 2015 Humberto Aquino. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject {
    
    let top: String
    let bottom: String
    let image: UIImage
    let memedImage: UIImage
    
    init(top: String, bottom: String, image: UIImage, memedImage: UIImage) {
        self.top = top
        self.bottom = bottom
        self.image = image
        self.memedImage = memedImage
    }
}