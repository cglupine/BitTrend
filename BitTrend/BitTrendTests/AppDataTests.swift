//
//  AppDataTests.swift
//  BitTrendTests
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Testing
@testable import BitTrend

struct AppDataTests {

    @Test func shouldLoadAppData() async throws {
        
        let apiKey = AppData.apiKey()
        #expect(!apiKey.isEmpty)
        
        let baseURLString = AppData.baseURLString()
        #expect(!baseURLString.isEmpty)
    }
}
