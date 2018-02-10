//
//  NavItemTitleView.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 09/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class NavItemTitleView: UIView {

    private let titleRect = CGRect(x: 0, y: 0,
                                   width: 150.0,
                                   height: 40.0)

    init(withText text: String) {
        super.init(frame: titleRect)
        setupTitle(text)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTitle(_ text: String) {
        guard let font = UIFont.shopingBasketTitle(withSize: 18) else {
            return
        }

        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font: font,
                                                         NSAttributedStringKey.foregroundColor: UIColor.titleColor]
        let textLabel = UILabel(frame: titleRect)
        textLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
        textLabel.textAlignment = .center
        self.addSubview(textLabel)
    }

    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
}
