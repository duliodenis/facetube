//
//  PostCell.swift
//  FaceTube
//
//  Created by Dulio Denis on 12/21/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var showcaseImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func drawRect(rect: CGRect) {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        showcaseImage.clipsToBounds = true
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
