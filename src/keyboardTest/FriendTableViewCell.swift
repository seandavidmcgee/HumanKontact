//
//  FriendTableViewCell.swift
//  NFTopMenuController
//
//  Created by Niklas Fahl on 12/17/14.
//  Copyright (c) 2014 Niklas Fahl. All rights reserved.
//

import UIKit
var openMenu = 0.0
class FriendTableViewCell: UITableViewCell {
    @IBOutlet var facetimeLabel: UILabel!
    @IBOutlet var mailLabel: UILabel!
    @IBOutlet var mobiletextLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneAction: UIButton!
    @IBOutlet var textAction: UIButton!
    @IBOutlet var mailAction: UIButton!
    @IBOutlet var facetimeAction: UIButton!
    
    @IBAction func quickActions(sender: UIButton) {
        let fullRotation = CGFloat(1.55)
        let reverseRotation = CGFloat(0)
        let duration = 0.33
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModeLinear
        
        if (openMenu == 0.0) {
            UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: {
                // start at 0.00s
                // duration 0.33s
                // end at   0.67s
                    sender.transform = CGAffineTransformMakeRotation(1/3 * fullRotation)
                })
                    UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
                        sender.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
                })
                    UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
                    sender.transform = CGAffineTransformMakeRotation(3/3 * fullRotation)
                })
                openMenu = 1.0
                }, completion: {finished in UIView.animateWithDuration(0.5, animations: {
                        self.phoneAction.hidden = false
                        self.phoneLabel.hidden = false
                        self.textAction.hidden = false
                        self.mobiletextLabel.hidden = false
                        self.mailAction.hidden = false
                        self.mailLabel.hidden = false
                        self.facetimeAction.hidden = false
                        self.facetimeLabel.hidden = false
                    })
                })
                UIView.animateWithDuration(0.5, animations: {
                    self.sourceLabel.transform = CGAffineTransformMakeTranslation(-180, 0)
                    self.photoImageView.transform = CGAffineTransformMakeTranslation(-180, 0)
                    self.nameLabel.transform = CGAffineTransformMakeTranslation(-180, 0)
                })
            }
        else {
            UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
                // each keyframe needs to be added here
                // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
                
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: {
                    // start at 0.00s
                    // duration 0.33s
                    // end at   0.67s
                    sender.transform = CGAffineTransformMakeRotation(1/3 * reverseRotation)
                })
                UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
                    sender.transform = CGAffineTransformMakeRotation(2/3 * reverseRotation)
                })
                UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
                    sender.transform = CGAffineTransformMakeRotation(3/3 * reverseRotation)
                })
                openMenu = 0.0
                }, completion: {finished in
                    // any code entered here will be applied
                    // once the animation has completed
            })
            UIView.animateWithDuration(1.0, animations: {
                self.sourceLabel.transform = CGAffineTransformMakeTranslation(0, 0)
                self.photoImageView.transform = CGAffineTransformMakeTranslation(0, 0)
                self.nameLabel.transform = CGAffineTransformMakeTranslation(0, 0)
                self.phoneAction.hidden = true
                self.textAction.hidden = true
                self.mailAction.hidden = true
                self.facetimeAction.hidden = true
                self.phoneLabel.hidden = true
                self.mobiletextLabel.hidden = true
                self.mailLabel.hidden = true
                self.facetimeLabel.hidden = true
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
