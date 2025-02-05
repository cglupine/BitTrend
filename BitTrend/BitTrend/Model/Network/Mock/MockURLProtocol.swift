//
//  MockURLProtocol.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct MockResponseData {
    
    let result: Result<Data, NetworkError>
    let statusCode: Int
    
    init(result: Result<Data, NetworkError>, statusCode: Int) {
     
        self.result = result
        self.statusCode = statusCode
    }
}

typealias MockResponse = (URLRequest) -> MockResponseData

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: MockResponse?
    
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
        
        let response = handler(self.request)
        switch response.result {
            
        case .success(let data):
            guard let httpURLResponse = HTTPURLResponse(url: url,
                                                        statusCode: response.statusCode,
                                                        httpVersion: nil,
                                                        headerFields: nil) else {
                
                self.client?.urlProtocol(self, didFailWithError: URLError.init(.badServerResponse))
                return
            }
            
            self.client?.urlProtocol(self, didReceive: httpURLResponse, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
            
        case .failure(let error):
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
    
    static func localMockJsonResponseData(for requestType: Any, resultSuffix: String) -> MockResponseData {
    
        let fileName = String(describing: requestType).appending("_\(resultSuffix)")
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
        
            return MockResponseData(result: .success(data), statusCode: 200)
        }
        
        return MockResponseData(result: .failure(.generic(code: .cannotDecodeContentData)),
                                statusCode: URLError.cannotDecodeContentData.rawValue)
    }
}
