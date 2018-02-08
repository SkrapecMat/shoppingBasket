//
//  UIFont+Type.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 08/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//
import UIKit

extension UIFont {
    class func shopingBasketRegular(withSize size: CGFloat) -> UIFont? {
        return UIFont.init(name: "Avenir Book", size: size)
    }

    class func shopingBasketTitle(withSize size: CGFloat) -> UIFont? {
        return UIFont.init(name: "Marker Felt", size: size)
    }
}
