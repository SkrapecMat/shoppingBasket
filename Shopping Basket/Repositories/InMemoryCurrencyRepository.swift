//
//  CurrencyRepositoryInMemory.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 07/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

class InMemoryCurrencyRepository: CurrencyRepository {

    private var currencies: [Currency] = []

    init(withCurrencies currencies: [Currency]) {
        self.currencies = currencies
    }

    func getAll() -> [Currency] {
        return currencies
    }

    func get(byIsoCode isoCode: String) -> Currency? {
        return currencies.first(where: {$0.isoCode == isoCode})
    }
}
