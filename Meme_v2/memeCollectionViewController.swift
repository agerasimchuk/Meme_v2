//
//  memeCollectionViewController.swift
//  Meme_v2
//
//  Created by Anya Gerasimchuk on 8/12/15.
//  Copyright (c) 2015 Anya Gerasimchuk. All rights reserved.
//

import Foundation
import UIKit

class memeCollectionViewController: UIViewController{
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
}