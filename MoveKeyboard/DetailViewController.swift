//
//  DetailViewController.swift
//  MoveKeyboard
//
//  Created by Edvin Lellhame on 6/9/16.
//  Copyright © 2016 Edvin Lellhame. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    var memes: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = memes?.memedImage {
            myImageView.image = image
        }
    }
}
