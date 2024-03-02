//
//  Team.swift
//  AutoPilot_Admin
//
//  Created by Dylan Reich on 9/11/23.
//

import Foundation

struct Team: Codable {
    var id: UUID
    var adminIds: [UUID]
    var name: String
    var photo: String?
    var accessCode: String?
    var fxBook: String?
    var mtBrokers: [String]?
    var mtIds: [String]?
    var referralsOn: Bool?
    var copyTrading: Bool?
    var price: Double?
    var dueDate: Date?
    var created: Date
}
