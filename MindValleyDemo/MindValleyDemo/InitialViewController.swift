//
//  InitialViewController.swift
//  MindValleyDemo
//
//  Created by Lalithbabu Logeshwarrao on 19/06/2017.
//  Copyright © 2017 Payzak Financial Service. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var InitialTableView: UITableView!
    
    var category: [AnyObject] = []
    var color: [AnyObject] = []
    var createdAtTime: [AnyObject] = []
    var height :[AnyObject] = []
    var width: [AnyObject] = []
    var id: [AnyObject] = []
    var likedByUser: [AnyObject] = []
    var likes: [NSInteger] = []
    var links: [AnyObject] = []
    var urls: [AnyObject] = []
    var users: [AnyObject] = []
    var name: [String] = []
    var username: [String] = []
    //  var profileImageURL: [AnyObject] = []
    var profileLarge: [String] = []
    var profileMedium: [String] = []
    var profileSmall: [String] = []
    // Thumbnail Image Url
    var fullImage: [String] = []
    var rawImage: [String] = []
    var regularImage: [String] = []
    var smallImage: [String] = []
    var thumbImage: [String] = []
    var userURL: [String] = []
    // Posting on another viewcontroller from tableviewcell
    var postProfileImage = UIImage()
    var postThumbImage = UIImage()
    var postName = String()
    var postNameID = String()
    var postLikedByUser = Int64()
    var postLikes = NSInteger()
    var postTimeAgo = String()
    var postUserURL = String()
    
    let reachability = Reachability()!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
            }
            self.reachability.whenUnreachable = { _ in
                DispatchQueue.main.async {
                    self.alert(message: "No Network Connection")
                }
            }
            
        }
        NotificationCenter.default.addObserver(self, selector: #selector(InternetChanged(note:)), name: ReachabilityChangedNotification, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Could Not Start Notifier")
        }

       refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.black
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSForegroundColorAttributeName: UIColor.black])
        self.refreshControl.addTarget(self, action: #selector(refreshPage), for: UIControlEvents.valueChanged)
        self.InitialTableView.addSubview(self.refreshControl)
    }
    func refreshPage() {
        DispatchQueue.main.async {
            self.getMindValley()
        }
    }
    func InternetChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
             self.getMindValley()
        } else {
            DispatchQueue.main.async {
                self.alert(message: "No Network Connection")
            }
        }
    }
    func alert(message: String) {
        let alert = UIAlertController.init(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getMindValley() {
        let getUrl = URL(string: "http://pastebin.com/raw/wgkJgazE")
        var request = URLRequest(url: getUrl!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.alert(message: (error?.localizedDescription)!)
                }
            } else {
                do {
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [AnyObject]
                    if myJSON.count > 0 {
                        
                        self.category = []
                        self.color = []
                        self.createdAtTime = []
                        self.height = []
                        self.width = []
                        self.id = []
                        self.likedByUser = []
                        self.likes = []
                        self.links = []
                        self.urls = []
                        self.users = []
                        
                        
                        for value in myJSON {
                            self.category.append(value["categories"] as AnyObject)
                            self.color.append(value["color"] as AnyObject)
                            self.createdAtTime.append(value["created_at"] as AnyObject)
                            self.height.append(value["height"] as AnyObject)
                            self.width.append(value["width"] as AnyObject)
                            self.id.append(value["id"] as AnyObject)
                            self.likedByUser.append(value["liked_by_user"] as AnyObject)
                            self.likes.append(value["likes"] as! NSInteger)
                            self.links.append(value["links"] as AnyObject)
                            self.urls.append(value["urls"] as AnyObject)
                            self.users.append(value["user"] as AnyObject)
                        }
                        
                        self.name = []
                        self.username = []
                        self.profileLarge = []
                        self.profileMedium = []
                        self.profileSmall = []
                        
                        var links: [AnyObject] = []
                        for user in self.users {
                            self.name.append(user["name"] as! String)
                            self.username.append(user["username"] as! String)
                            let imageURL = user["profile_image"] as AnyObject
                            self.profileLarge.append(imageURL["large"] as! String)
                            self.profileMedium.append(imageURL["medium"] as! String)
                            self.profileSmall.append(imageURL["small"] as! String)
                            
                            links.append(user["links"] as AnyObject)
                        }
                        
                        for link in links {
                            self.userURL.append(link["html"] as! String)
                        }
                        
                        self.fullImage = []
                        self.rawImage = []
                        self.regularImage = []
                        self.smallImage = []
                        self.thumbImage = []
                        for imageURL in self.urls {
                            self.fullImage.append(imageURL["full"] as! String)
                            self.rawImage.append(imageURL["raw"] as! String)
                            self.regularImage.append(imageURL["regular"] as! String)
                            self.smallImage.append(imageURL["small"] as! String)
                            self.thumbImage.append(imageURL["thumb"] as! String)
                        }
                        DispatchQueue.main.async {
                            self.refreshControl.endRefreshing()
                            self.InitialTableView.reloadData()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.alert(message: "No Record")
                            self.refreshControl.endRefreshing()
                            self.InitialTableView.reloadData()
                        }
                    }
                    
                } catch let err as NSError {
                    print(err)
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing()
                        self.alert(message: err.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InitialTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.profileName.text = self.name[indexPath.row]
        cell.profileUserID.text = "@\(self.username[indexPath.row])"
        cell.likesLabel.text = "\(self.likes[indexPath.row])"
        
        let profile = cell.viewWithTag(1) as! UIImageView
        profile.sd_setImage(with: URL(string: profileLarge[indexPath.row]))
        
        let thumb = cell.viewWithTag(2) as! UIImageView
        thumb.sd_setImage(with: URL(string: fullImage[indexPath.row]))
        
        
        if self.likedByUser[indexPath.row].int64Value == 0 {
            cell.likeButton.setBackgroundImage(UIImage(named: "like"), for: .normal)
        } else if self.likedByUser[indexPath.row].int64Value == 1 {
            cell.likeButton.setBackgroundImage(UIImage(named: "likePink"), for: .normal)
        }
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonAction(sender:)), for: .touchUpInside)
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(shareButtonAction(sender:)), for: .touchUpInside)
        
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let yourDate: Date = dateFor.date(from: self.createdAtTime[indexPath.row] as! String)!
        cell.timeAgoLabel.text = "Posted \(yourDate.timeAgo())"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InitialTableViewCell
       
            postName = name[indexPath.row]
            postNameID = "@\(username[indexPath.row])"
            
            let profileView = UIImageView()
            profileView.sd_setImage(with: URL(string: profileLarge[indexPath.row]))
        postProfileImage = profileView.image!
            
            let thumbView = UIImageView()
            thumbView.sd_setImage(with: URL(string: fullImage[indexPath.row]))
        postThumbImage = thumbView.image!
        
        postLikedByUser = likedByUser[indexPath.row].int64Value
        postLikes = likes[indexPath.row]
        
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let yourDate: Date = dateFor.date(from: self.createdAtTime[indexPath.row] as! String)!
        postTimeAgo = yourDate.timeAgo()
        postUserURL = userURL[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: nil)
                
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let destVC = segue.destination as! DetailViewController
            destVC.getProfileImage = postProfileImage
            destVC.getThumbImage = postThumbImage
            destVC.getProfileName = postName
            destVC.getProfileNameID = postNameID
            destVC.getLikeStatus = postLikedByUser
            destVC.getLikes = postLikes
            destVC.getTimeAgo = postTimeAgo
            destVC.getUserURL = postUserURL
        }
     }
    func shareButtonAction(sender: UIButton) {
        
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: fullImage[sender.tag]))
        let imageToShare = [ imageView.image! ] as [Any]
        
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    func likeButtonAction(sender: UIButton) {
        let likeButtonTag = sender.tag
        if self.likedByUser[sender.tag].int64Value == 0 {
            self.likedByUser[sender.tag] = 1 as AnyObject
            UIView.animate(withDuration: 0.6, animations: {
                sender.transform = CGAffineTransform(scaleX: 1.5 , y: 1.5)
            }, completion: { _ in
                UIView.animate(withDuration: 0.6, animations: {
                    sender.transform = CGAffineTransform.identity
                })
            })
            self.likes[sender.tag] += 1
        } else if self.likedByUser[sender.tag].int64Value == 1 {
            self.likedByUser[sender.tag] = 0 as AnyObject
            self.likes[sender.tag] -= 1
        }
        DispatchQueue.main.async {
            self.InitialTableView.reloadData()
        }
    }

}
extension Date {
    func timeAgo() -> String {
        
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let year = 52 * week
        
        if secondsAgo < minute {
            if secondsAgo == 1 {
                return "\(secondsAgo) seconds ago"
            } else {
                return "\(secondsAgo) seconds ago"
            }
        } else if secondsAgo < hour {
            if secondsAgo / minute == 1 {
                return "\(secondsAgo / minute) min ago"
            } else {
                return "\(secondsAgo / minute) mins ago"
            }
        } else if secondsAgo < day {
            if secondsAgo / hour == 1 {
                return "\(secondsAgo / hour) hour ago"
            } else {
                return "\(secondsAgo / hour) hours ago"
            }
        } else if secondsAgo < week {
            if secondsAgo / day == 1 {
                return "\(secondsAgo / day) day ago"
            } else {
                return "\(secondsAgo / day) days ago"
            }
        } else if secondsAgo < year {
            if secondsAgo / week == 1 {
                return "\(secondsAgo / week) week ago"
            } else {
                return "\(secondsAgo / week) weeks ago"
            }
        }
        if secondsAgo / year == 1 {
            return "\(secondsAgo / year) year ago"
        } else {
            return "\(secondsAgo / year) years ago"
        }
    }
}

