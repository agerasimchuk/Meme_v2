//
//  memeCollectionViewController.swift
//  Meme_v2
//
//  Created by Anya Gerasimchuk on 8/12/15.
//  Copyright (c) 2015 Anya Gerasimchuk. All rights reserved.
//

import UIKit

var memes: [Meme]!

class memeCollectionViewController: UICollectionViewController {
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        collectionView!.reloadData()
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! UICollectionViewCell
        let meme = memes[indexPath.item]
        let imageView = UIImageView(image: meme.memedImage)
        cell.backgroundView = imageView
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
 let MemeDetailsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("memeDetails") as! memeDetailsViewController
        
        
        MemeDetailsViewController.receivedMemedImage = memes[indexPath.item]
        
        self.navigationController!.pushViewController(MemeDetailsViewController, animated: true)
        
    }
    
}
