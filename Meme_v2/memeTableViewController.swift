//
//  memeTableViewController.swift
//  Meme_v2
//
//  Created by Anya Gerasimchuk on 8/12/15.
//  Copyright (c) 2015 Anya Gerasimchuk. All rights reserved.
//

import Foundation
import UIKit

class memeTableViewController: UITableViewController{
    var memes: [Meme]!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        let meme = self.memes[indexPath.row]
        let displayImage = meme.memedImage
        
        
        
        
        cell.textLabel?.text = meme.topText
        cell.imageView?.image = meme.imageOriginal
        
return cell
    }
    
}