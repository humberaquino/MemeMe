//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Humberto Aquino on 4/4/15.
//  Copyright (c) 2015 Humberto Aquino. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var memes: [Meme]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let applicationDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        memes = applicationDelegate.memes
        collectionView.reloadData()
    }
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
//        cell.memeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        
        let destinationController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetail") as MemeDetailViewController
        destinationController.memedImage = meme.memedImage
        
        self.navigationController?.pushViewController(destinationController, animated: true)
    }
    
    
    @IBAction func createMeme(sender: UIBarButtonItem) {
        presentMemeEditor()
    }
    
    func presentMemeEditor() {
        let memeEditorController = storyboard!.instantiateViewControllerWithIdentifier("memeEditor") as MemeEditorViewController
        
        self.presentViewController(memeEditorController, animated: true, completion: nil)
    }
}