//
//  MaterialButton.swift
//  FaceTube
//
//  Created by Dulio Denis on 12/9/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 4.0
        layer.shadowColor = UIColor(red: BUTTON_SHADOW_COLOR, green: BUTTON_SHADOW_COLOR, blue: BUTTON_SHADOW_COLOR, alpha: 0.7).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }

}
