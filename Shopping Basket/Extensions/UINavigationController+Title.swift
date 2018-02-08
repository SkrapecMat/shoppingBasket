//
//  UINavigationItem+title.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 08/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

extension UINavigationController {

    func setupTitle(withTitle title: String) {

        guard let font = UIFont.shopingBasketTitle(withSize: 18) else {
            return
        }

        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: font,
                                                  NSAttributedStringKey.foregroundColor: UIColor.titleColor]

        self.navigationBar.topItem?.title = title
    }
}

