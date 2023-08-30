//
//  Notification.swift
//  AutoPilot_Admin
//
//  Created by Dylan Reich on 8/30/23.
//

import Foundation

struct Notification: Codable {
    let title: String?
    let userId: UUID?
    let enigmaId: String?
    let subtitle: String?
    let body: String?
    let itemUrl: String?
    let imageUrl: String?
    let language: String?
    let userType: String?
    let added: Date?
    let scheduled: Date?
}
