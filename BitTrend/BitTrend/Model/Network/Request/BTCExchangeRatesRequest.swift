//
//  BTCExchangeRatesRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct BTCExchangeRatesRequest: JSONNetworkRequest {
    
    typealias HeadersDataType = NetworkEmptyDTO
    typealias QueryDataType = NetworkEmptyDTO
    typealias ResponseDataType = RatesDTO
    
    let method: HTTPMethod = .GET
    let headers = NetworkEmptyDTO()
    let query = NetworkEmptyDTO()
    
    var absolutePath: String {
       
        AppData.baseURLString() + "/exchange_rates"
    }
}
