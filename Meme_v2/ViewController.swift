//
//  ViewController.swift
//  Meme_v2
//
//  Created by Anya Gerasimchuk on 8/7/15.
//  Copyright (c) 2015 Anya Gerasimchuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var camButton: UIButton!
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    
    
    
    override func viewWillAppear(animated: Bool) {
        camButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotification()
        self.subscribeToKeyboardHideNotification()
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotification()
        self.unsubscribeFromKeyboardHideNotification()
    }
    
    //ADD NOTIFICATIONS TO MOVE THE VIEW UP OR DOWN DEPENDING ON WHETHER THE KEYBOARD IS DISPLAYED OR HIDDEN
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        displayShowButton()
        
        
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),//TODO: Fill in appropriate UIColor,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName :1.9,
            
            //NSTextAlignment : NSTextAlignment(rawValue: 1)
            //topTextField.textAlignment(NSTextAlignment)
        ]
        
        // Do any additional setup after loading the view, typically from a nib.
        textTop.defaultTextAttributes = memeTextAttributes
        textTop.text = "TOP"
        textTop.textColor = UIColor.lightGrayColor()
        textTop.textAlignment = NSTextAlignment.Center
        textTop.delegate = self
        textBottom.defaultTextAttributes = memeTextAttributes
        textBottom.text = "BOTTOM"
        textBottom.textColor = UIColor.lightGrayColor()
        textBottom.textAlignment = NSTextAlignment.Center
        textBottom.delegate = self
    }
    //When a user presses return, the keyboard should be dismissed.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textBottom .resignFirstResponder()
        textTop .resignFirstResponder()
        
        
        
        return true
    }
    
    
    //When a user taps inside a textfield, the default text should clear.
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.textColor == UIColor.lightGrayColor(){
            textField.text = nil
            textField.textColor = UIColor.blackColor()
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        self.view.frame.origin.y -= getKeyboardHeight(notification)
        
    }
    
    func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func subscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)    }
    
    func unsubscribeFromKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardHideNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardHideNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Pick an image from an album
    @IBAction func pickAnImage(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
        
        
    }
    
    //Pick an image from camera
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(pickerController, animated: true, completion: nil)
        
        
        
    }
    
    func displayShowButton(){
        if (imagePickerView.image != nil){
            //the image set
            shareButton.enabled = true
        }else{
            shareButton.enabled = false
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = UIViewContentMode.ScaleToFill
            self.dismissViewControllerAnimated(true, completion: nil)
            
            displayShowButton()
            
            
        }
        
        
    }
    
    
    func generateMemedImage() -> UIImage
    {
        
        //Hide toolbar and navbar
        self.navigationController?.navigationBarHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        //Show toolbar and navbar
        self.navigationController?.navigationBarHidden = false
        
        
        return memedImage
        
        
    }
    
    func save(){
        let meme = Meme( topText: textTop.text!, bottomText: textBottom.text!, imageOriginal:
            imagePickerView.image!, memedImage: generateMemedImage())
        
    }
    
    @IBAction func share(sender: AnyObject) {
        
        
        let memeSavedImage = save()
        
        let memeImage = generateMemedImage()
        
        let myactivityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        
        self.presentViewController(myactivityController, animated: true, completion: nil)
        
    }
    
    
}

