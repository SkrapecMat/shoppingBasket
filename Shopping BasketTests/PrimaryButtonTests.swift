//
//  PrimaryButtonTests.swift
//  Shopping BasketTests
//
//  Created by Mateja Škrapec on 11/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import XCTest

@testable import Shopping_Basket

class PrimaryButtonTests: XCTestCase {

    var primaryButton: PrimaryButton!

    override func setUp() {
        super.setUp()

        primaryButton = PrimaryButton()
    }

    override func tearDown() {
        super.tearDown()

        primaryButton = nil
    }

    func testIfLocalizedTextIsSetCorrectly() {
        let localizedTextKey = "PRODUCT_LIST_VC__OPEN_BASKET"
        let localizedText = NSLocalizedString(localizedTextKey, comment: "")

        primaryButton.localizedStringKey = localizedTextKey
        let titleLabelText = primaryButton.titleLabel?.text

        XCTAssertNotNil(titleLabelText)
        XCTAssertEqual(titleLabelText!, localizedText)
    }
}
