//
//  YouTableViewCell.swift
//  layoutpractice
//
//  Created by shin seunghyun on 2020/03/22.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class YouTableViewCell: UITableViewCell {

    @IBOutlet weak var bubbleText: UILabel!
    @IBOutlet weak var profileimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileimage.layer.cornerRadius = profileimage.frame.width
        / 2;
        profileimage.clipsToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
