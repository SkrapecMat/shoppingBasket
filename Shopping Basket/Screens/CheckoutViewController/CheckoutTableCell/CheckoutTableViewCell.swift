//
//  CheckoutTableViewCell.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 10/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var isoCurrencyLabel: UILabel!

    // MARK: Public
    func configure(withViewModel viewModel: CheckoutTableViewCellViewModel) {
        currencyNameLabel.text = "(\(viewModel.name))"
        isoCurrencyLabel.text = viewModel.isoCode
    }
}
