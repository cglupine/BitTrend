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
    
    case appName = "app.name"
    case loading = "loading.message"
    case errorRetry = "error.retry.message"
    case retry = "retry.action"
    case description = "description.name"
    case seeMore = "more.message"
}
