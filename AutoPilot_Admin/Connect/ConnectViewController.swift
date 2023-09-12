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
    var teamMemberTableViewCell = "teamMemberTableViewCell"
    var teamMembersEmptyStateCell = "teamMembersEmptyStateCell"
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
    
    var activePaidTeamMembers: [[String]] = []//[["John Glaude", "6/1/23"], ["Dave Marooney", "6/1/23"], ["Asohka Tano", "6/1/23"]]

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
        let newNotiVC = NewNotificationViewController()
        self.present(newNotiVC, animated: true)
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
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if activePaidTeamMembers.count > 0 {
                return activePaidTeamMembers.count
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: connectChannelTableViewCell, for: indexPath) as! ConnectChannelTableViewCell
            //New
            cell.circleImageView.image = UIImage(named: "ttaIcon")
            
    //        if let url = URL(string: superGroupCIDs[indexPath.row][2]) {
                //cell.circleImageView.kf.setImage(with: url)
    //        }
            
            cell.chatNameLabel.text = "Community"
            cell.chatDescriptionLabel.text = "0 new messages"
            cell.newMessageBubble.alpha = 0
            return cell
        } else {
            if activePaidTeamMembers.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: teamMemberTableViewCell, for: indexPath) as! TeamMemberTableViewCell
                cell.chatNameLabel.text = activePaidTeamMembers[indexPath.row][0]
                let memberDate = activePaidTeamMembers[indexPath.row][1]
                cell.chatDescriptionLabel.text = "Member since: \(memberDate)"
                cell.circleImageView.image = UIImage(named: "enigmaUserPH")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: teamMembersEmptyStateCell, for: indexPath) as! TeamMembersEmptyStateCell
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        let titleLabel = UILabel()
        titleLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 18))
        titleLabel.textColor = .black
        titleLabel.text = "Team Members (\(activePaidTeamMembers.count))"
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return .createAspectRatio(value: 50)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return .createAspectRatio(value: 73)
        } else {
            if activePaidTeamMembers.count > 0 {
                return .createAspectRatio(value: 73)
            } else {
                return .createAspectRatio(value: 400)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lightImpactGenerator()
        
        if indexPath.section == 0 {
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
        } else {
            
        }
    }
    
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
