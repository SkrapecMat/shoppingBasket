//
//  jsonRatesCurrencyService.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 07/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class JSONRatesCurrencyService: CurrencyService {

    private var currencies: [Currency] = []
    private var lastDownloadDate: Date?
    private let downloadTimeInterval: TimeInterval = 3600.0//60 minutes

    func getAvailableCurrencies(_ success: @escaping ([Currency]) -> Void,
                                failure: @escaping (NetworkingError) -> Void) {
        if self.lastDownloadDate == nil
            || lastDownloadDate!.timeIntervalSinceNow > downloadTimeInterval {

            downloadCurrencies({ (currencies) in
                self.currencies = currencies
                success(currencies)
            }, failure: { (error) in
                failure(error)
            })

        } else {
            success(currencies)
        }
    }

    private func downloadCurrencies(_ success: @escaping ([Currency]) -> Void,
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
            if error != nil {
                self.lastDownloadDate = Date()
            } else {
                failure(NetworkingError())
            }
        })

        task.resume()
    }
}
