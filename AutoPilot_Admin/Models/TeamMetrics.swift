//
//  TeamMetrics.swift
//  AutoPilot_Admin
//
//  Created by Dylan Reich on 1/26/24.
//

import Foundation

struct LotsMetrics: Codable {
    let todaysLots: Double
    let thisWeeksLots: Double
    let lastWeeksLots: Double
    let thisMonthsLots: Double
}

struct SubMetrics: Codable {
    var id: UUID
    var teamId: UUID
    var freeCount: Int
    var paidCount: Int
    var historicalCount: Int
    var added: Date
}

struct UserPayment: Codable {
    var id: UUID
    var userId: UUID
    var teamId: UUID
    var added: Date
}
