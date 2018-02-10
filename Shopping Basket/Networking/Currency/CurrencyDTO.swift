//
//  CurrencyDTO.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 10/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import Foundation

class CurrencyDTO: Codable {
    let terms: String
    let privacy: String
    let currencies: [String: String]
}
