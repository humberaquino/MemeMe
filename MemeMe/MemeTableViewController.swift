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
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let applicationDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        memes = applicationDelegate.memes
        self.tableView.reloadData()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if memes.count == 0 {
            // No memes. Lets present the editor
            presentCleanMemeEditor()
        }
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
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let edit = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit", handler: { (action, indexPath) -> Void in
            let meme = self.memes[indexPath.row]
            self.presentMemeEditor(meme)
        })
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: { (action, indexPath) -> Void in
            self.removeMemeAtIndexPath(indexPath)
        })
        
        let arrayofactions: Array = [delete, edit]
        
        return arrayofactions

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        
        let destinationController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetail") as MemeDetailViewController
        destinationController.memedImage = meme.memedImage
        
        self.navigationController?.pushViewController(destinationController, animated: true)        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
            case .Delete:
                removeMemeAtIndexPath(indexPath)
            default:
                return
        }
    }
    
    func removeMemeAtIndexPath(indexPath: NSIndexPath) {
        // remove the deleted item from the model
        memes.removeAtIndex(indexPath.row)
        // remove the deleted item from the `UITableView`
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    @IBAction func createMeme(sender: UIBarButtonItem) {        
        presentCleanMemeEditor()
    }
    
    func presentCleanMemeEditor() {
        presentMemeEditor(nil)
    }
    
    func presentMemeEditor(meme: Meme?) {
        let memeEditorController = storyboard!.instantiateViewControllerWithIdentifier("memeEditor") as MemeEditorViewController
        if let existingMeme = meme {
            memeEditorController.meme = existingMeme
        }
        self.presentViewController(memeEditorController, animated: true, completion: nil)
    }
}
