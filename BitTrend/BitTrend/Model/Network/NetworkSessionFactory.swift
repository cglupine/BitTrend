//
//  NetworkSessionFactory.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct NetworkSessionFactory {
    
    struct Configuration {
        
        let timeout: TimeInterval
        let cachePolicy: NSURLRequest.CachePolicy
        let cookiesAllowed: Bool
        let cookiesAcceptPolicy: HTTPCookie.AcceptPolicy
        
        static let `default` = Configuration(timeout: 60,
                                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                             cookiesAllowed: true,
                                             cookiesAcceptPolicy: .onlyFromMainDocumentDomain)
        
        init(timeout: TimeInterval,
             cachePolicy: NSURLRequest.CachePolicy,
             cookiesAllowed: Bool,
             cookiesAcceptPolicy: HTTPCookie.AcceptPolicy) {
            
            self.timeout = timeout
            self.cachePolicy = cachePolicy
            self.cookiesAllowed = cookiesAllowed
            self.cookiesAcceptPolicy = cookiesAcceptPolicy
        }
    }
    
    static func createEphemeral(with mockProtocol: MockURLProtocol.Type = MockURLProtocol.self) -> URLSession {
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [mockProtocol]
        
        return URLSession(configuration: sessionConfiguration)
    }
    
    static func create(withConfiguration configuration: Configuration = .default) -> URLSession {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = configuration.timeout
        sessionConfiguration.timeoutIntervalForResource = configuration.timeout
        sessionConfiguration.requestCachePolicy = configuration.cachePolicy
        sessionConfiguration.httpShouldSetCookies = configuration.cookiesAllowed
        sessionConfiguration.httpCookieAcceptPolicy = configuration.cookiesAcceptPolicy
        
        return URLSession(configuration: sessionConfiguration)
    }
}
