//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Humberto Aquino on 4/3/15.
//  Copyright (c) 2015 Humberto Aquino. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    // MARK: -
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField("TOP", textField: topTextField)
        setupTextField("BOTTOM", textField: bottomTextField)
    }

    func setupTextField(string: String, textField: UITextField) {
        textField.delegate = self
        // Text should approximate the "Impact" font, all caps, white with a black outline
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3
        ]
        
        let attributedString = NSAttributedString(string: string, attributes: memeTextAttributes)
        textField.attributedText = attributedString
        textField.defaultTextAttributes = memeTextAttributes
        // Text should be center-aligned
        textField.textAlignment = .Center
    }
    
    override func viewWillAppear(animated: Bool) {
        // Enable the camera button if is supported by the device
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    // MARK: -
    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // When a user taps inside a textfield, the default text should clear.
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // When a user presses return, the keyboard should be dismissed
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: -
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = editedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: -
    // MARK: Actions
    
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        presentImagePickerOfType(.PhotoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        presentImagePickerOfType(.Camera)
    }
    
    // MARK: -
    // MARK: Utility methods
    
    func presentImagePickerOfType(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
}

