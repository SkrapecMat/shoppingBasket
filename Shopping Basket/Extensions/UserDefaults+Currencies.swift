//
//  UserDefaults+Currencies.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 10/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import Foundation

extension UserDefaults {
    class func getCurrencies() -> [String: String]? {
        let userDefaults = UserDefaults.standard
        let key = Constants.UserDefaults.currenciesKey

        return userDefaults.object(forKey: key) as? Dictionary
    }

    class func saveCurrencies(_ currencies: [String: String]) {
        let userDefaults = UserDefaults.standard
        let key = Constants.UserDefaults.currenciesKey

        userDefaults.set(currencies, forKey: key)
        userDefaults.synchronize()
    }

    class func getLastCurrenciesDownloadTime() -> Date? {
        let userDefaults = UserDefaults.standard
        let key = Constants.UserDefaults.lastCurrenciesDownloadKey

        return userDefaults.object(forKey: key) as? Date
    }

    class func saveLastCurrenciesDownloadTime(_ date: Date) {
        let userDefaults = UserDefaults.standard
        let key = Constants.UserDefaults.lastCurrenciesDownloadKey

        userDefaults.set(date, forKey: key)
        userDefaults.synchronize()
    }
}
