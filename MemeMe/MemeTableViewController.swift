//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Humberto Aquino on 4/4/15.
//  Copyright (c) 2015 Humberto Aquino. All rights reserved.
//

import Foundation
import UIKit

// Table view for the sent memes
class MemeTableViewController: UITableViewController {
    
    // This is a flag used to identify if the meme editor was shown only the first time.
    // The problem araises when the user cancels the editor but doesn't have at least one
    // sent meme. In this situation the viewWillAppear method (whitout the flag) presents
    // the meme editor again, creating a "bounce" effect between the editor and the
    // sent meme list.
    var editorNotPresented = true
    
    var memes: [Meme]!
    
    // MARK: -
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the edit buttom in the navigation bar
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh the local memes
        memes = MemeManager.sharedInstance.memes        
        // Refresh the table list
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // The editor should be presented if there are no sent memes
        if memes.count == 0 && editorNotPresented {
            editorNotPresented = false
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
        cell.memeLabel.text = buildMemeTextSummary(meme)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            removeMemeAtIndexPath(indexPath)
        default:
            return
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        // Edit action
        let edit = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit", handler: { (action, indexPath) -> Void in
            let meme = self.memes[indexPath.row]
            self.presentMemeEditor(meme)
        })
        // Delete action
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: { (action, indexPath) -> Void in
            self.removeMemeAtIndexPath(indexPath)
        })
        
        let arrayofactions: Array = [delete, edit]
        
        return arrayofactions
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        
        let destinationController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetail") as MemeDetailViewController
        destinationController.meme = meme
        destinationController.memeIndex = indexPath.row
        
        self.navigationController?.pushViewController(destinationController, animated: true)
    }
    
    // MARK: -
    // MARK: Actions
    
    @IBAction func createMeme(sender: UIBarButtonItem) {
        presentCleanMemeEditor()
    }
    
    // MARK: -
    // MARK: Utilities
    
    // Presents the editor without an existing meme
    // This is just a wrapper method for better readability
    func presentCleanMemeEditor() {
        presentMemeEditor(nil)
    }
    
    // Correclty removes the meme from the model and the table
    func removeMemeAtIndexPath(indexPath: NSIndexPath) {
        // remove the deleted item from the model
        MemeManager.sharedInstance.deleteMemeAtIndex(indexPath.row)
        memes = MemeManager.sharedInstance.memes
        // remove the deleted item from the `UITableView`
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    // Presents the meme editor. Uses a existing meme if is provided as a parameter
    func presentMemeEditor(meme: Meme?) {
        let memeEditorController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditor") as MemeEditorViewController
        if let existingMeme = meme {
            memeEditorController.meme = existingMeme
        }
        self.presentViewController(memeEditorController, animated: true, completion: nil)
    }
    
    // Creates a string to display as the meme summary in a cell
    func buildMemeTextSummary(meme: Meme) -> String {
        let topCount = countElements(meme.top)
        let bottomCount = countElements(meme.bottom)
        
        var topSubstring = meme.top
        var bottomSubstring = meme.bottom
        
        return "\(topSubstring). \(bottomSubstring)"
    }

}
