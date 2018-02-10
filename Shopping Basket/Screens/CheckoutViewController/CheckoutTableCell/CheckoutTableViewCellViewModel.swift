//
//  CheckoutTableViewCellViewModel.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 10/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//
struct CheckoutTableViewCellViewModel {
    let name: String
    let isoCode: String

    init(_ currency: Currency) {
        name = currency.name
        isoCode = currency.isoCode
    }
}
