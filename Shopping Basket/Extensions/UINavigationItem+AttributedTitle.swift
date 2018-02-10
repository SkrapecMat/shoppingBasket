//
//  UINavigationItem+title.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 08/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

extension UINavigationItem {

    func setupTitle(withText text: String) {
        let navTitleView = NavItemTitleView(withText: text)
        self.titleView = navTitleView
    }
}

