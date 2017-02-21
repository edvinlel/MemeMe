//
//  MemeViewController.swift
//  MoveKeyboard
//
//  Created by Edvin Lellhame on 6/1/16.
//  Copyright © 2016 Edvin Lellhame. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let imagePicker = UIImagePickerController()
    var memeImage = UIImage()
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        imagePicker.delegate = self
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        // Disable camera button if phone does not support camera
        // Also disable share button if no photo to share
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
        
        // Format text fields to custom text attributes
        FormatText.formatTextField(topTextField)
        FormatText.formatTextField(bottomTextField)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeToKeyboardNotifications()
    }
    
    // MARK: Helper Method(s)
    
    func tapDismissKeyboard() {
        view.endEditing(true)
    }
    
    func save() {
        // Create the meme
        guard let topText = topTextField.text else { return }
        guard let bottomText = bottomTextField.text else { return }
        guard let image = imageView.image else { return }
        let meme = Meme(topText: topText, bottomText: bottomText, image: image, memedImage: generateMemedImage())
        
        // Add it to the memes array in the AppDelegate
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        navigationController?.isNavigationBarHidden = true
        toolbar.isHidden = true
        view.backgroundColor = UIColor.white
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame,
                                     afterScreenUpdates: true)
        memeImage =
            UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        navigationController?.isNavigationBarHidden = false
        toolbar.isHidden = false
        view.backgroundColor = UIColor.darkGray
        
        return memeImage
       
    }
    
    func presentImagePickerWithSourceType(_ sourceType: UIImagePickerControllerSourceType) {
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: @IBAction(s)
    
    @IBAction func onShareButtonPressed(_ sender: AnyObject) {
        let message = "Check out this meme!"
        memeImage = generateMemedImage()
        let sharedImage = [message, memeImage] as [Any]
        let activityController = UIActivityViewController(activityItems: sharedImage, applicationActivities: nil)
        activityController.completionHandler = { success, error in
            if success != nil {
                self.save()
                //self.navigationController?.popToRootViewControllerAnimated(false)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(activityController, animated: true, completion: nil)
    }
    @IBAction func onCancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLibraryButtonPressed(_ sender: AnyObject) {
        presentImagePickerWithSourceType(.photoLibrary)
    }
    
    @IBAction func onCameraButtonPressed(_ sender: AnyObject) {
        presentImagePickerWithSourceType(.camera)
    }
    
    
    
    // MARK: NSNotificationCenter Methods
    
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    func keyboardWillHide() {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
        
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

}


