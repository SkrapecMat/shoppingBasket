//
//  LineItem.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 07/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

class LineItem {
    let product: Product
    var amount: Int = 0

    init(with product: Product) {
        self.product = product
    }
}
