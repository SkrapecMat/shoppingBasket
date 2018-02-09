//
//  Money.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

struct Money {
    let currency: Currency
    var amount: Decimal

    mutating func add(_ money: Money) {
        if money.currency.isoCode == self.currency.isoCode {
            amount += money.amount
        }
    }

    mutating func subtract(_ money: Money) {
        if money.currency.isoCode == self.currency.isoCode {
            amount -= money.amount
        }
    }
}
