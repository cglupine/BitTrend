//
//  URLResponseValidatorTests.swift
//  BitTrendTests
//
//  Created by Gabriele Carbutto on 05/02/25.
//

import Foundation
import Testing
@testable import BitTrend

struct URLResponseValidatorTests {
    
    @Test func shouldValidate2xxCodeResponse() async throws {
        
        let response = try #require(HTTPURLResponse(url: .temporaryDirectory,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil))
        #expect(throws: Never.self) {
            try URLResponseValidator.validateURLResponse(response)
        }
    }
    
    @Test func shouldNotValidate404Response() async throws {
        
        let response = try #require(HTTPURLResponse(url: .temporaryDirectory,
                                                    statusCode: 404,
                                                    httpVersion: nil,
                                                    headerFields: nil))
        
        #expect(throws: NetworkError.notFound) {
            try URLResponseValidator.validateURLResponse(response)
        }
    }
    
    @Test func shouldNotValidateResponse() async throws {
        
        let response = try #require(HTTPURLResponse(url: .temporaryDirectory,
                                                    statusCode: 500,
                                                    httpVersion: nil,
                                                    headerFields: nil))
        
        #expect(throws: NetworkError.generic(code: .init(rawValue: 500))) {
            try URLResponseValidator.validateURLResponse(response)
        }
    }
}
