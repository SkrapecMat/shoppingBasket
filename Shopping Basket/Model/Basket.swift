//
//  Basket.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

struct Basket {
    private(set) var totalPriceInUSDollars: Money

    private var items: [LineItem] = []
}
