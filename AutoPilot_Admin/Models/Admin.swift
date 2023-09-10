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

