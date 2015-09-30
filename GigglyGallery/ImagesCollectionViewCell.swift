//
//  ImagesCollectionViewCell.swift
//  GigglyGallery
//
//  Created by Saqib Omer on 9/30/15.
//  Copyright © 2015 Kaboom Labs. All rights reserved.
//

import UIKit
import Photos

class ImagesCollectionViewCell: UICollectionViewCell {
    
    var imageManager: PHImageManager?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageAsset: PHAsset? {
        didSet {
            self.imageManager?.requestImageForAsset(imageAsset!, targetSize: CGSize(width: 320, height: 320), contentMode: .AspectFill, options: nil) { image, info in
                self.photoImageView.image = image
            }
        }
    }
    
    

}
