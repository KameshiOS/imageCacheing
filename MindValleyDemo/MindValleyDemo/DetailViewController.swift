//
//  DetailViewController.swift
//  MindValleyDemo
//
//  Created by Lalithbabu Logeshwarrao on 19/06/2017.
//  Copyright © 2017 Payzak Financial Service. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailThumb: ImageViewDesign!
    @IBOutlet weak var detailsLikeButton: UIButton!
    @IBOutlet weak var detailsLikeLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var detailsProfileImage: ImageViewDesign!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsUserIDLabel: UILabel!
    @IBOutlet weak var detailsDescription: TextViewDesign!
    @IBOutlet weak var userDetailView: ViewDesign!
    
    
    var getProfileImage = UIImage()
    var getThumbImage = UIImage()
    var getProfileName = String()
    var getProfileNameID = String()
    var getLikeStatus = Int64()
    var getLikes = NSInteger()
    var getTimeAgo = String()
    var getUserURL = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailThumb.image = getThumbImage
        detailsProfileImage.image = getProfileImage
        detailsNameLabel.text = getProfileName
        detailsUserIDLabel.text = getProfileNameID
        if getLikeStatus == 1 {
            detailsLikeButton.setBackgroundImage(UIImage(named: "likePink"), for: .normal)
        } else if getLikeStatus == 0 {
            detailsLikeButton.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }
        detailsLikeLabel.text = "\(getLikes)"
        timeAgoLabel.text = getTimeAgo
       
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(gotoUserDetails))
        self.userDetailView.addGestureRecognizer(tap)
        
    }
    func gotoUserDetails() {
        UIView.animate(withDuration: 0.1, animations: {
            self.userDetailView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (true) in
            UIView.animate(withDuration: 0.1, animations: {
                self.userDetailView.transform = CGAffineTransform.identity
            }, completion: { (true) in
                self.performSegue(withIdentifier: "toWeb", sender: nil)
            })
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeb" {
            let destVC = segue.destination as! UserWebViewController
            destVC.userName = detailsNameLabel.text!
            destVC.userLink = getUserURL
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LikeButtonAction(_ sender: UIButton) {
        if getLikeStatus == 0 {
            getLikeStatus = 1
            getLikes += 1

            UIView.animate(withDuration: 0.6, animations: { 
                sender.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.detailsLikeButton.setBackgroundImage(UIImage(named: "likePink"), for: .normal)
            }, completion: { _ in
                UIView.animate(withDuration: 0.6, animations: { 
                    sender.transform = CGAffineTransform.identity
                })
            })
        } else if getLikeStatus == 1 {
            getLikeStatus = 0
            getLikes -= 1
            self.detailsLikeButton.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }
            detailsLikeLabel.text = "\(getLikes)"
    }
    @IBAction func ShareButtonAction(_ sender: Any) {
        var shareImage = UIImage()
        shareImage = getThumbImage
        let imageToShare = [shareImage]
        
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func DownloadButtonAction(_ sender: UIButton) {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let saveImage: UIImage = detailThumb.image!
        let imageData = UIImageJPEGRepresentation(saveImage, 1)
        fileManager.createFile(atPath: paths[0], contents: imageData, attributes: nil)
    }
    
    
}
