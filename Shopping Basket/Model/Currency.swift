//
//  Currency.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

struct Currency {
    let name: String
    let isoCode: String

    static var `default`: Currency {
        return Currency(name: "United States Dollar", isoCode: "USD")
    }
}
