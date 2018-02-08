//
//  UITableViewCell+Identifier.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 07/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
}
