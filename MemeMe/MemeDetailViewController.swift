//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Humberto Aquino on 4/4/15.
//  Copyright (c) 2015 Humberto Aquino. All rights reserved.
//

import Foundation
import UIKit

// View for the detail of a meme
class MemeDetailViewController: UIViewController {
    
    // Image view that will contain the memed image
    @IBOutlet weak var imageView: UIImageView!
    
    var memeIndex: Int!
    var meme: Meme!
    
    // MARK: -
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editMeme:")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = meme.memedImage
    }
    
    // MARK: -
    // MARK: Actions
    
    @IBAction func deleteMeme(sender: UIButton) {
        MemeManager.sharedInstance.deleteMemeAtIndex(self.memeIndex)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func editMeme(sender: UIBarButtonItem) {
        let memeEditorController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditor") as MemeEditorViewController
        memeEditorController.meme = meme
        presentViewController(memeEditorController, animated: true, completion: nil)
    }
}