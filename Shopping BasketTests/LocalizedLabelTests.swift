//
//  LocalizedLabelTests.swift
//  Shopping BasketTests
//
//  Created by Mateja Škrapec on 11/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import XCTest

@testable import Shopping_Basket

class LocalizedLabelTests: XCTestCase {

    var localizedLabel: LocalizedLabel!

    override func setUp() {
        super.setUp()

        localizedLabel = LocalizedLabel()
    }

    override func tearDown() {
        super.tearDown()

        localizedLabel = nil
    }

    func testIfLocalizedTextIsSetCorrectly() {
        let localizedTextKey = "PRODUCT_LIST_VC__OPEN_BASKET"
        let localizedText = NSLocalizedString(localizedTextKey, comment: "")

        localizedLabel.localizedStringKey = localizedTextKey
        let labelText = localizedLabel.text

        XCTAssertNotNil(labelText)
        XCTAssertEqual(labelText!, localizedText)
    }

    func testIfLocalizedStringKeyWillBeReturnedAsEmptyStringWhenNoLabelText() {
        let localizedStringKey = localizedLabel.localizedStringKey

        XCTAssertTrue(localizedStringKey.isEmpty)
    }
}

