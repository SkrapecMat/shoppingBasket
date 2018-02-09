//
//  Basket.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

class Basket {
    private(set) var totalPriceInUSDollars: Money = Money(currency: Currency.default,
                                                     amount: 0)
    private var selectedItems: [LineItem] = []

    // MARK: Public
    func add(product: Product) -> Int {
        var totalAmount = 1
        if let lineItem = selectedItems.first(where: {product.uuid == $0.product.uuid}) {
            //if line item is in basket, increase amount
            totalAmount = lineItem.amount + 1
            lineItem.amount = totalAmount
        } else {
            //create new line item
            selectedItems.append(LineItem(with: product, amount: totalAmount))
        }

        return totalAmount
    }

    func remove(product: Product) -> Int {
        var totalAmount = 0
        if let lineItem = selectedItems.first(where: {product.uuid == $0.product.uuid}) {
            //if line item is in basket, decrease amount
            totalAmount = lineItem.amount - 1
            if totalAmount > 0 {
                lineItem.amount = totalAmount
            } else {
                totalAmount = 0
            }
        }

        return totalAmount
    }

    func getTotalAmountOfProduct(_ product: Product) -> Int {
        if let lineItem = selectedItems.first(where: {product.uuid == $0.product.uuid}) {
            return lineItem.amount
        }
        return 0
    }
}
