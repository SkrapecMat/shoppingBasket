//
//  Moeny+toString.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 08/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

extension Money {
    func toString() -> String? {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .up
        formatter.minimumIntegerDigits = 1

        if let roundedPrice = formatter.string(from:
            NSDecimalNumber(decimal: self.amount)) {
            return "\(roundedPrice) \(self.currency.isoCode)"
        }

        return nil
    }
}
