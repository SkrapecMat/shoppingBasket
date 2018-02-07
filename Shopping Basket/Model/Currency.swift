//
//  Currency.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

struct Currency {
    let name: String
    let isoCode: String

    static var `default`: Currency {
        return Currency(name: NSLocalizedString("DEFAULT_CURRENCY_NAME", comment: ""),
                        isoCode: NSLocalizedString("DEFAULT_CURRENCY_ISO", comment: ""))
    }
}
