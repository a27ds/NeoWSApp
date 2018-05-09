//
//  PictureOfTheDayViewController.swift
//  NeoWSApp
//
//  Created by Peter Karlsson on 2018-05-07.
//  Copyright © 2018 a27. All rights reserved.
//
import UIKit
import SVProgressHUD

class PictureOfTheDayViewController: UIViewController {

    @IBOutlet weak var titleOfPOD: UILabel!
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    // KEY
    let nasaKey = "mxYfugT2OQg976YfLCiansy1TbqxmdhdqGDb2P37"
    // API
    let POD = "https://api.nasa.gov/planetary/apod?api_key="
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector: #selector(waitForFetchImage(notification:)), name: .doneParsingImageURL, object: nil)
        
        let getImageInfo = FetchData()
        getImageInfo.fetchDataImage(url: "\(POD)\(nasaKey)")
        
    }
    
    // NOTIFICATION
    @objc func waitForFetchImage(notification: NSNotification) {
        showImage()
        SVProgressHUD.dismiss()
    }
    
    func showImage(){
        titleOfPOD.text = PODImage.imageTitle
        
        let url = URL(string: PODImage.imageUrl)
    
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.pictureImageView.image = UIImage(data: data!)
            }
        }
    }
}
