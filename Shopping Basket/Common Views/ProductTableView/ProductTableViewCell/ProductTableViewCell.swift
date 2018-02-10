//
//  ProductTableViewCell.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

protocol ProductTableViewCellDelegate: class {
    func addOneItem(_ sender: ProductTableViewCell)
    func removeOneItem(_ sender: ProductTableViewCell)
    func removeProduct(_ sender: ProductTableViewCell)
}

//to make removeProduct optional to implement
//without having to use @objc on the delegate
extension ProductTableViewCellDelegate {
    func removeProduct(_ sender: ProductTableViewCell) {}
}

class ProductTableViewCell: UITableViewCell {

    weak var delegate: ProductTableViewCellDelegate?

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productAmountTextField: UITextField!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var removeProductButton: UIButton!
    @IBOutlet weak var contentWrapperView: UIView!

    // MARK: Constants

    private let kWrapperShadowHeight: CGFloat = 4.0
    private let kWrapperShadowOpacity: Float = 0.2

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowToWrapperView()
    }

    // MARK: UI methods

    private func addShadowToWrapperView() {
        contentWrapperView.layer.shadowColor = UIColor.secondaryTextColor.cgColor
        contentWrapperView.layer.shadowOffset = CGSize(width: 0.0,
                                                       height: kWrapperShadowHeight)
        contentWrapperView.layer.shadowOpacity = kWrapperShadowOpacity
        contentWrapperView.layer.shadowRadius = kWrapperShadowHeight
    }

    // MARK: Actions

    @IBAction func tappedAddOneItem(_ sender: Any) {
        delegate?.addOneItem(self)
    }

    @IBAction func tappedRemoveOneItem(_ sender: Any) {
        delegate?.removeOneItem(self)
    }

    @IBAction func tappedRemoveProduct(_ sender: Any) {
        delegate?.removeProduct(self)
    }

    // MARK: Public
    func configure(with viewModel: ProductTableViewCellViewModel) {
        productImageView.image = viewModel.image
        productNameLabel.text = viewModel.name
        productPriceLabel.text = viewModel.price
        productAmountTextField.text = viewModel.totalAmount
        removeProductButton.isHidden = !viewModel.canRemoveProductFromList
    }

    func setProductAmount(_ amount: Int) {
        productAmountTextField.text = "\(amount)"
    }
}
