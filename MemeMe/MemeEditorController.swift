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
    
    var memeImage:MemeImageModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topTextView.text = "TOP"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera) == nil) {
            cameraButton.enabled = false
        }
        
//        let memeTextAttributes = [
//            NSStrokeColorAttributeName : UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1),
//            NSForegroundColorAttributeName : UIColor(red: 0, green: 0, blue: 0, alpha: 1),
//            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
//            NSStrokeWidthAttributeName : //TODO: Fill in appropriate Float
//        ]
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
        print("selected")
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            pickedImage.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("cancelled")
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

