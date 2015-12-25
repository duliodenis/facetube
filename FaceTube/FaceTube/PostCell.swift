//
//  PostCell.swift
//  FaceTube
//
//  Created by Dulio Denis on 12/21/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import UIKit
import Alamofire


class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var showcaseImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    var post: Post!
    var request: Request?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func drawRect(rect: CGRect) {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        showcaseImage.clipsToBounds = true
    }

    
    func configureCell(post: Post, image: UIImage?) {
        self.post = post
        self.descriptionText.text = post.postDescription
        self.likesLabel.text = "\(post.likes)"
        
        if post.imageURL != nil {
            if image != nil {   // there was one in the cache
                self.showcaseImage.image = image
            } else {            // otherwise make a request
                
                request = Alamofire.request(.GET, post.imageURL!).validate(contentType: ["image/*"]).response(completionHandler: {
                    request, response, data, error in
                    
                    if error == nil {
                        let image = UIImage(data: data!)!
                        self.showcaseImage.image = image
                        // Cache the image for performance
                        FeedVC.imageCache.setObject(image, forKey:self.post.imageURL!)
                    }
                })
            }
        } else {                // there is no URL at all.
            self.showcaseImage.hidden = true
        }
    }
}
