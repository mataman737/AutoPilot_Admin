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
    var phone: String?
    var language: String
    var country: String?
    var teamJoinDate: Date?
    var verified: Bool?
    var paid: Bool?
    
    var isSubscribed: Bool {
        return paid ?? false
    }
}

struct UserUpdatePaidRequest: Codable {
    let phone: String
    let paid: Bool
}
