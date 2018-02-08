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
    var amount: Int = 0
    let image: UIImage?

    init(_ product: Product) {
        self.name = product.name
        self.image = product.image
        self.price = "\(product.price.amount) \(product.price.currency.isoCode)"
    }
}
