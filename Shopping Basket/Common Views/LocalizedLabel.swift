//
//  LocalizedLabel.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 10/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class LozalizedLabel: UILabel {

    @IBInspectable var localizedStringKey: String {
        get {
            return self.text ?? ""
        }
        set(value) {
            self.text = NSLocalizedString(value, comment: "")
        }
    }
}
