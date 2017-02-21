//
//  MemeTableViewController.swift
//  MoveKeyboard
//
//  Created by Edvin Lellhame on 6/8/16.
//  Copyright © 2016 Edvin Lellhame. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var memeTableView: UITableView!
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        memeTableView.reloadData()
    }
    
    // MARK: TableView(s)

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        
        cell.topTextLabel.text = "\(meme.topText)...\(meme.bottomText)"
        cell.myImageView.image = meme.memedImage
        cell.topImageTextLabel.text = meme.topText
        cell.bottomImageTextLabel.text = meme.bottomText
        
        let _ = FormatText.formatLabel(cell.topImageTextLabel).text
        let _ = FormatText.formatLabel(cell.bottomImageTextLabel).text
        
        return cell
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let indexPaths = memeTableView.indexPathForSelectedRow
            let indexPath = indexPaths! as IndexPath
            
            let vc = segue.destination as! DetailViewController
            vc.memes = memes[indexPath.row]
        } 
    }
}
