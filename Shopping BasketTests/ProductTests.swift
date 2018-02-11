//
//  ProductTests.swift
//  Shopping BasketTests
//
//  Created by Mateja Škrapec on 11/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import XCTest

@testable import Shopping_Basket

class ProductTests: XCTestCase {

    func testIfTwoDifferentUUIDsWillBeAssignedToProductsWhenInitalized() {
        let productPrice = Money(currency: Currency.default,
                                 amount: Decimal(10.08))
        let firstProduct = Product(withName: "first",
                                   price: productPrice, image: nil)
        let secondProduct = Product(withName: "second",
                                   price: productPrice, image: nil)

        XCTAssertNotEqual(firstProduct.uuid, secondProduct.uuid)
    }
}

