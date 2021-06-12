//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func currencyDidUpdate(_ coinManager: CoinManager, currency: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "06DFAB68-204B-4930-92DB-181B68DFB348"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
        
    }
    func performRequest(with urlString: String){
        //        1. Create a URL
        
        if let url = URL(string: urlString) {
            //            2. Create a URLSession
            let session = URLSession(configuration: .default)
            //            3. Give the session a task
            let task = session.dataTask(with: url) { (data, responce, error) in
                
                if error != nil {
                    //             self.delegate?.didFailWithError(error: error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let price = parseJSON(safeData) {
                        //        self.delegate?.didUpdateWeather(self, weather: weather)
                        self.delegate?.currencyDidUpdate(self, currency: price)
                        print(price)
                    }
                    
                }
            }
            //            4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ currencyData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            //            let crypto = decodedData.asset_id_base
            let currency = decodedData.asset_id_quote
            let rate = decodedData.rate
            let price = CoinModel(currency: currency, crypto: rate)
            print(price.cryptoString)
            return price
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
