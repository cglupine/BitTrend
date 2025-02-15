//
//  Localization.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation
import SwiftUI

typealias LK = LocalizedKey

enum LocalizedKey: LocalizedStringKey {
    
    case errorRetry = "error.retry.message"
    case errorConnectivity = "error.connectivity.message"
    case retry = "retry.action"
    case chart = "chart.trend.name"
    case noData = "data.empty.message"
    case chartDay = "chart.day"
    case chartPrice = "chart.price"
    case description = "description.name"
    case lastWeek = "week.last.message"
    case seeMore = "more.message"
    case topTenCoins = "coins.top.ten.name"
    case coinDetailsPrompt = "coin.details.prompt"
    case marketCap = "market.cap.name"
}
