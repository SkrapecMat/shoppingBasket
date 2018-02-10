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
    let amount: Decimal

    func add(_ money: Money) -> Money {
        if money.currency.isoCode == self.currency.isoCode {
            return Money(currency: currency,
                         amount: amount + money.amount)
        }
        return money
    }

    func subtract(_ money: Money) -> Money {
        if money.currency.isoCode == self.currency.isoCode {
            return Money(currency: currency,
                         amount: amount - money.amount)
        }
        return money
    }

    func multiply(by multiplier: Int) -> Money {
        return Money(currency: currency,
                     amount: amount * Decimal(multiplier))
    }

    func convert(to currency: Currency,
                          withConversionRate rate: Decimal) -> Money {
        return Money(currency: currency,
                     amount: amount * rate)
    }

    func equalsZero() -> Bool {
        return amount == 0
    }
}
