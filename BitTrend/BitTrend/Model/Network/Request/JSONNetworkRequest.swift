//
//  JSONNetworkRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

protocol JSONNetworkRequest: NetworkRequest {}

extension JSONNetworkRequest where ResponseDataType: Decodable {
    
    func makeHeaders() throws -> [String : String] {
        
        var dictionary: [String: String]!
        
        if !(self.headers is NetworkEmptyDataType) {
            
            dictionary = try JSONSerialization.jsonObject(with: try JSONEncoder().encode(self.headers)) as? [String : String]
            
        } else {
            
            dictionary = [:]
        }
        
        dictionary["accept"] = "application/json"
        dictionary["x-cg-demo-api-key"] = AppData.apiKey()
        
        return dictionary
    }
    
    func makeQuery() throws -> [String : Any]? {
        
        guard !(self.query is NetworkEmptyDataType) else { return nil }
            
        let queryDictionary = try JSONSerialization.jsonObject(with: try JSONEncoder().encode(self.query))
        
        return queryDictionary as? [String : Any]
    }
    
    func parseResponse(_ response: HTTPURLResponse, data: Data) throws -> ResponseDataType {
        
        try JSONDecoder().decode(ResponseDataType.self, from: data)
    }
}
