//
//  ProductTableViewCell.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productAmountTextField: UITextField!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var removeProductButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func tappedAddOneItem(_ sender: Any) {
    }


    @IBAction func tappedRemoveOneItem(_ sender: Any) {
    }

    @IBAction func tappedRemoveProduct(_ sender: Any) {
    }

    // MARK: Public
    func configure(with viewModel: ProductTableViewCellViewModel) {
        productImageView.image = viewModel.image
        productNameLabel.text = viewModel.name
        productPriceLabel.text = viewModel.price
        productAmountTextField.text = "\(viewModel.amount)"
    }
}
