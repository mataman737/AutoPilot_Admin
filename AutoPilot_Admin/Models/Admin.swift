//
//  File.swift
//  AutoPilot_Admin
//
//  Created by Dylan Reich on 8/21/23.
//

import Foundation
import Disk
import FirebaseDynamicLinks

final class Admin: Codable {
    var id: UUID?
    var teamId: String?
    var isLive: Bool?
    var username: String?
    var displayName: String?
    var email: String?
    var profilePhotoUrl: String?
    var permissions: [String]?
    
    var tradeWonNotiSetting: Int {
        get {
            guard let permissions = permissions, permissions.indices.contains(0) else { return 1 }
            
            let components = permissions[0].components(separatedBy: ":")
            guard let intValue = Int(components[1]) else { return 1 }
            
            return intValue
        }
        set (newValue) {
            guard var p = permissions else {
                permissions = [String(newValue)]
                return
            }
            
            while !p.indices.contains(0) { //method of migration when we add new permissions - add default 1 for any to this expected index
                p.append("tradeWon:1")
            }
            p[0] = "tradeWon:\(newValue)"
            permissions = p
        }
    }
    
    var tradeLostNotiSetting: Int {
        get {
            guard let permissions = permissions, permissions.indices.contains(1) else { return 1 }
            
            let components = permissions[1].components(separatedBy: ":")
            guard let intValue = Int(components[1]) else { return 1 }
            
            return intValue
        }
        set (newValue) {
            guard var p = permissions else {
                permissions = [String(newValue)]
                return
            }
            
            while !p.indices.contains(1) { //method of migration when we add new permissions - add default 1 for any to this expected index
                p.append("tradeLost:1")
            }
            p[1] = "tradeLost:\(newValue)"
            permissions = p
        }
    }
    
    var teamChatNotiSetting: Int {
        get {
            guard let permissions = permissions, permissions.indices.contains(2) else { return 1 }
            
            let components = permissions[2].components(separatedBy: ":")
            guard let intValue = Int(components[1]) else { return 1 }
            
            return intValue
        }
        set (newValue) {
            guard var p = permissions else {
                permissions = [String(newValue)]
                return
            }
            
            while !p.indices.contains(2) { //method of migration when we add new permissions - add default 1 for any to this expected index
                p.append("teamChat:1")
            }
            p[2] = "teamChat:\(newValue)"
            permissions = p
        }
    }
    
    var teamMemberNotiSetting: Int {
        get {
            guard let permissions = permissions, permissions.indices.contains(3) else { return 1 }
            
            let components = permissions[3].components(separatedBy: ":")
            guard let intValue = Int(components[1]) else { return 1 }
            
            return intValue
        }
        set (newValue) {
            guard var p = permissions else {
                permissions = [String(newValue)]
                return
            }
            
            while !p.indices.contains(3) { //method of migration when we add new permissions - add default 1 for any to this expected index
                p.append("newTeamMember:1")
            }
            p[3] = "newTeamMember:\(newValue)"
            permissions = p
        }
    }
    
    func getShareLink() async -> String? {
        guard let link = URL(string: "https://enigmalabs.page.link/download?teamid=\(Admin.current.teamId!)") else { return nil }
        let dynamicLinksDomainURIPrefix = "https://enigmalabs.page.link"
        guard let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix) else {
            return nil
        }
        linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.EnigmaLabs.SpainFX")
        //linkBuilder.iOSParameters?.appStoreID = "1588642759"
        //linkBuilder.androidParameters = DynamicLinkAndroidParameters(packageName: "com.enigma.trading")
        //linkBuilder.otherPlatformParameters = DynamicLinkOtherPlatformParameters()

        do {
            let (url, warnings) = try await linkBuilder.shorten()
            print(warnings)
            
            return url.absoluteString
        } catch {
            print(error)
            
            return nil
        }
    }
    
    init() {
        
    }
    
    static var current: Admin {
        get {
            guard let c = _current else {
                _current = Admin()
                return _current!
            }
            return c
        }
        
        set {
            if newValue.id != _current?.id {
                print("bad bad error")
                print(newValue)
                print(_current as Any)
                print("wow")
            }
            _current = newValue
        }
    }
    
    private static var _current: Admin?
    
    static func saveCurrentAdmin() {
        do {
            try Disk.save(current, to: .applicationSupport, as: "currentAdmin")
        } catch {
            print(error)
        }
    }
    
    static func restoreCurrentAdmin() -> Bool {
        do {
            let admin = try Disk.retrieve("currentAdmin", from: .applicationSupport, as: Admin.self)
            current = admin
            
            return true
        } catch {
            print(error)
            return false
        }
    }
}

final class AdminSignup: Codable {
    var id: Int?
    var phone: String!
    var name: String?
    
    init(phone: String!) {
        self.phone = phone
    }
}

final class CreateAdminResponse: Codable {
    var admin: Admin!
    var token: String
}

final class LoginResponse: Codable {
    var admin: Admin!
    var token: String
}

final class SMSLoginAttempt: Codable {
    var code: String!
    var phone: String!
    var displayName: String!
    
    init(code: String, phone: String, displayName: String) {
        self.code = code
        self.phone = phone
        self.displayName = displayName
    }
}

final class LoginAttempt: Codable {
    var email: String!
    var password: String!
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

struct PendingAdminRequest: Codable {
    let teamId: UUID?
    let name: String?
    let phone: String?
    let adminType: String?
}
