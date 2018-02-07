//
//  CurrencyDTO.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 07/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

class CurrencyDTO: Codable {
    let currencies: [String:String]

    func mapToCurrencyList() -> [Currency] {
        return currencies.map{ (isoCode, name) in
            return Currency(name: name, isoCode: isoCode)
        }
    }
}
