//
//  CommunityViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/27/23.
//

import UIKit
import StreamChat
import StreamChatUI
import Lottie

class CommunityViewController: UIViewController {
    
    var loadingContainer = UIView()
    var loadingLottie = LottieAnimationView()
    var navView = UIView()
    var backImageView = UIImageView()
    var titleLabel = UILabel()
    var dividerLine = UIView()
    var bellImageView = UIImageView()
    var bellButton = UIButton()
    var mainfeedTableView = UITableView()
    var connectChannelTableViewCell = "connectChannelTableViewCell"
    var teamMemberTableViewCell = "teamMemberTableViewCell"
    var teamMembersEmptyStateCell = "teamMembersEmptyStateCell"
    var superGroupCIDs: [[String]] = [
        [ "MainSuperGroup"],
    ]
    var teamPhotoString = ""
    var rewardsImageView = UIImageView()
    var rewardsButton = UIButton()
    var members = [UserWithBalanceRecord]()
    var paidMembers = [UserWithBalanceRecord]()
    var unpaidMembers = [UserWithBalanceRecord]()
    
    var traders = [Admin]()
    
    var didGetTeamMembers = false
    var didGetCurrentTeam = false
    var supergroupUnreadCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)                
        
        //ChatClient.loginUser()
        modifyConstraints()
        setupNav()
        setupTableView()
        setupLoadingIndicator()
                
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        ChatClient.loginUser { error in
            //print("🤌🤌🤌 111")
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
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeround), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //checkUnreadCount()
        loadingLottie.play()
        getUnreadCount()
        getTeamMembers()
        //getTeamTraders()
        getCurrentTeam()
        
        getLotsMetrics()
        getSubMetrics()
        getUserPayments()
    }
    
    @objc func appMovedToForeround() {
        getUnreadCount()
    }
    
    @objc func hideLoader() {
        UIView.animate(withDuration: 0.5) {
            self.loadingContainer.alpha = 0
        } completion: { success in
            //self.loadingContainer.isHidden = true
        }
    }
    
    func getCurrentTeam() {
        API.sharedInstance.getCurrentTeam { success, team, error in
            guard error == nil else {
                print("\(error!) 🤑🤑🤑")
                return
            }
            
            guard success, let team = team else {
                print("error getting team")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                if let teamPhoto = team.photo {
                    self?.teamPhotoString = teamPhoto
                }
                self?.mainfeedTableView.reloadData()
                
                self?.didGetCurrentTeam = true
                if self?.didGetCurrentTeam == true && self?.didGetTeamMembers == true {
                    self?.perform(#selector(self?.hideLoader), with: self, afterDelay: 0.5)
                }
            }
        }
    }
    
    func getTeamMembers() {
        API.sharedInstance.getTeamMembers { success, users, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let users = users else {
                print("error getting users")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.members = users
                
                self?.paidMembers = users
                    .filter({$0.user.isSubscribed == true} )
                
                self?.unpaidMembers = users
                    .filter({$0.user.isSubscribed == false} )
                
                
                print("\(self?.paidMembers.count) 💩💩💩 000")
                print("\(self?.unpaidMembers.count) 💩💩💩 111")
                
                self?.mainfeedTableView.reloadData()
                
                self?.didGetTeamMembers = true
                if self?.didGetCurrentTeam == true && self?.didGetTeamMembers == true {
                    self?.perform(#selector(self?.hideLoader), with: self, afterDelay: 0.5)
                }
                
            }
        }
    }
    
    func getLotsMetrics() {
        API.sharedInstance.getLotsMetrics { success, metrics, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let metrics = metrics else {
                print("error getting lots metrics")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("Today's lots: \(metrics.todaysLots)")
                print("This week's lots: \(metrics.thisWeeksLots)")
                print("Last week's lots: \(metrics.lastWeeksLots)")
                print("This months's lots: \(metrics.thisMonthsLots)")
            }
        }
    }
    
    func getSubMetrics() {
        API.sharedInstance.getSubMetrics { success, metrics, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let metrics = metrics else {
                print("error getting sub metrics")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("Free count: \(metrics.freeCount)")
                print("Paid count: \(metrics.paidCount)")
                print("Historical count: \(metrics.historicalCount)")
            }
        }
    }
    
    func getUserPayments() {
        API.sharedInstance.getUserPayments { success, payments, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let payments = payments else {
                print("error getting user payments")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("Payments count: \(payments.count)")
            }
        }
    }
    
    /*
    func getTeamTraders() {
        API.sharedInstance.getTeamTraders { success, traders, error in
            guard error == nil else {
                print(error!)
                print("\(error!) 😶‍🌫️😶‍🌫️😶‍🌫️ 000")
                return
            }
            
            guard success, let traders = traders else {
                print("error getting traders 😶‍🌫️😶‍🌫️😶‍🌫️ 111")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.traders = traders
                print("\(traders.count) did this 😶‍🌫️😶‍🌫️😶‍🌫️ 222 \n\(traders[0])")
                for trader in traders {
                    print("\(trader.displayName) 😶‍🌫️😶‍🌫️😶‍🌫️ \(trader.adminType)")
                }
                //Stephen, do your thing here
            }
        }
    }
    */
    
    /*
    func getUnreadCount() {
        ChatClient.loginUser { error in
            guard error == nil else {
                print(error!) // Print the error if login fails
                return
            }
            
            do {
                let id = try ChannelId(cid: "gaming:team\(Admin.current.teamId!.uppercased())")
                let channelController = ChatClient.shared.channelController(for: id)
                
                channelController.synchronize { error in
                    guard error == nil else {
                        return // Skip to the next channel if synchronization fails
                    }
                    
                    if let unreadCount = channelController.channel?.unreadCount.messages {
                        self.supergroupUnreadCount = unreadCount //5
                        print("📬📬📬 \(unreadCount)")
                        
                        //self.myTraderDetailLabel.text = unreadCount == 1 ? "\(unreadCount) new message" : "\(unreadCount) new messages"
                    } else {
                        print("📬📬📬 111")
                    }
                    
                    // Update UI on the main thread
                    DispatchQueue.main.async { [weak self] in
                        //self?.updateUI() // Call the updateUI function to refresh the collection view
                        self?.mainfeedTableView.reloadData()
                    }
                }
            } catch {
                print("\(error) 🐔🐔🐔") // Print the error if an exception occurs while fetching the channel ID
            }
        }
    }
    */
    
    func getUnreadCount() {
        ChatClient.loginUser { error in
            guard error == nil else {
                print(error!) // Print the error if login fails
                return
            }
            
            do {
                //let id = try ChannelId(cid: "gaming:team\(User.current.teamId!.uuidString)")
                let id = try ChannelId(cid: "gaming:team\(Admin.current.teamId!.uppercased())")
                let channelController = ChatClient.shared.channelController(for: id)
                
                channelController.synchronize { error in
                    guard error == nil else {
                        return // Skip to the next channel if synchronization fails
                    }
                    
                    if let unreadCount = channelController.channel?.unreadCount.messages {
                        //self.supergroupUnreadCount = unreadCount
                        print("📬📬📬 000 : \(unreadCount)")
                        var messageString = unreadCount == 1 ? "new message" : "new messages"
                        //self.myTraderDetailLabel.text = "\(unreadCount) \(messageString)"//unreadCount == 1 ? "\(unreadCount) new message" : "\(unreadCount) new messages"
                    } else {
                        print("📬📬📬 111")
                    }
                    
                    // Update UI on the main thread
                    DispatchQueue.main.async { [weak self] in
                        //self?.updateUI()
                        print("📬📬📬 333 : \(channelController.channel?.unreadCount.messages)")
                    }
                }
            } catch {
                print("\(error) 🐔🐔🐔") // Print the error if an exception occurs while fetching the channel ID
            }
        }
    }
}

//MARK ACTIONS

extension CommunityViewController {
    @objc func didTapNotiBell() {
        lightImpactGenerator()
        let newNotiVC = NewNotificationViewController()
        self.present(newNotiVC, animated: true)
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if paidMembers.count > 0 {
                return paidMembers.count
            } else {
                return 1
            }
        } else {
            if unpaidMembers.count > 0 {
                return unpaidMembers.count
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: connectChannelTableViewCell, for: indexPath) as! ConnectChannelTableViewCell
            if teamPhotoString != "" {
                if let url = URL(string: teamPhotoString) {
                    cell.circleImageView.kf.setImage(with: url)
                } else {
                    cell.circleImageView.image = UIImage(named: "enigmaUserPH")
                }
            } else {
                cell.circleImageView.image = UIImage(named: "enigmaUserPH")
            }
            
            cell.chatNameLabel.text = "Community"
            cell.chatDescriptionLabel.text = supergroupUnreadCount == 1 ? "\(supergroupUnreadCount) new message" : "\(supergroupUnreadCount) new messages"
            cell.newMessageBubble.alpha = 0
            return cell
        } else if indexPath.section == 1 {
            if paidMembers.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: teamMemberTableViewCell, for: indexPath) as! TeamMemberTableViewCell
                
                let member = paidMembers[indexPath.row].user
                
                print("\(member.isSubscribed) 🤢🤢🤢")
                
                cell.chatNameLabel.text = "\(member.firstName ?? "") \(member.lastName ?? "")"
                if let joinDate = member.teamJoinDate {
                    cell.chatDescriptionLabel.text = "Member since: \(convertToDateFormatted(joinDate))"
                } else {
                    cell.chatDescriptionLabel.text = "No join date"
                }
                
                if let urlString = member.profilePhotoUrl, let url = URL(string: urlString) {
                    cell.circleImageView.kf.setImage(with: url)
                } else {
                    cell.circleImageView.image = UIImage(named: "enigmaUserPH")
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: teamMembersEmptyStateCell, for: indexPath) as! TeamMembersEmptyStateCell
                cell.emptyStateLabel.text = "No paid members"
                return cell
            }
        } else {
            if unpaidMembers.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: teamMemberTableViewCell, for: indexPath) as! TeamMemberTableViewCell
                
                let member = unpaidMembers[indexPath.row].user
                
                print("\(member.isSubscribed) 🤢🤢🤢")
                
                cell.chatNameLabel.text = "\(member.firstName ?? "") \(member.lastName ?? "")"
                if let joinDate = member.teamJoinDate {
                    cell.chatDescriptionLabel.text = "Member since: \(convertToDateFormatted(joinDate))"
                } else {
                    cell.chatDescriptionLabel.text = "No join date"
                }
                
                if let urlString = member.profilePhotoUrl, let url = URL(string: urlString) {
                    cell.circleImageView.kf.setImage(with: url)
                } else {
                    cell.circleImageView.image = UIImage(named: "enigmaUserPH")
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: teamMembersEmptyStateCell, for: indexPath) as! TeamMembersEmptyStateCell
                cell.emptyStateLabel.text = "No unpaid members"
                return cell
            }
        }
    }
    
    func convertToDateFormatted(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/d/yy"
        
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        let titleLabel = UILabel()
        titleLabel.font = .poppinsSemiBold(ofSize: .createAspectRatio(value: 18))
        titleLabel.textColor = .black
        if section == 1 {
            titleLabel.text = "Paid Members: \(paidMembers.count)"
        } else {
            titleLabel.text = "Unpaid Members: \(unpaidMembers.count)"
        }
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
        } else if indexPath.section == 1 {
            if paidMembers.count > 0 {
                return .createAspectRatio(value: 73)
            } else {
                return .createAspectRatio(value: 73)
            }
        } else {
            if unpaidMembers.count > 0 {
                return .createAspectRatio(value: 73)
            } else {
                return .createAspectRatio(value: 73)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lightImpactGenerator()
        
        if indexPath.section == 0 {
            do {
                print("\(Admin.current.teamId!) 🧠🧠🧠")
                let id = try ChannelId(cid: "gaming:team\(Admin.current.teamId!.uppercased())")
                let channelVC = CustomChatChannelVC()
                channelVC.chatChannelDelegate = self
                channelVC.channelController = ChatClient.shared.channelController(for: id)
                
                DispatchQueue.main.async { [weak self] in
                    let nav = UINavigationController(rootViewController: channelVC)
                    
                    let completionHandler: (() -> Void) = {
                        self?.supergroupUnreadCount = 0
                        self?.mainfeedTableView.reloadData()
                    }
                    
                    self?.present(nav, animated: true, completion: completionHandler)
                    
                }
            } catch {
                print(error)
            }
        } else {
            
            
            if (indexPath.section == 1 ? paidMembers.count : unpaidMembers.count) > 0 {
                var member = unpaidMembers[indexPath.row].user
                if indexPath.section == 1 {
                    member = paidMembers[indexPath.row].user
                }
//            }
//            if members.count > 0 {
                lightImpactGenerator()
                let trainingOptionVC = TeamMemberOptionsViewController()
                trainingOptionVC.navTitleLabel.text = "\(member.firstName ?? "") \(member.lastName ?? "")"
                trainingOptionVC.dateLabel.text = ""
                //print("🔥🔥🔥 \(members[indexPath.row].balanceRecord) 🔥🔥🔥")
                if let memberPhone = member.phone {
                    trainingOptionVC.phoneNumber = memberPhone
                }
                trainingOptionVC.modalPresentationStyle = .overFullScreen
                self.present(trainingOptionVC, animated: false)
            }
        }
    }
}

//GENERATE RANDOM NAMES

extension CommunityViewController {
    func generateRandomFullName() -> String {
        let firstNames = ["John", "Emma", "Liam", "Olivia", "Noah", "Ava", "William", "Sophia", "James", "Isabella"]
        let lastNames = ["Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor"]
        
        let randomFirstNameIndex = Int.random(in: 0..<firstNames.count)
        let randomLastNameIndex = Int.random(in: 0..<lastNames.count)
        
        let firstName = firstNames[randomFirstNameIndex]
        let lastName = lastNames[randomLastNameIndex]
        
        return "\(firstName) \(lastName)"
    }

    // Function to generate a random US telephone number
    func generateRandomPhoneNumber() -> String {
        let areaCode = String(format: "%03d", Int.random(in: 0..<999))
        let prefix = String(format: "%03d", Int.random(in: 0..<999))
        let line = String(format: "%04d", Int.random(in: 0..<9999))
        return "\(areaCode)-\(prefix)-\(line)"
    }
    
    /*
    func generateRandomProduct() -> String {
        let products = ["FL2.0", "Power 7 Pack"]
        let randomIndex = Int.random(in: 0..<products.count)
        return products[randomIndex]
    }
    */
    
    func generateRandomDateWithinLastThreeMonths() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let threeMonthsAgo = calendar.date(byAdding: .month, value: -3, to: currentDate)!
        
        let randomTimeInterval = TimeInterval.random(in: threeMonthsAgo.timeIntervalSince1970...currentDate.timeIntervalSince1970)
        let randomDate = Date(timeIntervalSince1970: randomTimeInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        
        return dateFormatter.string(from: randomDate)
    }

    // Function to generate a random number between 1 and 12
    func generateRandomNumber() -> Int {
        return Int.random(in: 1...12)
    }
}

//MARK: CUSTOM CHAT DELEGATE

extension CommunityViewController: CustomChatChannelVCDelegate {
    func didCloseChannel() {
        getUnreadCount()
    }
}
