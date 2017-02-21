//
//  MemeCollectionViewController.swift
//  MoveKeyboard
//
//  Created by Edvin Lellhame on 6/9/16.
//  Copyright © 2016 Edvin Lellhame. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    override func viewWillAppear(_ animated: Bool) {
        myCollectionView.reloadData()
    }
 

    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        cell.topLabel.text = meme.topText
        cell.bottomLabel.text = meme.bottomText
        
        let _ = FormatText.formatLabel(cell.topLabel).text
        let _ = FormatText.formatLabel(cell.bottomLabel).text
        
        return cell
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollectionDetail" {
            let indexPaths = myCollectionView.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as IndexPath
            
            
            let vc = segue.destination as! DetailViewController
            vc.memes = memes[indexPath.row]
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
