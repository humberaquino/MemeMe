//
//  MemeManager.swift
//  MemeMe
//
//  Created by Humberto Aquino on 4/5/15.
//  Copyright (c) 2015 Humberto Aquino. All rights reserved.
//

import Foundation

// Class used to create a shared meme manager
class MemeManager: NSObject {
    
    // Singleton pattern: http://code.martinrue.com/posts/the-singleton-pattern-in-swift
    class var sharedInstance: MemeManager {
        struct Static {
            static var instance: MemeManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = MemeManager()
        }
        
        return Static.instance!
    }
    
    
    // Shared model representing the list of sent memes
    var memes = [Meme]()
    
    func deleteMemeAtIndex(index: Int) {
        memes.removeAtIndex(index)
    }
    
    func appendMeme(meme: Meme) {
        memes.append(meme)
    }
}