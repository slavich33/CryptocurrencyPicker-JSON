//
//  CurrencyData.swift
//  ByteCoin
//
//  Created by Slava on 24.02.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CurrencyData: Codable {
    
    let asset_id_base: String
      let asset_id_quote: String
      let rate: Double
}
