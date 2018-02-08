//
//  Basket.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

class Basket {
    private(set) var totalPriceInUSDollars: Money = Money(currency: Currency.default,
                                                          amount: 0)
    private var selectedItems: [LineItem] = []
}
