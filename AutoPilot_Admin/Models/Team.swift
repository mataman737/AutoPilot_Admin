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
    var accessCode: String?
    var created: Date
}
