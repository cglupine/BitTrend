//
//  NetworkRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

enum HTTPMethod: String {
    
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
}

protocol NetworkRequest {
    
    associatedtype HeadersDataType: Encodable
    associatedtype QueryDataType: Encodable
    associatedtype ResponseDataType
    
    var absolutePath: String { get }
    var method: HTTPMethod { get }
    var headers: HeadersDataType { get }
    var query: QueryDataType { get }
    
    func makeURLRequest() throws -> URLRequest
    func makeHeaders() throws -> [String : String]
    func makeQuery() throws -> [String : Any]?
    func parseResponse(_ response: HTTPURLResponse, data: Data) throws -> ResponseDataType
}

extension NetworkRequest {
    
    func makeURLRequest() throws -> URLRequest {
        
        guard let url = URL(string: self.absolutePath),
              var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            
            throw NetworkError.generic(code: .badURL)
        }
        
        if let query = try self.makeQuery() {
            
            urlComponent.queryItems = query.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        }
        
        var urlRequest = URLRequest(url: urlComponent.url!)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = try self.makeHeaders()
        
        return urlRequest
    }
}
