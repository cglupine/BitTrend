//
//  NetworkRequestLoader.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

class NetworkRequestLoader<T: NetworkRequest>: CancellableNetworkRequestLoader  {
    
    private let request: T
    private let reachabilityService: ReachabilityService
    private weak var session: URLSession?
    private var pendingTask: Task<T.ResponseDataType, Error>?
    
    init(request: T, session: URLSession, reachabilityService: ReachabilityService) {
        
        self.request = request
        self.session = session
        self.reachabilityService = reachabilityService
    }
    
    deinit {
        
        self.cancel()
    }
    
    func loadResponse() async throws -> T.ResponseDataType {
        
        let task = Task.detached(priority: .userInitiated) { [weak self] in
            
            guard let self,
                  let session else {
                
                throw NetworkError.generic(code: .cancelled)
            }
            
            guard self.reachabilityService.isInternetAccessible else {
                
                throw NetworkError.noInternetConnection
            }
            
            let urlRequest = try self.request.makeURLRequest()
            NetworkLogger.logURLRequest(urlRequest)
            
            let (data, response) = try await session.data(for: urlRequest)
            NetworkLogger.logURLResponse(response, data: data)
            
            guard !Task.isCancelled else {
                
                throw NetworkError.generic(code: .cancelled)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                
                throw NetworkError.generic(code: .badServerResponse)
            }
            
            try URLResponseValidator.validateURLResponse(httpResponse)
            
            return try self.request.parseResponse(httpResponse, data: data)
        }
        
        self.pendingTask = task
        
        return try await task.value
    }
    
    func cancel() {
        
        self.pendingTask?.cancel()
    }
}
