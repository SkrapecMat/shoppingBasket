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

        totalPriceInUSDollars = totalPriceInUSDollars.add(product.price)
        return totalAmount
    }

    func remove(product: Product) -> Int {
        var totalAmount = 0
        if let lineItem = selectedItems.first(where: {product.uuid == $0.product.uuid}) {
            if lineItem.amount == 0 {
                return totalAmount
            }
            //if line item is in basket, decrease amount
            totalAmount = lineItem.amount - 1

            //if amount is 0, remove whole line item
            if totalAmount == 0 {
                removeLineItem(ofProduct: product)
            } else {
                lineItem.amount = totalAmount
                totalPriceInUSDollars = totalPriceInUSDollars.subtract(product.price)
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

    func getProductsInBasket() -> [Product] {
        return selectedItems.map({ return $0.product })
    }

    func removeLineItem(ofProduct product: Product) {
        selectedItems = selectedItems.filter({ $0.product.uuid != product.uuid })
        totalPriceInUSDollars = calculateTotalPrice()
    }

    // MARK: Private methods

    private func calculateTotalPrice() -> Money {
        var sum = Money(currency: Currency.default, amount: 0)
        for item in selectedItems {
            let productPrice = item.product.price
            let newPrice = productPrice.multiply(by: item.amount)
            sum = sum.add(newPrice)
        }

        return sum
    }
}
