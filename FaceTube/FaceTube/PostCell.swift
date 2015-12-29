//
//  PostCell.swift
//  FaceTube
//
//  Created by Dulio Denis on 12/21/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var showcaseImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    var post: Post!
    var request: Request?
    
    var likeReference: Firebase!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add a one tap gesture recognizer on the like image
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:")
        tap.numberOfTapsRequired = 1
        likeImage.addGestureRecognizer(tap)
        likeImage.userInteractionEnabled = true
    }
    
    
    override func drawRect(rect: CGRect) {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        showcaseImage.clipsToBounds = true
    }

    
    func configureCell(post: Post, image: UIImage?) {
        self.post = post
        
        likeReference = DataService.ds.REF_CURRENT_USER.childByAppendingPath("likes").childByAppendingPath(post.postKey)
        
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
                    } else {
                        print(error.debugDescription)
                    }
                })
            }
        } else {                // there is no URL at all.
            self.showcaseImage.hidden = true
        }
        
        likeReference.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                // This user has not liked this post
                self.likeImage.image = UIImage(named: "heart-empty")
            } else {
                // This user has liked this post already
                self.likeImage.image = UIImage(named: "heart-full")
            }
        })
    }
    
    
    // MARK: Tap Gesture Recognizer function
    func likeTapped(sender: UITapGestureRecognizer) {
        likeReference.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                // This user has not liked this post - then like it
                self.likeImage.image = UIImage(named: "heart-full")
                self.post.updateLikes(true)
                self.likeReference.setValue(true)
                
            } else {
                // This user has liked this post already - unlike it
                self.likeImage.image = UIImage(named: "heart-empty")
                self.post.updateLikes(false)
                self.likeReference.removeValue()
            }
        })
    }
}
