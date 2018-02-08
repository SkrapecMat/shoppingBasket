//
//  ProductRepositoryInMemory.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 07/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class InMemoryProductRepository: ProductRepository {

    private lazy var products: [Product] = self.initializeProducts()

    private let peasPrice: Decimal = 0.95
    private let eggsPrice: Decimal = 2.10
    private let milkPrice: Decimal = 1.3
    private let beansPrice: Decimal = 0.73


    func getAll() -> [Product] {
        return products
    }

    func total() -> Int {
        return products.count
    }

    private func initializeProducts() -> [Product] {
        var productsList: [Product] = []

        let peasProduct = Product(withName: NSLocalizedString("PRODUCT_NAME__PEAS", comment: ""),
                                  price: Money(currency: Currency.default, amount: peasPrice),
                                  image: #imageLiteral(resourceName: "peas_image"))
        productsList.append(peasProduct)

        let eggsProduct = Product(withName: NSLocalizedString("PRODUCT_NAME__EGGS", comment: ""),
                              price: Money(currency: Currency.default, amount: eggsPrice),
                              image: #imageLiteral(resourceName: "eggs_Image"))
        productsList.append(eggsProduct)

        let milkProduct = Product(withName: NSLocalizedString("PRODUCT_NAME__MILK", comment: ""),
                                  price: Money(currency: Currency.default, amount: milkPrice),
                                  image: #imageLiteral(resourceName: "milk_image"))
        productsList.append(milkProduct)

        let beansProduct = Product(withName: NSLocalizedString("PRODUCT_NAME__BEANS", comment: ""),
                                  price: Money(currency: Currency.default, amount: beansPrice),
                                  image: #imageLiteral(resourceName: "beans_image"))
        productsList.append(beansProduct)

        return productsList
    }
}
