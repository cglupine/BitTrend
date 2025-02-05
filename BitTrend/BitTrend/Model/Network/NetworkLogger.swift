//
//  NetworkLogger.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation
import os.log

private extension OSLog {
    
    static let network = OSLog(subsystem: "bittrend", category: "NETWORK")
}

struct NetworkLogger {
    
    private static let bodyLimit = 5120
        
    private static func prefix(for category: OSLog) -> String {
        
        switch category {
        
        case .network: return "📡 NETWORK"
        default: return "💥"
        }
    }
    
    static func logInfo(with message: String) {
        
        os_log("%{public}@ %{private}@", log: .network, type: .info, self.prefix(for: .network), message)
    }
    
    static func logDebug(with message: String) {
        
        os_log("%{public}@ %{public}@", log: .network, type: .debug, self.prefix(for: .network), message)
    }
    
    static func logError(with error: Error) {
        
        os_log("%{public}@ %{public}@", log: .network, type: .error, self.prefix(for: .network), error.localizedDescription)
    }
    
    static func logURLRequest(_ request: URLRequest) {
        
        var message = "\n\n⬆️⬆️----------------------------------- START NETWORK REQUEST -----------------------------------⬆️⬆️\n"
        
        if let url = request.url {
         
            message.append("\n\t\tURL: \(url)")
        }
        
        if let method = request.httpMethod {
            
            message.append("\n\t\tMETHOD: \(method)")
        }
        
        if let headers = request.allHTTPHeaderFields {
            
            message.append("\n\t\tHEADERS: \(headers)")
        }
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            
            message.append(String("\n\t\tBODY:\n\(bodyString)".prefix(self.bodyLimit)))
        }
        
        message.append("\n\n⬆️⬆️----------------------------------- END NETWORK REQUEST -------------------------------------⬆️⬆️")
        
        self.logDebug(with: message)
    }
    
    static func logURLResponse(_ response: URLResponse, data: Data) {
        
        var message = "\n⬇️⬇️----------------------------------- START NETWORK RESPONSE ----------------------------------⬇️⬇️\n"
        
        if let url = response.url {
         
            message.append("\n\t\tURL: \(url)")
        }
        
        if let response = response as? HTTPURLResponse {
            
            message.append("\n\t\tSTATUS CODE: \(response.statusCode)")
            message.append("\n\t\tHEADERS: \(response.allHeaderFields)")
            
            if let bodyString = String(data: data, encoding: .utf8) {
                
                message.append(String("\n\t\tBODY:\n\(bodyString)".prefix(self.bodyLimit)))
            }
        }
        
        message.append("\n\n⬇️⬇️----------------------------------- END NETWORK RESPONSE -----------------------------------⬇️⬇️")
        
        self.logDebug(with: message)
    }
}
