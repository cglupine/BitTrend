//
//  BTCExchangeRatesRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct BTCExchangeRatesRequest: JSONNetworkRequest {
    
    typealias HeadersDataType = NetworkEmptyDataType
    typealias QueryDataType = NetworkEmptyDataType
    typealias ResponseDataType = RatesDTO
    
    let method: HTTPMethod = .GET
    let headers = NetworkEmptyDataType()
    let query = NetworkEmptyDataType()
    
    var absolutePath: String {
       
        AppData.baseURLString() + "/exchange_rates"
    }
}
