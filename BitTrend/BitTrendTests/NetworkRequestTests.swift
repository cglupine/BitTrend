//
//  NetworkRequestTests.swift
//  BitTrendTests
//
//  Created by Gabriele Carbutto on 05/02/25.
//

import Foundation
import Testing
@testable import BitTrend

struct NetworkRequestsTest {
    
    private let commonHeaders: [String: String]
    
    init() {
        
        self.commonHeaders = [
            "Accept" : "application/json",
            "x-cg-demo-api-key" : AppData.apiKey()
        ]
    }

    @Test func shouldCreateTrendingSearchListURLRequest() async throws {

        let request = CoinListMarketRequest(query: .init(
            vs_currency: "eur",
            per_page: 10,
            locale: "en",
            precision: "2"))
        
        let headers = try request.makeHeaders()
        #expect(headers == self.commonHeaders)
        
        let query = try #require(try request.makeQuery())
        #expect(query["vs_currency"] as? String == request.query.vs_currency)
        #expect(query["per_page"] as? Int == request.query.per_page)
        #expect(query["locale"] as? String == request.query.locale)
        #expect(query["precision"] as? String == request.query.precision)
        
        let urlRequest = try request.makeURLRequest()
        #expect(throws: Never.self) {
            try #require(URL(string: request.absolutePath))
        }
        #expect(urlRequest.url?.path() == urlRequest.url?.path())
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.allHTTPHeaderFields == headers)
    }
    
    @Test func shouldCreateCoinDataURLRequest() async throws {

        let request = CoinDataRequest(id: "bitcoin")
        
        let headers = try request.makeHeaders()
        #expect(headers == self.commonHeaders)
        
        let query = try #require(try request.makeQuery())
        #expect(query["tickers"] as? Bool == request.query.tickers)
        #expect(query["community_data"] as? Bool == request.query.community_data)
        #expect(query["developer_data"] as? Bool == request.query.developer_data)
        
        let urlRequest = try request.makeURLRequest()
        #expect(throws: Never.self) {
            try #require(URL(string: request.absolutePath))
        }
        #expect(urlRequest.url?.path() == urlRequest.url?.path())
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.allHTTPHeaderFields == headers)
    }
    
    @Test func shouldCreateCoinHistoricalChartDataURLRequest() async throws {

        let request = CoinHistoricalChartDataRequest(
            id: "bitcoin",
            query: .init(vs_currency: "eur", days: 7, precision: 2))
        
        let headers = try request.makeHeaders()
        #expect(headers == self.commonHeaders)
        
        let query = try #require(try request.makeQuery())
        #expect(query["vs_currency"] as? String == request.query.vs_currency)
        #expect(query["days"] as? Int == request.query.days)
        #expect(query["precision"] as? Int == request.query.precision)
        
        let urlRequest = try request.makeURLRequest()
        let url = try #require(URL(string: request.absolutePath))
        var components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
        components.query = "vs_currency=\(request.query.vs_currency)"
        components.query = "days=\(request.query.days)"
        components.query = "precision=\(request.query.precision)"
        #expect(urlRequest.url?.path() == urlRequest.url?.path())
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.allHTTPHeaderFields == headers)
    }
    
    @Test func shouldNotCreateURLRequestWithBadURL() async throws {
            
        let request = DummyJSONNetworkRequest(absolutePath: "")
        
        #expect(throws: NetworkError.generic(code: .badURL)) {
            try request.makeURLRequest()
        }
    }
}

//MARK: - DUMMY NETWORK REQUEST

fileprivate struct DummyJSONNetworkRequest: JSONNetworkRequest {
    
    typealias HeadersDataType = NetworkEmptyDTO
    typealias QueryDataType = NetworkEmptyDTO
    typealias ResponseDataType = NetworkEmptyDTO
    
    let absolutePath: String
    let method = HTTPMethod.GET
    let headers = NetworkEmptyDTO()
    let query = NetworkEmptyDTO()
}
