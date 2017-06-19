//
//  UserWebViewController.swift
//  MindValleyDemo
//
//  Created by Lalithbabu Logeshwarrao on 19/06/2017.
//  Copyright © 2017 Payzak Financial Service. All rights reserved.
//

import UIKit

class UserWebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var userWebView: UIWebView!

    var userName = String()
    var userLink = String()
    
    let reachability = Reachability()!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.topItem?.title = userName
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
}
    func InternetChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            let userURLString = userLink
            let userURL = URL(string: userURLString)
            let urlRequest = URLRequest(url: userURL!)
            userWebView.loadRequest(urlRequest)

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
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        DispatchQueue.main.async {
            
            self.alert(message: error.localizedDescription)
        }
    }

}
