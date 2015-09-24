//
//  MemeEditorController.swift
//  MemeMe
//
//  Created by Arkaprava De on 23/09/15.
//  Copyright © 2015 Arkaprava De. All rights reserved.
//

import UIKit

class MemeEditorController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextView: UITextView!
    @IBOutlet weak var bottomTextView: UITextView!
    
    var memeImage:MemeImageModel!
    var isViewSlidedUp = false
    var viewSlideUpValue:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topTextView.text = "TOP"
        bottomTextView.text = "BOTTOM"
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : 3.0
        ]
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        
        if (UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera) == nil) {
            cameraButton.enabled = false
        }
        
        //TODO: Add attributes to text view
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    func subscribeToKeyboardNotifications() {
        print("subscribing !")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        print("unsubscribing")
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {

        print("show keyboard")
        if bottomTextView.isFirstResponder() && !isViewSlidedUp {
            viewSlideUpValue = getKeyboardHeight(notification)
            self.view.frame.origin.y -= viewSlideUpValue
            isViewSlidedUp = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        print("hide keyboard")
        
        if bottomTextView.isFirstResponder() && isViewSlidedUp {
            self.view.frame.origin.y += viewSlideUpValue
            isViewSlidedUp = false
        }
    }
    
    func openImagePickerFromSourceType(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cameraAction(sender: UIBarButtonItem) {
        
        openImagePickerFromSourceType(UIImagePickerControllerSourceType.Camera)
    }

    @IBAction func albumAction(sender: UIBarButtonItem) {
        
        openImagePickerFromSourceType(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            pickedImage.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

