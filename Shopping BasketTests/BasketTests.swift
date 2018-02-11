//
//  BasketTests.swift
//  Shopping BasketTests
//
//  Created by Mateja Škrapec on 11/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import XCTest

@testable import Shopping_Basket

class BasketTests: XCTestCase {

    var basket: Basket!
    var testProduct: Product!

    override func setUp() {
        super.setUp()

        basket = Basket()

        let productPrice = Money(currency: Currency.default,
                                 amount: Decimal(10.08))
        testProduct = Product(withName: "TestProduct", price: productPrice,
                              image: nil)
    }

    override func tearDown() {
        super.tearDown()

        basket = nil
        testProduct = nil
    }

    // MARK: Adding one item to basket

    func testIfAddingFirstProductToBasketWillReturnCorrectTotalPriceAndAmout() {
        let totalProductAmount = basket.add(product: testProduct)

        XCTAssertEqual(totalProductAmount, 1)
        XCTAssertEqual(basket.totalPriceInUSDollars.amount,
                       testProduct.price.amount)
        XCTAssertEqual(basket.selectedItems.count, 1)
    }

    func testIfAddingDifferentProductToBasketWillReturnCorrectTotalPriceAndAmout() {
        let productPriceDecimal = Decimal(2.10)
        let productPrice = Money(currency: Currency.default,
                                 amount: productPriceDecimal)
        let product = Product(withName: "TestProduct2", price: productPrice,
                              image: nil)

        let _ = basket.add(product: testProduct)
        let totalProductAmount = basket.add(product: product)

        let totalPrice = testProduct.price.amount + productPriceDecimal
        XCTAssertEqual(totalProductAmount, 1)
        XCTAssertEqual(basket.totalPriceInUSDollars.amount, totalPrice)
        XCTAssertEqual(basket.selectedItems.count, 2)
    }

    func testIfAddingTheSameProductToBasketWillReturnCorrectTotalPriceAndAmout() {
        let _ = basket.add(product: testProduct)
        let _ = basket.add(product: testProduct)

        let totalPrice = testProduct.price.amount * 2

        XCTAssertEqual(basket.totalPriceInUSDollars.amount, totalPrice)
        XCTAssertEqual(basket.selectedItems.count, 1)
        XCTAssertEqual(basket.selectedItems[0].amount, 2)
    }

    // MARK: Remove one item from basket

    func testIfRemovingItemFromEmptyBasketWillReturnTotalPriceAndAmountZero() {
        let amount = basket.remove(product: testProduct)

        XCTAssertEqual(amount, 0)
        XCTAssertEqual(basket.totalPriceInUSDollars.amount, Decimal(0))
    }

    func testIfRemovingUnexistingItemFromBasketWillReturnTheSameTotalPrice() {
        let _ = basket.add(product: testProduct)

        let productPriceDecimal = Decimal(2.10)
        let productPrice = Money(currency: Currency.default,
                                 amount: productPriceDecimal)
        let product = Product(withName: "TestProduct2", price: productPrice,
                              image: nil)

        let amount = basket.remove(product: product)
        XCTAssertEqual(amount, 0)
        XCTAssertEqual(basket.totalPriceInUSDollars.amount,
                       testProduct.price.amount)
        XCTAssertEqual(basket.selectedItems.count, 1)
    }

    func testIfRemovingOneItemOfSameProductWillReturnCorrectTotalPriceAndAmount() {
        let _ = basket.add(product: testProduct)
        let _ = basket.add(product: testProduct)

        let amount = basket.remove(product: testProduct)

        XCTAssertEqual(amount, 1)
        XCTAssertEqual(basket.totalPriceInUSDollars.amount,
                       testProduct.price.amount)
        XCTAssertEqual(basket.selectedItems.count, 1)
    }

    func testIfRemovingLastItemOfTheSameProductWillRemoveWholeLineItem() {
        let _ = basket.add(product: testProduct)

        let amount = basket.remove(product: testProduct)

        XCTAssertEqual(amount, 0)
        XCTAssertEqual(basket.totalPriceInUSDollars.amount,
                       Decimal(0))
        XCTAssertEqual(basket.selectedItems.count, 0)
    }

    // MARK: Removing Line Item

    func testIfRemovingTheOnlyLineItemWillReturnCorrectTotalPriceAndAmount() {
        let _ = basket.add(product: testProduct)

        basket.removeLineItem(ofProduct: testProduct)

        XCTAssertEqual(basket.totalPriceInUSDollars.amount,
                       Decimal(0))
        XCTAssertEqual(basket.selectedItems.count, 0)
    }

    func testIfRemovingLineItemWithMultipleProductsWillReturnCorrectTotalPriceAndAmount() {
        let _ = basket.add(product: testProduct)
        let _ = basket.add(product: testProduct)

        basket.removeLineItem(ofProduct: testProduct)

        XCTAssertEqual(basket.totalPriceInUSDollars.amount,
                       Decimal(0))
        XCTAssertEqual(basket.selectedItems.count, 0)
    }

    func testIfRemovingNonExistingLineItemWillReturnCorrectTotalPriceAndAmount() {
        let _ = basket.add(product: testProduct)
        let productPriceDecimal = Decimal(2.10)
        let productPrice = Money(currency: Currency.default,
                                 amount: productPriceDecimal)
        let product = Product(withName: "TestProduct2", price: productPrice,
                              image: nil)

        basket.removeLineItem(ofProduct: product)

        XCTAssertEqual(basket.totalPriceInUSDollars.amount,
                       testProduct.price.amount)
        XCTAssertEqual(basket.selectedItems.count, 1)
    }

    // MARK: Total Amount of Product

    func testIfZeroProductAmountWillBeReturnedForEmptyBasket() {
        let productAmount = basket.getTotalAmountOfProduct(testProduct)

        XCTAssertEqual(productAmount, 0)
    }

    func testIfCorrectAmountWillBeReturnedForOneProductInBasket() {
        let _ = basket.add(product: testProduct)

        let productAmount = basket.getTotalAmountOfProduct(testProduct)

        XCTAssertEqual(productAmount, 1)
    }

    func testIfCorrectAmountWillBeReturnedForTwoSameProductInBasket() {
        let _ = basket.add(product: testProduct)
        let _ = basket.add(product: testProduct)

        let productAmount = basket.getTotalAmountOfProduct(testProduct)

        XCTAssertEqual(productAmount, 2)
    }

    // MARK: Products in basket

    func testIfEmptyProductArrayWillBeReturnedForEmptyBasket() {
        let products = basket.getProductsInBasket()

        XCTAssertTrue(products.isEmpty)
    }

    func testIfCorrectProductArrayWillBeReturnedWithOneLineItemInBasket() {
        let _ = basket.add(product: testProduct)

        let products = basket.getProductsInBasket()

        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products[0].uuid, testProduct.uuid)
    }
}
