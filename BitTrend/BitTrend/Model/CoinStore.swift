//
//  CoinStore.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

@Observable class CoinStore {
    
    private static let eurCurrencyCode = "eur"
    private static let defaultLanguageCode = "en"
    
    var coins: [Coin] = []
    
    private let repository: CoinRepository
    
    init(repository: CoinRepository) {
        
        self.repository = repository
    }
    
    @MainActor func loadTopTenCoins() async throws {
        
        let languageCode = Locale.current.language.languageCode?.identifier ?? Self.defaultLanguageCode
        let fetched = try await self.repository.fetchMarketCoins(
            count: 10,
            currencyCode: Self.eurCurrencyCode,
            languageCode: languageCode,
            precision: 2)
            .map { dto in
                
                Coin(id: dto.id,
                     name: dto.name,
                     symbol: dto.symbol,
                     rank: dto.market_cap_rank,
                     eurPrice: dto.current_price,
                     marketCapPrice: dto.market_cap,
                     percentageChange: dto.price_change_percentage_24h,
                     thumbnailURLString: dto.image,
                     largeImageURLString: dto.image)
            }
        
        self.coins = fetched
    }
    
    func loadDetailsTillLastWeek(forCoin coin: Coin) async throws -> CoinDetail {
        
        let details = try await self.repository.fetchDetails(for: coin.id)
        let chart = try await self.repository.fetchCharts(
            for: coin.id,
            currencyCode: Self.eurCurrencyCode,
            days: 7,
            precision: 2)
        
        let homePageURLString = details.homePageURLString()
        
        var result: CoinDetail
        if let description = details.description(languageCode: Locale.current.language.languageCode?.identifier),
           !description.isEmpty {
            
            result = .init(description: description,
                           homepageURLString: homePageURLString)
            
        } else {
            
            result = .init(description: details.description(languageCode: Self.defaultLanguageCode) ?? "",
                           homepageURLString: homePageURLString)
        }
        
        result.chartData = chart.map { dto in
        
            ChartEntry(date: dto.date, amount: dto.price)
        }
        return result
    }
    
    func cancelDetailsFetching() {
        
        self.repository.cancel()
    }
}
