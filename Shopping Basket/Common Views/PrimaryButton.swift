//
//  PrimaryButton.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 10/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {

    @IBInspectable var localizedStringKey: String = "" {
        didSet {
            let text = NSLocalizedString(localizedStringKey, comment: "")
            self.setTitle(text, for: .normal)
        }
    }

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = UIColor.titleColor
            } else {
                self.backgroundColor = UIColor.secondaryTextColor
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10.0
    }
}
