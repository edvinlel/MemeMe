//
//  Format.swift
//  MoveKeyboard
//
//  Created by Edvin Lellhame on 6/9/16.
//  Copyright © 2016 Edvin Lellhame. All rights reserved.
//

import Foundation
import UIKit

struct FormatText {
    
    //** format uilabel attributes for meme image cells
    static func formatLabel(_ label: UILabel) -> UILabel {
        let attributes = memeAttributes()
        label.attributedText = NSAttributedString(string: label.text!, attributes: attributes)
        
        return label
    }
    
    //** format textfield attributes for meme images
    static func formatTextField(_ textField: UITextField) {
        let attributes = memeAttributes()
        textField.defaultTextAttributes = attributes
        textField.textAlignment = .center
    }
    
    //** attribute format for memes
    static func memeAttributes() -> [String: AnyObject] {
        let attributes = [NSStrokeColorAttributeName: UIColor.black,
                          NSForegroundColorAttributeName: UIColor.white,
                          NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                          NSStrokeWidthAttributeName: -3.0
        ] as [String : Any]
        
        return attributes as [String : AnyObject]
    }
}
