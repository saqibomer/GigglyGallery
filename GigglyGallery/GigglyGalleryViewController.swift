//
//  GigglyGalleryViewController.swift
//  GigglyGallery
//
//  Created by Saqib Omer on 9/30/15.
//  Copyright © 2015 Kaboom Labs. All rights reserved.
//

import UIKit
import Photos //Import Photos framework

class GigglyGalleryViewController: UIViewController, PHPhotoLibraryChangeObserver, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Properties
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
//    var assetCollections: PHFetchResult!
    var images: PHFetchResult!
    let imageManager = PHCachingImageManager()
    var imageCacheController: ImageCacheController!
    
    var selectedImage : UIImage?
    var selectedIndex : Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        images = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        imageCacheController = ImageCacheController(imageManager: imageManager, images: images, preheatSize: 1)
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
//        if segue.identifier == "previewSegue"{
//        
//        let vc = segue.destinationViewController as! PreviewViewController
//            if let image = selectedImage {
//                vc.previewImageView.image = image
//            }
//        }
        print(selectedIndex)
    }



    
    // MARK: - CollectionView DataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imagesCell", forIndexPath: indexPath) as! ImagesCollectionViewCell
        
        // Configure the cell
        cell.imageManager = imageManager
        cell.imageAsset = images[indexPath.item] as? PHAsset
        
        return cell
        
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ImagesCollectionViewCell
        
        selectedImage = cell.photoImageView.image
        print(selectedImage)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("previewController") as! PreviewViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        vc.image = selectedImage
        vc.index = indexPath.item
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // MARK: - CollectionView FlowDelegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: self.imagesCollectionView.frame.width / 3, height: self.imagesCollectionView.frame.width / 3)
    }
    
    // MARK: - ScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let indexPaths = imagesCollectionView?.indexPathsForVisibleItems()
        imageCacheController.updateVisibleCells(indexPaths as [NSIndexPath]!)
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange) {
        let changeDetails = changeInstance.changeDetailsForFetchResult(images)
        
        self.images = changeDetails!.fetchResultAfterChanges
        dispatch_async(dispatch_get_main_queue()) {
            // Loop through the visible cell indices
            let indexPaths = self.imagesCollectionView.indexPathsForVisibleItems()
            for indexPath in indexPaths as [NSIndexPath]! {
                if changeDetails!.changedIndexes!.containsIndex(indexPath.item) {
                    let cell = self.imagesCollectionView?.cellForItemAtIndexPath(indexPath) as! ImagesCollectionViewCell
                    cell.imageAsset = changeDetails!.fetchResultAfterChanges[indexPath.item] as? PHAsset
                }
            }
        }
    }
    

}
