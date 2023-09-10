//
//  AppDelegate.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit
import StreamChat
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension ChatClient {
    static var shared: ChatClient!
    
    static var token: Token!
    
    static var loggedIn = false
    
    static func login() {
        /// you can grab your API Key from https://getstream.io/dashboard/
        let config = ChatClientConfig(apiKey: .init("rmhuh7ykksh7"))
        
        ChatClient.shared = ChatClient(config: config)
    }
    
    static func loginUser(completionHandler: @escaping (Error?) -> ()) {
        let tokenProvider: TokenProvider = { completion in
            API.sharedInstance.getStreamToken() { success, token, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                guard success, let token = token else {
                    print("error getting token")
                    return
                }
                
                do {
                    let token = try Token(rawValue: token.token)
                    
                    ChatClient.token = token
                    
                    completion(.success(token))

                } catch {
                    print(error)
                    print("error initializing Stream token")
                }
            }
        }
        
        
        ChatClient.shared.connectUser(userInfo: .init(id: Admin.current.id!.uuidString.uppercased(), name: Admin.current.displayName, imageURL: URL(string: Admin.current.profilePhotoUrl ?? "")), tokenProvider: tokenProvider) { error in
            if error == nil {
                ChatClient.loggedIn = true
            }
            completionHandler(error)
        }
    }
}
