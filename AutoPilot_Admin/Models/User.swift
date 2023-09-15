//
//  User.swift
//  AutoPilot_Admin
//
//  Created by Dylan Reich on 9/15/23.
//

import Foundation

struct User: Codable {
    var id: UUID
    var teamId: UUID?
    var firstName: String?
    var lastName: String?
    var profilePhotoUrl: String?
    var language: String
}
