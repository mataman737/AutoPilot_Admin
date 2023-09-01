//
//  ConnectViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/27/23.
//

import UIKit
import StreamChat
import StreamChatUI
import Lottie

class ConnectViewController: UIViewController {
    
    var loadingContainer = UIView()
    var loadingLottie = LottieAnimationView()
    var navHeight: CGFloat = 90
    var navView = UIView()
    var backImageView = UIImageView()
    var backButton = UIButton()
    var titleLabel = UILabel()
    var dividerLine = UIView()
    var plusImageView = UIImageView()
    var plusButton = UIButton()
    var editRowsImageView = UIImageView()
    var editRowsButton = UIButton()
    var bellImageView = UIImageView()
    var bellButton = UIButton()
    var discoverTableView = UITableView()
    var connectChannelTableViewCell = "connectChannelTableViewCell"
    var superGroupCIDs: [[String]] = [
        [ "MainSuperGroup"],
    ]
    var communityUnreadCount: Int = 0
    var supportnreadCount: Int = 0
    var cryptoUnreadCount: Int = 0
    var forexUnreadCount: Int = 0
    var topLeadersUnreadCount: Int = 0
    var signalsUnreadCount: Int = 0
    
    var commmunityDone = false
    var supportDone = false
    var cryptoDone = false
    var forexDone = false
    var topLeadersDone = false
    
    var rewardsImageView = UIImageView()
    var rewardsButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ChatClient.loginUser()
        checkUnreadCount()
        
        modifyConstraints()
        setupNav()
        setupTableView()
        //setupLoadingIndicator()
        
        self.perform(#selector(self.hideLoader), with: self, afterDelay: 0.5)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        ChatClient.loginUser { error in
            print("🤌🤌🤌 111")
            guard error == nil else {
                //print(error!)
                print("\(error!) 🤌🤌🤌 222")
                return
            }
        }
        
        /*
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in
            if let error = error {
                print("D'oh: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    center.delegate = appDelegate.notificationDelegate
                    let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("Open", comment: ""), options: UNNotificationActionOptions.foreground)
                    let deafultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
                    center.setNotificationCategories(Set([deafultCategory]))
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        API.sharedInstance.joinSupergroups { success, _, error in
            guard error == nil else {
                print("\(error!) 👅👅👅")
                
                return
            }
            
            guard success else {
                print("error joining supergroups")
                return
            }
        }
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkUnreadCount()
        loadingLottie.play()
    }
    
    func checkUnreadCount() {
        /*
        ChatClient.loginUser { error in
            print("🤌🤌🤌 111")
            guard error == nil else {
                //print(error!)
                print("\(error!) 🤌🤌🤌 222")
                return
            }
            do {
                let id = try ChannelId(cid: "gaming:NVU_Forex")
                let controller = ChatClient.shared.channelController(for: id)
                controller.synchronize { error in
                    guard error == nil else {
                        //print(error!)
                        print("\(error!) 🤌🤌🤌 333")
                        return
                    }
                    self.forexUnreadCount = controller.channel?.unreadCount.messages ?? 0
                    self.discoverTableView.reloadData()
                    print("forex: \(controller.channel?.unreadCount.messages ?? 0) 😡😡😡 \(self.forexUnreadCount)")
                    
                    self.forexDone = true
                    
                    //if self.forexDone && self.supportDone && self.cryptoDone && self.commmunityDone && self.topLeadersDone {
                        self.perform(#selector(self.hideLoader), with: self, afterDelay: 0.5)
                    //}
                    
                }
            } catch {
                print(error)
            }
        }
        */
    }
    
    @objc func hideLoader() {
        UIView.animate(withDuration: 0.5) {
            self.loadingContainer.alpha = 0
        } completion: { success in
            //self.loadingContainer.isHidden = true
        }
    }
}

//MARK ACTIONS

extension ConnectViewController {
    @objc func didTapNotiBell() {
        lightImpactGenerator()
        //let notiBFX = NotificationsViewController()
        //self.present(notiBFX, animated: true)
    }
    
    @objc func createNewEvent() {
        lightImpactGenerator()
//        let pickResVC = PickLiveTypeViewController()
//        pickResVC.delegate = self
//        pickResVC.modalPresentationStyle = .overFullScreen
//        self.present(pickResVC, animated: false) { }
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE

extension ConnectViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//superGroupCIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: connectChannelTableViewCell, for: indexPath) as! ConnectChannelTableViewCell
        //New
        //cell.circleImageView.image = UIImage(named: "gradient\(indexPath.row)")
        
//        if let url = URL(string: superGroupCIDs[indexPath.row][2]) {
            //cell.circleImageView.kf.setImage(with: url)
//        }
        
        cell.chatNameLabel.text = "Main Super Group"//superGroupCIDs[indexPath.row][0]
        cell.chatDescriptionLabel.text = "0 new messages"
        cell.newMessageBubble.alpha = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .createAspectRatio(value: 73)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lightImpactGenerator()
//        let idString = superGroupCIDs[indexPath.row][1]
        do {
            let id = try ChannelId(cid: "gaming:MainSuperGroup")
            let channelVC = CustomChatChannelVC()
            channelVC.chatChannelDelegate = self
            channelVC.channelController = ChatClient.shared.channelController(for: id)
            
            DispatchQueue.main.async { [weak self] in
                let nav = UINavigationController(rootViewController: channelVC)
                self?.present(nav, animated: true, completion: {
//                    API.sharedInstance.updateAdmin(admin: Admin.current) { success, admin, error in
//                        guard error == nil else {
//                            print(error!)
//                            return
//                        }
//                        
//                        guard success, let _ = admin else {
//                            print("error updating admin")
//                            return
//                        }
//                    }
                })
            }
        } catch {
            print(error)
        }
    }
    
    /*
    func goToPrivateChat(chat: PrivateChat) {
        let idString = "privateChat\(chat.id!.uuidString)"

        do {
            let id = try ChannelId(cid: idString)
            
            let channelVC = CustomChatChannelVC()
            channelVC.chatChannelDelegate = self
            channelVC.channelController = ChatClient.shared.channelController(for: id)
            channelVC.messageComposerVC.composerView.isUserInteractionEnabled = false
            
            DispatchQueue.main.async { [weak self] in
                let nav = UINavigationController(rootViewController: channelVC)
                self?.present(nav, animated: true, completion: nil)
            }
        } catch {
            print(error)
        }
    }
    */
    
}

//MARK CUSTOM CHAT DELEGATE
/*
extension ConnectViewController: CustomChatChannelVCDelegate {
    func didCloseChannel() {
        checkUnreadCount()
    }
}
*/

//MARK: PICK TYPE DELEGATE ------------------------------------------------------------------------------------------------------------------------------------
/*
extension ConnectViewController: PickLiveTypeViewControllerDelegate {
    func didPickLiveType(type: String) {
        if type == "Drop" {
            //let newEventVC = FutureDropDetailViewController()
            //newEventVC.delegate = self
            //newEventVC.navTitleLabel.text = "New Drop"
            //self.navigationController?.pushViewController(newEventVC, animated: true)
        } else if type == "Live Now" {
            print("did this 😉😉😉 000")
            let newEventVC = GoLiveDetailViewController()
            //newEventVC.delegate = self
            newEventVC.modalPresentationStyle = .overFullScreen
            newEventVC.navTitleLabel.text = "Go Live"
            self.present(newEventVC, animated: true)
            //self.navigationController?.pushViewController(newEventVC, animated: true)
        }
    }
}
*/

//MARK CUSTOM CHAT DELEGATE

extension ConnectViewController: CustomChatChannelVCDelegate {
    func didCloseChannel() {
        checkUnreadCount()
    }
}
