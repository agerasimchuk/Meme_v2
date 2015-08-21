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
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    
    override func viewWillAppear(animated: Bool) {
        camButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotification()
        subscribeToKeyboardHideNotification()
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotification()
        unsubscribeFromKeyboardHideNotification()
    }
    
    
    
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
    
    
    @IBAction func cancelEditor(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
        if textBottom.isFirstResponder(){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if textBottom.isFirstResponder(){
            view.frame.origin.y += getKeyboardHeight(notification)
        }
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
        presentViewController(pickerController, animated: true, completion: nil)
        
        
    }
    
    //Pick an image from camera
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(pickerController, animated: true, completion: nil)
        
        
        
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
            dismissViewControllerAnimated(true, completion: nil)
            
            displayShowButton()
            
            
        }
        
        
    }
    
    
    func generateMemedImage() -> UIImage
    {
        
        //Hide toolbar and navbar
        navigationController?.navigationBar.hidden = true
        bottomToolbar.hidden = true
        topBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        //Show toolbar and navbar
        navigationController?.navigationBarHidden = false
        
        
        return memedImage
        
        
    }
    
    func save(){
        println("in save method")
        var meme = Meme( topText: textTop.text!, bottomText: textBottom.text!, imageOriginal:
            imagePickerView.image!, memedImage: generateMemedImage())
        
        //Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        appDelegate.memes.append(meme)
        //self.dismissViewControllerAnimated(true, completion: nil)

        
    }
    
    @IBAction func share(sender: AnyObject) {
        println("in share method")
        let memeImage = generateMemedImage()
        
        let myactivityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        myactivityController.completionWithItemsHandler = {
            (s: String!, ok: Bool, items: [AnyObject]!, err:NSError!) -> Void in
            self.save()
 
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        presentViewController(myactivityController, animated: true, completion: nil)

        
          
    }
    
    func showTableView(){
        //present table view
        var controller: UITabBarController
        controller = storyboard?.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
        presentViewController(controller, animated: true, completion: nil)

    }
}

