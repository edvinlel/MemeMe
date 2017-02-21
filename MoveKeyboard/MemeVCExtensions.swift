//
//  MemeVCExtensions.swift
//  MoveKeyboard
//
//  Created by Edvin Lellhame on 6/9/16.
//  Copyright © 2016 Edvin Lellhame. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController: UITextFieldDelegate {
    // MARK: UITextFieldDelegate Method(s)
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}


extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: UIImagePickerControllerDelegate Method(s)
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let tempImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        imageView.image = tempImage
        shareButton.isEnabled = true
        
        topTextField.text = ""
        topTextField.becomeFirstResponder()
        
        dismiss(animated: true, completion: nil)
        
    }
}
