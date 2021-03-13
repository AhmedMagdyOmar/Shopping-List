//
//  Helper.swift
//  Shopping List
//
//  Created by Ahmed on 3/7/21.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Foundation

//Mark: - Convert price to currencyFormatter
func convertToCurrency(_ number: (String)) -> String {
    let price = Double(number)
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    
    return currencyFormatter.string(from: NSNumber(value: price ?? 0))!

}
