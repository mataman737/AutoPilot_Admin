//
//  API.swift
//  AutoPilot_Admin
//
//  Created by Dylan Reich on 8/21/23.
//

import Foundation
import Disk

enum MError: Error {
    case endpointsNotCached
}

class API: NSObject {
    
    static let sharedInstance = API()
    
    static var isTestEnvironment: Bool {
        #if DEBUG
        return true //change debug
        #else
        return false
        #endif
    }
    
    static let serverUrl = isTestEnvironment ? "https://smarttradeapi.com/" : "https://smarttradeapi.com/" // "http://localhost:8080/" // "https://api.lynkapp.co/"
    static let tradingUrl = isTestEnvironment ? "https://smarttradeterminal.com/" : "https://smarttradeterminal.com/" //"http://localhost:5000/"
    
    func performRequest<T: Codable>(endpoint: String, method: String, authenticated: Bool = true, object: T?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let url = URL(string: API.serverUrl + endpoint) else {
            print("error generating url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        if authenticated {
            request.addAuthTokens()
        }
        
        if let object = object {
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .iso8601
                let data = try encoder.encode(object)
                request.httpBody = data
            } catch {
                print(error)
                completionHandler(nil, nil, error)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(nil, response, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                if httpStatus.statusCode == 401 && authenticated {
                    DispatchQueue.main.async { [weak self] in
                        self?.setWelcomeScreenAsRoot()
                    }
                }
                completionHandler(data, response, error)
                return
            }
            
            completionHandler(data, response, error)
        }
        task.resume()
    }
    
    func performTradingRequest<T: Codable>(endpoint: String, method: String, authenticated: Bool = true, object: T?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let url = URL(string: API.tradingUrl + endpoint) else {
            print("error generating url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        if authenticated {
            request.addAuthTokens()
        }
        
        if let object = object {
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .iso8601
                let data = try encoder.encode(object)
                request.httpBody = data
            } catch {
                print(error)
                completionHandler(nil, nil, error)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(nil, response, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                if httpStatus.statusCode == 401 && authenticated {
                    DispatchQueue.main.async { [weak self] in
                        self?.setWelcomeScreenAsRoot()
                    }
                }
                completionHandler(data, response, error)
                return
            }
            
            completionHandler(data, response, error)
        }
        task.resume()
    }
    
    func performRequest(endpoint: String, method: String, authenticated: Bool = true, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        return performRequest(endpoint: endpoint, method: method, object: Object.Nil, completionHandler: completionHandler)
    }
    
    func performTradingRequest(endpoint: String, method: String, authenticated: Bool = true, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        return performTradingRequest(endpoint: endpoint, method: method, object: Object.Nil, completionHandler: completionHandler)
    }
    
    func setWelcomeScreenAsRoot() {
        //TODO Stephen
    }
    
    func getToken(identity: String, classString: String, completionHandler: @escaping (Bool, LToken?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: API.serverUrl + "twiliotoken?identity=\(identity)&class=\(classString)")!)
        request.httpMethod = "GET"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completionHandler(false, nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let token = try decoder.decode(LToken.self, from: data)
                
                completionHandler(true, token, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
        
        task.resume()
    }
    
    func refreshToken(completionHandler: @escaping (Bool, Error?) -> ()) {
        performRequest(endpoint: "api/admin/token", method: "GET", authenticated: true) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let token = try decoder.decode(AToken.self, from: data)
                
                try Disk.save(LToken(token: token.token), to: .applicationSupport, as: "token")
                
                completionHandler(true, nil)
            } catch {
                print(error)
                completionHandler(false, error)
            }
        }
    }
    
    func getCurrentTeam(completionHandler: @escaping (Bool, Team?, Error?) -> ()) {
        performRequest(endpoint: "api/admin/teams", method: "GET", authenticated: true) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let team = try decoder.decode(Team.self, from: data)
                
                completionHandler(true, team, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func updateTeam(team: Team, completionHandler: @escaping (Bool, Team?, Error?) -> ()) {
        performRequest(endpoint: "api/admin/teams", method: "PUT", authenticated: true, object: team) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let team = try decoder.decode(Team.self, from: data)
                
                completionHandler(true, team, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func updateTeamAccessCode(team: Team, completionHandler: @escaping (Bool, Team?, Error?) -> ()) {
        performRequest(endpoint: "api/admin/teams/code", method: "PUT", authenticated: true, object: team) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let team = try decoder.decode(Team.self, from: data)
                
                completionHandler(true, team, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func updateTeamFXBook(team: Team, completionHandler: @escaping (Bool, Team?, Error?) -> ()) {
        performRequest(endpoint: "api/admin/teams/fxbook", method: "PUT", authenticated: true, object: team) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let team = try decoder.decode(Team.self, from: data)
                
                completionHandler(true, team, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func getMTServers(completionHandler: @escaping (Bool, [MTServerBroker]?, Error?) -> ()) {
        performRequest(endpoint: "mtservers", method: "GET", authenticated: true) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let acounts = try decoder.decode([MTServerBroker].self, from: data)
                
                completionHandler(true, acounts, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func getMTTradingAccounts(completionHandler: @escaping (Bool, [String]?, Error?) -> ()) {
        performRequest(endpoint: "api/admin/mtbrokers", method: "GET", authenticated: true) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let acounts = try decoder.decode([String].self, from: data)
                
                completionHandler(true, acounts, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func submitMTBrokerDetails(details: ConnectBrokerRequest, completionHandler: @escaping (Bool, Error?) -> ()) {
        print(details)
        var request = URLRequest(url: URL(string: "\(API.tradingUrl)adminbroker")!)
        request.httpMethod = "POST"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addAuthTokens()
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(details)
            request.httpBody = data
        } catch {
            print(error)
            completionHandler(false, error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 201 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completionHandler(false, error)
                return
            }
            
//            do {
//                let orders = try JSONDecoder().decode([Order].self, from: data)
                
                completionHandler(true, nil)
//            } catch {
//                print(error)
//                completionHandler(false, nil, error)
//            }
        }
        
        task.resume()
    }
    
    func getForexSignals(completionHandler: @escaping (Bool, [Signal]?, Error?) -> ()) {
        performRequest(endpoint: "api/admin/signals", method: "GET", authenticated: true) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let forexes = try decoder.decode([Signal].self, from: data)
                
                completionHandler(true, forexes, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func postForexSignal(signal: SignalRequest, completionHandler: @escaping (Bool, Signal?, Error?) -> ()) {
        print(signal)
        performTradingRequest(endpoint: "signal", method: "POST", authenticated: true, object: signal) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let signal = try decoder.decode(Signal.self, from: data)
                
                completionHandler(true, signal, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func updateSignal(signal: InstantTrade, completionHandler: @escaping (Bool, CreateSignalResponse?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: "\(API.tradingUrl)signalmodify")!)
        request.httpMethod = "POST"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addAuthTokens()
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(signal)
            request.httpBody = data
        } catch {
            print(error)
            completionHandler(false, nil, error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completionHandler(false, nil, error)
                return
            }
            
//            do {
//                let signalResponse = try JSONDecoder().decode(CreateSignalResponse.self, from: data)
                
                completionHandler(true, nil, nil)
//            } catch {
//                print(error)
//                completionHandler(false, nil, error)
//            }
        }
        
        task.resume()
    }
    
    func closeSignal(signal: InstantTrade, completionHandler: @escaping (Bool, CreateSignalResponse?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: "\(API.tradingUrl)signalclose")!)
        request.httpMethod = "POST"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addAuthTokens()
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(signal)
            request.httpBody = data
        } catch {
            print(error)
            completionHandler(false, nil, error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completionHandler(false, nil, error)
                return
            }
            
//            do {
//                let signalResponse = try JSONDecoder().decode(CreateSignalResponse.self, from: data)
                
                completionHandler(true, nil, nil)
//            } catch {
//                print(error)
//                completionHandler(false, nil, error)
//            }
        }
        
        task.resume()
    }
    
    func deleteSignal(signal: Signal, completionHandler: @escaping (Bool, Signal?, Error?) -> ()) {
        performRequest(endpoint: "api/users/signals?id=\(signal.id!.uuidString)", method: "DELETE", authenticated: true) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
//            do {
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//                let signal = try decoder.decode(Signal.self, from: data)
                
                completionHandler(true, nil, nil)
//            } catch {
//                print(error)
//                completionHandler(false, nil, error)
//            }
        }
    }
    
    func sendNotification(notification: Notification, completionHandler: @escaping (Bool, Signal?, Error?) -> ()) {
        performRequest(endpoint: "sendpush", method: "POST", authenticated: true, object: notification) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
//            do {
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//                let signal = try decoder.decode(Signal.self, from: data)
                
                completionHandler(true, nil, nil)
//            } catch {
//                print(error)
//                completionHandler(false, nil, error)
//            }
        }
    }
    
    func getNotifications(completionHandler: @escaping (Bool, [Notification]?, Error?) -> ()) {
        performRequest(endpoint: "api/admin/notifications", method: "GET", authenticated: true) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let signals = try decoder.decode([Notification].self, from: data)
                
                completionHandler(true, signals, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func sendToken(token: AToken, completionHandler: @escaping (Bool, [Admin]?, Error?) -> ()) {
        if Admin.current.id != nil {
            performRequest(endpoint: "api/admin/devicetoken", method: "POST", authenticated: true, object: token) { (data, response, error) in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    completionHandler(false, nil, error)
                    return
                }
                completionHandler(true, nil, nil)
            }
        } else {

        }
    }

    func sendTokenSandbox(token: AToken, completionHandler: @escaping (Bool, [Admin]?, Error?) -> ()) {
        if Admin.current.id != nil {
            performRequest(endpoint: "api/admin/devicetokensandbox", method: "POST", authenticated: true, object: token) { (data, response, error) in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    completionHandler(false, nil, error)
                    return
                }
                completionHandler(true, nil, nil)
            }
        } else {

        }
    }
    
    func login(loginRequest: LoginAttempt, completionHandler: @escaping (Bool, Admin?, Error?, Int?) -> ()) {
        performRequest(endpoint: "api/users/login", method: "POST", authenticated: true, object: loginRequest) { (data, response, error) in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode != 406 else {
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error, ((response as? HTTPURLResponse)?.statusCode ?? -1))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(CreateAdminResponse.self, from: data)
                
                try Disk.save(LToken(token: response.token), to: .applicationSupport, as: "token")
                
                completionHandler(true, response.admin, nil, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error, nil)
            }
        }
    }
    
    func getStreamToken(completionHandler: @escaping (Bool, LToken?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: "http://a69588fe18ac228b0.awsglobalaccelerator.com/fetch_stream_token")!)
        request.httpMethod = "POST"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(StreamTokenRequest(username: "admin\(Admin.current.id!.uuidString.uppercased())"))
            request.httpBody = data
        } catch {
            print(error)
            completionHandler(false, nil, error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completionHandler(false, nil, error)
                return
            }
            
            do {
                let token = try JSONDecoder().decode(LToken.self, from: data)
                
                completionHandler(true, token, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
        
        task.resume()
    }
    
    func sendSMSVerify(user: AdminSignup, completionHandler: @escaping (Bool, Admin?, Error?) -> ()) {
        performRequest(endpoint: "api/signup/verify", method: "POST", authenticated: true, object: user) { (data, response, error) in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            
//            do {
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//                let response = try decoder.decode(SMSLoginRequest.self, from: data)
                
                completionHandler(true, nil, nil)
//            } catch {
//                print(error)
//                completionHandler(false, nil, error)
//            }
        }
    }
    
    func sendSMSVerifyLogin(loginRequest: SMSLoginAttempt, completionHandler: @escaping (Bool, Admin?, Error?, Int?) -> ()) {
        performRequest(endpoint: "api/signup/verifylogin", method: "POST", authenticated: true, object: loginRequest) { (data, response, error) in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode != 406 else {
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error, ((response as? HTTPURLResponse)?.statusCode ?? -1))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(CreateAdminResponse.self, from: data)
                
                try Disk.save(LToken(token: response.token), to: .applicationSupport, as: "token")
                
                completionHandler(true, response.admin, nil, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error, nil)
            }
        }
    }
    
    func updateAdmin(admin: Admin, completionHandler: @escaping (Bool, Admin?, Error?) -> ()) {
        performRequest(endpoint: "api/admin", method: "PUT", authenticated: true, object: admin) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let admin = try decoder.decode(Admin.self, from: data)
                
                completionHandler(true, admin, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
    }
    
    func pingTradingServer(completionHandler: @escaping (Bool, Error?) -> ()) {
        print(signal)
        var request = URLRequest(url: URL(string: "\(API.tradingUrl)adminping")!)
        request.httpMethod = "POST"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addAuthTokens()
        
//        do {
//            let encoder = JSONEncoder()
//            encoder.dateEncodingStrategy = .iso8601
//            let data = try encoder.encode(signal)
//            request.httpBody = data
//        } catch {
//            print(error)
//            completionHandler(false, nil, error)
//        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completionHandler(false, error)
                return
            }
            
//            do {
//                let signalResponse = try JSONDecoder().decode(CreateSignalResponse.self, from: data)
                
                completionHandler(true, nil)
//            } catch {
//                print(error)
//                completionHandler(false, error)
//            }
        }
        
        task.resume()
    }
    
    func getOpenOrders(completionHandler: @escaping (Bool, [MTInstantTradeStatus]?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: "\(API.tradingUrl)adminopenorders")!)
        request.httpMethod = "GET"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addAuthTokens()
        
//        do {
//            let encoder = JSONEncoder()
//            encoder.dateEncodingStrategy = .iso8601
//            let data = try encoder.encode(tokenRequest)
//            request.httpBody = data
//        } catch {
//            print(error)
//            completionHandler(false, nil, error)
//        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completionHandler(false, nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let orders = try decoder.decode([MTInstantTradeStatus].self, from: data)
                
                completionHandler(true, orders, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
        
        task.resume()
    }
    
    func getClosedOrders(completionHandler: @escaping (Bool, [MTInstantTradeStatus]?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: "\(API.tradingUrl)adminorderhistory")!)
        request.httpMethod = "GET"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addAuthTokens()
        
//        do {
//            let encoder = JSONEncoder()
//            encoder.dateEncodingStrategy = .iso8601
//            let data = try encoder.encode(tokenRequest)
//            request.httpBody = data
//        } catch {
//            print(error)
//            completionHandler(false, nil, error)
//        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completionHandler(false, nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let orders = try decoder.decode([MTInstantTradeStatus].self, from: data)
                
                completionHandler(true, orders, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
        
        task.resume()
    }
    
    func getTeamMembers(completionHandler: @escaping (Bool, [User]?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: "\(API.serverUrl)api/admin/teams/members")!)
        request.httpMethod = "GET"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addAuthTokens()
        
//        do {
//            let encoder = JSONEncoder()
//            encoder.dateEncodingStrategy = .iso8601
//            let data = try encoder.encode(tokenRequest)
//            request.httpBody = data
//        } catch {
//            print(error)
//            completionHandler(false, nil, error)
//        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completionHandler(false, nil, error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                completionHandler(false, nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let users = try decoder.decode([User].self, from: data)
                
                completionHandler(true, users, nil)
            } catch {
                print(error)
                completionHandler(false, nil, error)
            }
        }
        
        task.resume()
    }
}

struct LToken: Codable {
    var token: String!
}

struct AToken: Codable {
    var token: String!
}

struct PushRequest: Codable {
    var title: String?
    var subtitle: String?
    var body: String?
    var imageUrl: String?
    var productId: Int?
    var eventId: UUID?
}


struct AgoraTokenRequest: Codable {
    let uid: Int
    let channelName: String
    let role: Int
}

struct StreamTokenRequest: Codable {
    var username: String!
}

struct StreamJoinChannelRequest: Codable {
    var id: String!
    var userId: String!
}

struct UpdateStreamUserRequest: Codable {
    var id: String!
    var imageUrl: String!
    var language: String!
}

final class Object: Codable {
    static var Nil: Object? //this should never be set
}

extension URLRequest {
    mutating func addAuthTokens() {
        let lToken = try? Disk.retrieve("token", from: .applicationSupport, as: LToken.self)
        if let token = lToken?.token {
            print(token)
            addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}


