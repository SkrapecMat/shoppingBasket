//
//  jsonRatesCurrencyService.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 07/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class JSONRatesCurrencyService: CurrencyService {

    private let downloadTimeInterval: TimeInterval = 3600.0//60 minutes

    func getAvailableCurrencies(_ success: @escaping ([Currency]) -> Void,
                                failure: @escaping (NetworkingError) -> Void) {
        if let lastDownloadDate = UserDefaults.getLastCurrenciesDownloadTime(),
            abs(lastDownloadDate.timeIntervalSinceNow) < downloadTimeInterval,
            let savedCurrencies = UserDefaults.getCurrencies() {

            success(mapDictToCurrencyList(savedCurrencies))

        } else {

            downloadCurrencies({ (currencies) in
                UserDefaults.saveCurrencies(currencies)
                UserDefaults.saveLastCurrenciesDownloadTime(Date())
                success(self.mapDictToCurrencyList(currencies))
            }, failure: { (error) in
                failure(error)
            })
        }
    }

    private func downloadCurrencies(_ success: @escaping ([String: String]) -> Void,
                                    failure: @escaping (NetworkingError) -> Void) {
        let urlString = "\(NetworkingConstants.JSONRates.baseUrl)/list?access_key=\(NetworkingConstants.JSONRates.apiKey)"

        guard let url = URL(string: urlString) else {
            failure(NetworkingError())
            return
        }

        let request = URLRequest(url: url)
        let session = URLSession.shared

        let task = session.dataTask(with: request,
                                    completionHandler: {data, response, error -> Void in
            if error == nil {
//                do {
                    let decoder = JSONDecoder()
                    do {
                        let currencyDTO = try decoder.decode(CurrencyDTO.self, from: data!)
                        success(currencyDTO.currencies)
                    } catch {
                        failure(NetworkingError())
                    }
//                    if let currenciesJSON = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: String] {
//                        success((currenciesJSON as? [String: String])!)
//                    } else {
//                        failure(NetworkingError())
//                    }
//                } catch {
//                    failure(NetworkingError())
//                }
            } else {
                failure(NetworkingError())
            }
        })

        task.resume()
    }

    private func mapDictToCurrencyList(_ currenciesDict: [String: String]) -> [Currency] {
        return currenciesDict.map{ (isoCode, name) in
            return Currency(name: name, isoCode: isoCode)
        }
    }
}
