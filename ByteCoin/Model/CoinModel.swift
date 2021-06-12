//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Slava on 25.02.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currency: String
    let crypto: Double
    
    
    var cryptoString: String {
        return String(format: "%.1f", crypto)
    }
}
