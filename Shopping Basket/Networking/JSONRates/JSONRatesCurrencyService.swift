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

        //if last download time is saved and was not more that 60 minutes ago
        //and we have saved currencies
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

    func getConversionRate(to currencyISO: String,
                           success: @escaping (Decimal) -> Void,
                           failure: @escaping (NetworkingError) -> Void) {
        downloadConversionRate(toCurrencyISO: currencyISO,
                               success: { (rate) in

            success(Decimal(floatLiteral: rate))
        }) { (error) in
            failure(error)
        }
    }

    // MARK: Network requests

    private func downloadCurrencies(_ success: @escaping ([String: String]) -> Void,
                                    failure: @escaping (NetworkingError) -> Void) {
        let urlString = "\(NetworkingConstants.JSONRates.baseUrl)/list?access_key=\(NetworkingConstants.JSONRates.apiKey)"

        guard let url = URL(string: urlString) else {
            failure(NetworkingError(.ParametersError))
            return
        }

        let request = URLRequest(url: url)
        let session = URLSession.shared

        let task = session.dataTask(with: request,
                                    completionHandler: {data, response, error -> Void in
            guard error == nil, let incomingData = data else {
                failure(NetworkingError(.ServerError))
                return
            }

            let decoder = JSONDecoder()
            do {
                let currencyDTO = try decoder.decode(CurrencyDTO.self,
                                                     from: incomingData)
                success(currencyDTO.currencies)
            } catch {
              failure(NetworkingError(.JSONParsingError))
            }
        })

        task.resume()
    }

    private func downloadConversionRate(toCurrencyISO: String,
                                        success: @escaping (Double) -> Void,
                                        failure: @escaping (NetworkingError) -> Void) {

        let urlString = "\(NetworkingConstants.JSONRates.baseUrl)/live?access_key=\(NetworkingConstants.JSONRates.apiKey)&currencies=\(toCurrencyISO)"

        guard let url = URL(string: urlString) else {
            failure(NetworkingError(.ParametersError))
            return
        }

        let request = URLRequest(url: url)
        let session = URLSession.shared
        let conversionDictKey = "\(Currency.default.isoCode)\(toCurrencyISO)"

        let task = session.dataTask(with: request,
                                    completionHandler: {data, response, error -> Void in

            guard error == nil, let incomingData = data else {
                failure(NetworkingError(.ServerError))
                return
            }

            let decoder = JSONDecoder()
            do {
                let conversionDTO = try decoder.decode(ConversionDTO.self, from: incomingData)
                if let conversionRate = conversionDTO.quotes[conversionDictKey],
                    conversionDTO.success {
                    success(conversionRate)
                } else {
                    failure(NetworkingError(.ResponseError))
                }

            } catch {
                failure(self.getErrorResponse(fromData: incomingData))
            }
        })

        task.resume()
    }

    // MARK: Helpers
    private func mapDictToCurrencyList(_ currenciesDict: [String: String]) -> [Currency] {
        return currenciesDict.map{ (isoCode, name) in
            return Currency(name: name, isoCode: isoCode)
        }
    }

    private func getErrorResponse(fromData data: Data) -> NetworkingError {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let error = json["error"] as? [String: Any],
                let errorCode = error["code"] as? Int,
                let errorMsg = error["info"] as? String {

                return NetworkingError(.ResponseError,
                                       errorMsg: errorMsg,
                                       errorCode: errorCode)
            } else {
                return NetworkingError(.JSONParsingError)
            }
        } catch {
            return NetworkingError(.JSONParsingError)
        }
    }
}
