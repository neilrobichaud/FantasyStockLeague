//
//  Stock.swift
//  FantasyStockLeague
//
//  Created by neil robichaud on 2016-11-12.
//  Copyright © 2016 neil robichaud. All rights reserved.
//

import Foundation
class Stock{
    var day = String()
    var symbol = String()
    var close = String()
    func Stock(day: String, symbol: String, close: String){
        self.day = day
        self.symbol = symbol
        self.close = close
    }
}