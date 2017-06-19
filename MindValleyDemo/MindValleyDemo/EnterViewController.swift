//
//  EnterViewController.swift
//  MindValleyDemo
//
//  Created by Lalithbabu Logeshwarrao on 19/06/2017.
//  Copyright © 2017 Payzak Financial Service. All rights reserved.
//

import UIKit

class EnterViewController: UIViewController {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var enterButton: ButtonDesign!
    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bgImageView.alpha = 0
        footerLabel.alpha = 0
        enterButton.alpha = 0
        describeLabel.alpha = 0
        titleLabel.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: { 
            self.bgImageView.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 1, animations: { 
                self.titleLabel.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 1, animations: { 
                    self.describeLabel.alpha = 1
                }, completion: { (true) in
                    UIView.animate(withDuration: 1, animations: { 
                        self.enterButton.alpha = 1
                        self.footerLabel.alpha = 1
                    }, completion: nil)
                })
            })
        }
    }
    //self.performSegue(withIdentifier: "proceed", sender: nil)
    @IBAction func EnterButtonAction(_ sender: UIButton) {
       UIView.animate(withDuration: 0.1, animations: {
        self.enterButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
       }) { (true) in
        UIView.animate(withDuration: 0.1, animations: {
            self.enterButton.transform = CGAffineTransform.identity
        }, completion: { (true) in
            self.performSegue(withIdentifier: "proceed", sender: nil)
        })
        }
    }

}
