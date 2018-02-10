//
//  ProductTableViewCellViewModel.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

struct ProductTableViewCellViewModel {
    let name: String
    let price: String
    let image: UIImage?
    let totalAmount: String
    let canRemoveProductFromList: Bool

    init(_ product: Product, totalAmount: Int,
         canRemoveProductFromList: Bool) {
        self.name = product.name
        self.image = product.image
        self.price = "\(product.price.amount) \(product.price.currency.isoCode)"
        self.totalAmount = "\(totalAmount)"
        self.canRemoveProductFromList = canRemoveProductFromList
    }
}
