//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Humberto Aquino on 4/4/15.
//  Copyright (c) 2015 Humberto Aquino. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let applicationDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        memes = applicationDelegate.memes
        self.tableView.reloadData()
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell") as MemeTableViewCell
        
        let meme = memes[indexPath.row]
            
        cell.memeImageView.image = meme.memedImage
        cell.memeLabel.text = meme.top
        
        return cell
    }
    
    
    @IBAction func createMeme(sender: UIBarButtonItem) {        
        let memeEditorController = storyboard!.instantiateViewControllerWithIdentifier("memeEditor") as MemeEditorViewController
        
        self.presentViewController(memeEditorController, animated: true, completion: nil)
    }
}
