//
//  GlobalAnnouncement.swift
//  AutoPilot_Admin
//
//  Created by Dylan Reich on 3/2/24.
//

import Foundation

struct GlobalAnnouncement: Codable {
    var id: UUID?
    var title: String
    var body: String
    var priority: Int
    var added: Date
}
