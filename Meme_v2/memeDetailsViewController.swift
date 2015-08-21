//
//  memeDetailsViewController.swift
//  Meme_v2
//
//  Created by Anya Gerasimchuk on 8/17/15.
//  Copyright (c) 2015 Anya Gerasimchuk. All rights reserved.
//




import UIKit

class memeDetailsViewController: UIViewController{
    
    
    var receivedMemedImage : Meme!
    
    @IBOutlet weak var selectedMemedImage: UIImageView!

    
  
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        
        selectedMemedImage.image = receivedMemedImage.memedImage
        //selectedMemedImage.contentMode = UIViewContentMode.ScaleToFill
        

    }


    
  
}
