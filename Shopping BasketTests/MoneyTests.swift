//
//  MoneyTests.swift
//  Shopping BasketTests
//
//  Created by Mateja Škrapec on 11/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import XCTest

@testable import Shopping_Basket

class MoneyTests: XCTestCase {

    var testMoney: Money!

    override func setUp() {
        super.setUp()

        testMoney = Money(currency: Currency.default, amount: Decimal(10))
    }

    override func tearDown() {
        super.tearDown()

        testMoney = nil
    }

    // MARK: Adding

    func testIfSumOfTwoMoneyWithSameCurrencyWillBeCorrect() {
        let money = Money(currency: Currency.default, amount: Decimal(8.2))

        let sum = money.add(testMoney)

        XCTAssertEqual(sum.amount, Decimal(18.2))
    }

    func testIfSumAttemptOfDifferentCurrenciesWillReturnMoneyInitalValue() {
        let currency = Currency(name: "Croatian kuna", isoCode: "HRK")
        let money = Money(currency: currency, amount: Decimal(8))

        let sum = money.add(testMoney)

        XCTAssertEqual(sum.amount, Decimal(10))
    }

    // MARK: Substraction

    func testIfDifferenceOfTwoMoneyWithSameCurrencyWillBeCorrect() {
        let money = Money(currency: Currency.default, amount: Decimal(8.2))

        let difference = testMoney.subtract(money)

        XCTAssertEqual(difference.amount, Decimal(1.8))
    }

    func testIfSubstractionAttemptOfDifferentCurrenciesWillReturnMoneyInitalValue() {
        let currency = Currency(name: "Croatian kuna", isoCode: "HRK")
        let money = Money(currency: currency, amount: Decimal(8))

        let difference = testMoney.subtract(money)

        XCTAssertEqual(difference.amount, Decimal(8))
    }

    // MARK: Multiply

    func testIfMultiplationOfMoneyWithConstantWillReturnCorrectResult() {
        let result = testMoney.multiply(by: 2)

        XCTAssertEqual(result.amount, Decimal(20))
    }

    // MARK: Convert

    func testIfMoneyConversionAttemptWillReturnTheCorrectResult() {
        let currency = Currency(name: "Croatian kuna", isoCode: "HRK")
        let conversionRate = Decimal(6.5)

        let money = testMoney.convert(to: currency,
                                      withConversionRate: conversionRate)

        XCTAssertEqual(money.currency.isoCode, currency.isoCode)
        XCTAssertEqual(money.amount, Decimal(65))
    }

    // MARK: Is Zero

    func testIfMoneyWithAmountZeroWillBeZero() {
        let money = Money(currency: Currency.default, amount: Decimal(0))

        let isZero = money.equalsZero()

        XCTAssertTrue(isZero)
    }

    func testIfMoneyWithAmountDifferentZeroWillNotBeZero() {
        let money = Money(currency: Currency.default, amount: Decimal(10))

        let isZero = money.equalsZero()

        XCTAssertFalse(isZero)
    }
}
