//
//  PreviewViewController.swift
//  GigglyGallery
//
//  Created by Saqib Omer on 9/30/15.
//  Copyright © 2015 Kaboom Labs. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    // Properties
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    var index : Int?
    var image : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        print(image)
        previewImageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func dismissViewAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
