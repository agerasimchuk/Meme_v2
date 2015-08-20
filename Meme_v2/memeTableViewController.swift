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
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        var cellmeme = memes[indexPath.row]
        //let displayImage = cellmeme.memedImage
        

        
        cell.textLabel?.text = cellmeme.topText
        cell.imageView?.image = cellmeme.imageOriginal

        
return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
     let MemeDetailsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("memeDetails") as! memeDetailsViewController
        
        var memeImage = self.memes[indexPath.row].memedImage

        
        MemeDetailsViewController.receivedMemedImage = self.memes[indexPath.row]

        
        self.navigationController?.pushViewController(MemeDetailsViewController, animated: true)        }
    
}