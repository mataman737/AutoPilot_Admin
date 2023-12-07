//
//  BalanceRecord.swift
//  AutoPilot_Admin
//
//  Created by Dylan Reich on 12/7/23.
//

import Foundation

struct BalanceRecord: Codable {
    var id: UUID
    var userId: UUID
    var lastDay: [String: Double]?
    var lastWeek: [String: Double]?
    var lastMonth: [String: Double]?
    var lastThreeMonths: [String: Double]?
    var lastYear: [String: Double]?
    var allTime: [String: Double]?
}

struct UserWithBalanceRecord: Codable {
    let user: User
    let balanceRecord: BalanceRecord
}
