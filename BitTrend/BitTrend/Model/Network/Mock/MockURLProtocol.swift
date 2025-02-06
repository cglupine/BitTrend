//
//  MockURLProtocol.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

typealias MockResponse = (statusCode: Int, data: Data)

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> MockResponse)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        
        guard let url = self.request.url else {
            
            self.client?.urlProtocol(self, didFailWithError: URLError.init(.badURL))
            return
        }
        
        guard let handler = Self.requestHandler else {
            
            self.client?.urlProtocol(self, didFailWithError: URLError.init(.cannotParseResponse, userInfo: [
                NSLocalizedDescriptionKey: "No mock response registered for \(url)"]))
            return
        }
        
        do {
            let response = try handler(self.request)
            guard let httpURLResponse = HTTPURLResponse(url: url,
                                                        statusCode: response.statusCode,
                                                        httpVersion: nil,
                                                        headerFields: nil) else {
                
                self.client?.urlProtocol(self, didFailWithError: URLError.init(.badServerResponse))
                return
            }
            
            self.client?.urlProtocol(self, didReceive: httpURLResponse, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: response.data)
            self.client?.urlProtocolDidFinishLoading(self)
            
        } catch {
            
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
    
    static func localMockJsonResponseData(for requestType: Any, resultSuffix: String) throws -> MockResponse {
    
        let fileName = String(describing: requestType).appending("_\(resultSuffix)")
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
        
            return (statusCode: 200, data: data)
        }
        
        throw URLError(.cannotDecodeContentData)
    }
}
