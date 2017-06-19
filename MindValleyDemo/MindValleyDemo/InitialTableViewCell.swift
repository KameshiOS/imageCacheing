//
//  InitialTableViewCell.swift
//  MindValleyDemo
//
//  Created by Lalithbabu Logeshwarrao on 19/06/2017.
//  Copyright © 2017 Payzak Financial Service. All rights reserved.
//

import UIKit

class InitialTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: ImageViewDesign!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileUserID: UILabel!
    @IBOutlet weak var thumbImage: ImageViewDesign!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var timeAgoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
