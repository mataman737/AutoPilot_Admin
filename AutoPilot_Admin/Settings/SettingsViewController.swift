//
//  SettingsViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import UIKit
import MessageUI
//import ZendeskSDKMessaging
//import ZendeskSDK
import PhotoCircleCrop
import WXImageCompress
import Disk
import SafariServices
import PWSwitch
import Kingfisher
import Lottie

protocol SettingsViewControllerDelegate: AnyObject {
    func didDismissSettings()
}

class SettingsViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    //var navBar = NavView()
    var loadingContainer = UIView()
    var loadingLottie = LottieAnimationView()
        
    weak var delegate: SettingsViewControllerDelegate?
    var isDarkMode = UserDefaults()
    var purpGradientBG = UIImageView()
    var enigmaEImageView = UIImageView()
    var mainFeedTableView = UITableView()
    var profileImageTableViewCell = "profileImageTableViewCell"
    var newClientsTableViewCell = "newClientsTableViewCell"
    var settingsTableViewCell = "settingsTableViewCell"
    var supportTableViewCell = "supportTableViewCell"
    var logoutTableViewCell = "logoutTableViewCell"
    var activePayoutSubscribersTableViewCell = "activePayoutSubscribersTableViewCell"
    var upgradeAccountTableViewCell = "upgradeAccountTableViewCell"
    var settingsSwitchImageTableViewCell = "settingsSwitchImageTableViewCell"
    var settingsSwitchTableViewCellTableViewCell = "settingsSwitchTableViewCellTableViewCell"
    
    var accountImages: [String] = ["appStack", "genLink", "atSign", "accessKey", "myFxBookIcon", "dollarSign"]
    var accountSettings: [String] = ["My Team App Link", "My Team Web Link", "", "", "MyFXBook", "Direct Deposit"]
    var notifications: [String] = ["Trade Won", "Trade Lost", "New Community Message", "New Team Member"]
    var socials: [String] = ["Facebook", "Youtube", "Instagram"]
    var socialsIcons: [String] = ["fbIcon", "ytIcon", "igIcon"]
    var support: [String] = ["Terms of Service", "Policies & Procedures", "Privacy Policy", "Refund Policy", "Income Disclosure Statement", "Subscription Terms and Conditions"/*, "Delete Account"*/]
    var newTradeNotificationEnabled = true
    var tradeWonNotificationEnabled = true
    var tradeLostNotificationEnabled = true
    var teamChatNotificationEnabled = true
        
    var team: Team?
    var teamAccessCode: String? {
        return team?.accessCode
    }
    var teamName: String? {
        return team?.name
    }
    
    var dismissArrowImageView = UIImageView()
    
    var textColor: UIColor = UIColor.white
    var upgradeHidden = true//false
        
    var photo: UIImage?
    
    var notFirstTimeInSettings = UserDefaults()
    var announcementsUpdateOn = UserDefaults()
    var eventsUpdateOn = UserDefaults()
    var newForexSignalOn = UserDefaults()
    var newCryptoSignalOn = UserDefaults()
    var signalThreadUpdateOn = UserDefaults()
    var accountType = "Admin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if accountType == "Admin" {
            accountImages = ["appStack", "genLink", "atSign", "accessKey", "myFxBookIcon", "dollarSign", "users15"]
            accountSettings = ["My Team App Link", "My Team Web Link", "", "", "MyFXBook", "Direct Deposit", "My Traders"]
        }
                
        isDarkMode.set(false, forKey: "isDarkMode")
        
        if notFirstTimeInSettings.bool(forKey: "notFirstTimeInSettings") {
            //Nada
        } else {
            notFirstTimeInSettings.set(true, forKey: "notFirstTimeInSettings")
            announcementsUpdateOn.set(true, forKey: "announcementsUpdateOn")
            eventsUpdateOn.set(true, forKey: "eventsUpdateOn")
            newForexSignalOn.set(true, forKey: "newForexSignalOn")
            newCryptoSignalOn.set(true, forKey: "newCryptoSignalOn")
            signalThreadUpdateOn.set(true, forKey: "signalThreadUpdateOn")
        }
        
        setupNav()
        setupTableView()
        setupLoadingIndicator()
        setupLaunchTransition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        edgesForExtendedLayout = UIRectEdge.all
        extendedLayoutIncludesOpaqueBars = true
        showTabBar()
        getCurrentTeam()
    }
    
    func getCurrentTeam() {
        API.sharedInstance.getCurrentTeam { success, team, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let team = team else {
                print("error getting team")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.team = team
                self?.mainFeedTableView.reloadData()
                self?.hideLoader()
            }
        }
    }
}

//MARK: ACTIONS ------------------------------------------------------------------------------------------------------------------------------------

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    @objc func hideLoader() {
        UIView.animate(withDuration: 0.5) {
            self.loadingContainer.alpha = 0
        } completion: { success in
            self.loadingContainer.isHidden = true
        }
    }
    
    @objc func didTapDeleteAccount() {
//        let profileLinkVC = SwipeDeleteAccountViewController()
//        profileLinkVC.modalPresentationStyle = .overFullScreen
//        self.present(profileLinkVC, animated: false, completion: nil)
    }
    
    @objc func didSwitchAnnouncementNoti() {
        /*
        lightImpactGenerator()
        if User.current.announcementNotiSetting == 1 {
            User.current.announcementNotiSetting = 0
        } else {
            User.current.announcementNotiSetting = 1
        }
        
        API.sharedInstance.updateUser(user: User.current, completionHandler: { success, user, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let user = user else {
                print("error getting user")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                User.current = user
                User.saveCurrentUser()
            }
        })
        */
    }
    
    @objc func didSwitchEventsUpdate() {
        lightImpactGenerator()
        /*
        if User.current.eventsNotiSetting == 1 {
            User.current.eventsNotiSetting = 0
        } else {
            User.current.eventsNotiSetting = 1
        }
        
        API.sharedInstance.updateUser(user: User.current, completionHandler: { success, user, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let user = user else {
                print("error getting user")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                User.current = user
                User.saveCurrentUser()
            }
        })
        */
    }
    
    @objc func didSwitchNewForexSignal() {
        lightImpactGenerator()
        /*
        if User.current.forexSignalNotiSetting == 1 {
            User.current.forexSignalNotiSetting = 0
        } else {
            User.current.forexSignalNotiSetting = 1
        }
        
        API.sharedInstance.updateUser(user: User.current, completionHandler: { success, user, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let user = user else {
                print("error getting user")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                User.current = user
                User.saveCurrentUser()
            }
        })
        */
    }
    
    @objc func didSwitchNewCryptoSignal() {
        /*
        if User.current.cryptoSignalNotiSetting == 1 {
            User.current.cryptoSignalNotiSetting = 0
        } else {
            User.current.cryptoSignalNotiSetting = 1
        }
        
        API.sharedInstance.updateUser(user: User.current, completionHandler: { success, user, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let user = user else {
                print("error getting user")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                User.current = user
                User.saveCurrentUser()
            }
        })
        */
    }
    
    @objc func didSwitchSignalThreadUpdate() {
        /*
        if User.current.signalThreadNotiSetting == 1 {
            User.current.signalThreadNotiSetting = 0
        } else {
            User.current.signalThreadNotiSetting = 1
        }
        
        API.sharedInstance.updateUser(user: User.current, completionHandler: { success, user, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let user = user else {
                print("error getting user")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                User.current = user
                User.saveCurrentUser()
            }
        })
        */
    }
    
    @objc func updateNotificationSetting(sender: PWSwitch) {
        switch sender.tag {
        case 0:
            if Admin.current.tradeWonNotiSetting == 1 {
                Admin.current.tradeWonNotiSetting = 0
            } else {
                Admin.current.tradeWonNotiSetting = 1
            }
        case 1:
            if Admin.current.tradeLostNotiSetting == 1 {
                Admin.current.tradeLostNotiSetting = 0
            } else {
                Admin.current.tradeLostNotiSetting = 1
            }
        case 2:
            if Admin.current.teamChatNotiSetting == 1 {
                Admin.current.teamChatNotiSetting = 0
            } else {
                Admin.current.teamChatNotiSetting = 1
            }
        default:
            if Admin.current.teamMemberNotiSetting == 1 {
                Admin.current.teamMemberNotiSetting = 0
            } else {
                Admin.current.teamMemberNotiSetting = 1
            }
        }
        
        API.sharedInstance.updateAdmin(admin: Admin.current) { success, admin, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let admin = admin else {
                print("error updating admin")
                return
            }
            
            DispatchQueue.main.async {
                Admin.current = admin
                Admin.saveCurrentAdmin()
                //self?.goToHome()
                //self?.fromLogin.set(true, forKey: "fromLogin")
                //self?.perform(#selector(self?.transitionHome), with: self, afterDelay: 0.5)
            }
        }
    }
    
    @objc func didSwitchLightDarkMode() {
        if isDarkMode.bool(forKey: "isDarkMode") {
            isDarkMode.set(false, forKey: "isDarkMode")
        } else {
            isDarkMode.set(true, forKey: "isDarkMode")
        }
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //return storyboard.instantiateInitialViewController()!
        //storyboard.instantiateViewController(withIdentifier: "MyTabBarController")
        self.view.isUserInteractionEnabled = false
        self.perform(#selector(reNew), with: self, afterDelay: 0.5)
    }
    
    @objc func reNew() {
        /*
        UIView.animate(withDuration: 0.35) {
            self.purpGradientBG.alpha = 1.0
        } completion: { success in
            //reload application data (renew root view )
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "MyTabBarController") as! MyTabBarController
            vc.setupSocket(autotrader: vc.isAutotrader)
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
        */
    }
    
    @objc func didTapPastResults() {
        /*
        lightImpactGenerator()
        let pastSignResultsVC = PastSignalsResultsViewController()
        pastSignResultsVC.modalPresentationStyle = .overFullScreen
        self.present(pastSignResultsVC, animated: true, completion: nil)
        */
    }
    
    @objc func presentUpdateTeamNamePhoto() {
        lightImpactGenerator()
        let updateTeamNamePhotoVC = UpdateTeamNameAndPhotoViewController()
        updateTeamNamePhotoVC.team = self.team
        updateTeamNamePhotoVC.delegate = self
        //updateTeamNamePhotoVC.teamNameTextField.text = teamName
        updateTeamNamePhotoVC.modalPresentationStyle = .overFullScreen
        self.present(updateTeamNamePhotoVC, animated: false)
    }
    
    @objc func presentUpdateAccessCode() {
        lightImpactGenerator()
        let updateAccessCodeVC = UpdateAccessCodeViewController()
        updateAccessCodeVC.team = self.team
        updateAccessCodeVC.delegate = self
        updateAccessCodeVC.accessCodeTextField.text = teamAccessCode
        updateAccessCodeVC.modalPresentationStyle = .overFullScreen
        self.present(updateAccessCodeVC, animated: false)
    }
    
    @objc  func presentBankDebitCard() {
        
    }
    
    @objc func presentMyTeamSettings() {
        lightImpactGenerator()
        let myTradersVC = MyTradersViewController()
        myTradersVC.modalPresentationStyle = .overFullScreen
        self.present(myTradersVC, animated: true, completion: nil)
    }
    
    @objc func dismissVC() {
        lightImpactGenerator()
        self.dismiss(animated: true, completion: nil)
        self.delegate?.didDismissSettings()
    }
    
    @objc func didTapLogout() {
        lightImpactGenerator()
        
        try? Disk.clear(.applicationSupport)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = vc
    }
    
    @objc func didTapTOS(cell: Int) {
        /*
        let eventSourceVC = EventSourceWebViewController()
        switch cell {
        case 1:
            eventSourceVC.urlString = "https://nvisionu.com/frontend/pdfs/NVU-Terms-Of-Use-Final.pdf"
        case 2:
            eventSourceVC.urlString = "https://nvisionu.com/frontend/pdfs/NVISIONU_Policies_Procedures-Final.pdf"
        case 3:
            eventSourceVC.urlString = "https://nvisionu.com/frontend/pdfs/NVU-Privacy-Policy-Final.pdf"
        case 4:
            eventSourceVC.urlString = "https://nvisionu.com/frontend/pdfs/NVISIONU-Refund-Policy-Final.pdf"
        case 5:
            eventSourceVC.urlString = "https://nvisionu.com/frontend/pdfs/NVU-Income-Disclsoure-Statement-Final.pdf"
        default:
            eventSourceVC.urlString = "https://nvisionu.com/frontend/pdfs/NVISIONU-Subscription-Terms-Final.pdf"
        }
        self.present(eventSourceVC, animated: true) {
            //
        }
        */
    }
    
    @objc func didTapSocial(cell: Int) {
        /*
        switch cell {
        case 1:
            var fbURL = "https://www.facebook.com/go.nvisionu/"
            if isNVUDemo.bool(forKey: "isNVUDemo") {
                fbURL = "https://www.facebook.com/go.nvisionu/"
            }
            guard let url = URL(string: fbURL)  else { return }
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            
        case 2:
            var youtubeURL = "https://www.youtube.com/channel/UCKgdNWdR3OOEhZ3cMa5dwJg"
            if isNVUDemo.bool(forKey: "isNVUDemo") {
                youtubeURL = "https://www.youtube.com/channel/UCKgdNWdR3OOEhZ3cMa5dwJg"
            }
            guard let url = URL(string: youtubeURL)  else { return }
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            
        default:
            var igURL = "https://instagram.com/go.nvisionu"//"https://instagram.com/stephen_mata_"
            if isNVUDemo.bool(forKey: "isNVUDemo") {
                igURL = "https://instagram.com/go.nvisionu"//"https://instagram.com/stephen_mata_"
            }
            guard let url = URL(string: igURL)  else { return } //
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        */
    }
    
    @objc func didTapFAQ() {
        //let faqVC = FAQViewController()
        //self.navigationController?.pushViewController(faqVC, animated: true)
        let toastNoti = ToastNotificationView()
        toastNoti.present(withMessage: "Please visit the website")
    }
    
    @objc func didTapDeposits() {
        //let payHistoryVC = PayHistoryViewController()
        //self.navigationController?.pushViewController(payHistoryVC, animated: true)
    }
    
    @objc func didTapPersonalInfo() {
        //let personalInfoVC = PersonalInfoViewController()
        //self.navigationController?.pushViewController(personalInfoVC, animated: true)
    }
    
    @objc func didTapPaymentHistory() {
        lightImpactGenerator()
        print("did this 😰😰😰")
        let paymentHistoryVC = PaymentHistoryViewController()
        //self.navigationController?.pushViewController(paymentHistoryVC, animated: true)
        
        paymentHistoryVC.modalPresentationStyle = .overFullScreen
        self.present(paymentHistoryVC, animated: true, completion: nil)
    }
    
    @objc func didTapMyFXBook() {
        lightImpactGenerator()
        let updateAccessCodeVC = SetMyFXBookLinkViewController()
        updateAccessCodeVC.team = self.team
        updateAccessCodeVC.delegate = self
        updateAccessCodeVC.modalPresentationStyle = .overFullScreen
        self.present(updateAccessCodeVC, animated: false)
    }
    
    @objc func didTapMyTeamAppLink() {
        lightImpactGenerator()
        let profileLinkVC = MyProfileLinkViewController()
        profileLinkVC.titleLabel.text = "My Team App Link"
        profileLinkVC.webAlias = "App_Link"
        profileLinkVC.modalPresentationStyle = .overFullScreen
        self.present(profileLinkVC, animated: false, completion: nil)
    }
    
    @objc func didTapMyTeamWebLink() {
        lightImpactGenerator()
        let profileLinkVC = MyProfileLinkViewController()
        profileLinkVC.titleLabel.text = "My Team Web Link"
        profileLinkVC.webAlias = "Web_Link"
        profileLinkVC.modalPresentationStyle = .overFullScreen
        self.present(profileLinkVC, animated: false, completion: nil)
    }
    
    @objc func didTapLanguage() {
        //let languageVC = PickLanguageViewController()
        //languageVC.modalPresentationStyle = .overFullScreen
        //self.present(languageVC, animated: false, completion: nil)
    }
    
    @objc func hitUsUp() {
        /*
        guard let viewController = Zendesk.instance?.messaging?.messagingViewController() else { return }
//        let customerSupportVC = CustomerSupportViewController()
        viewController.modalPresentationStyle = .automatic
        
        //self.present(viewController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(viewController, animated: true)
        */
    }
    
    @objc func didTapEmail() {
        /*
        let email = "foo@bar.com"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
        */
        let recipientEmail = "hello@bfxstandard.com.com"
        let subject = "Multi client email support"
        let body = "This code supports sending email via multiple different email apps on iOS! :)"
        
        // Show default mail composer
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            
            present(mail, animated: true)
            
            // Show third party email composer if default Mail app is not present
        } else {
            let email = "foo@bar.com"
            if let url = URL(string: "mailto:\(email)") {
              if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
              } else {
                UIApplication.shared.openURL(url)
              }
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}

extension SettingsViewController: SetMyFXBookLinkViewControllerDelegate {
    func didUpdateMyFXBookLink() {
        getCurrentTeam()
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE ------------------------------------------------------------------------------------------------------------------------------------

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return accountSettings.count
        } else if section == 2 {
            return notifications.count
        } else if section == 3 {
            return socials.count
        } else {
            return support.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: profileImageTableViewCell, for: indexPath) as! ProfileImageTableViewCell
                let profileImageTapped = UITapGestureRecognizer(target: self, action: #selector(replacePhotoClicked))
                cell.profileImageView.addGestureRecognizer(profileImageTapped)
                cell.dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
                cell.nameLabel.text = "Settings"
                
                cell.profileImageView.image = UIImage(named: "avatarph")
                cell.profileImageView.setImageColor(color: .newBlack)
                if let displayName = Admin.current.displayName {
                    cell.dateJoinedLabel.text = "\(accountType): \(displayName)"
                }
                //print("\(Admin.current.profilePhotoUrl) 🤬🤬🤬")
                
                if let adminPhoto = Admin.current.profilePhotoUrl {
                    if let url = URL(string: adminPhoto) {
                        cell.profileImageView.kf.setImage(with: url)
                        cell.profileImageView.contentMode = .scaleAspectFill
                        cell.profileImageView.isHidden = false
                    } else {
                        cell.profileImageView.isHidden = true
                        //cell.profilePHImageView.isHidden = false
                    }
                } else {
                    cell.profileImageView.isHidden = true
                    cell.profilePHImageView.isHidden = false
                }
                
                cell.dismissArrowImageView.setImageColor(color: textColor)
                cell.nameLabel.textColor = textColor
                cell.dateJoinedLabel.textColor = textColor.withAlphaComponent(0.5)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: activePayoutSubscribersTableViewCell, for: indexPath) as! ActivePayoutSubscribersTableViewCell
                cell.payoutLabel.text = "$39,400.00"
                cell.payoutDetailLabel.text = "Sep Payout"
                cell.subLabel.text = "280"
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingsTableViewCell, for: indexPath) as! SettingsTableViewCell
            cell.generalImageView.image = UIImage(named: accountImages[indexPath.row])
            cell.generalImageView.setImageColor(color: .newBlack)
            cell.titleLabel.textColor = .newBlack
            
            if indexPath.row == 2 {
                if teamName != nil {
                    cell.titleLabel.text = teamName
                    cell.titleLabel.textColor = .newBlack
                } else {
                    cell.titleLabel.text = "Add Team Name"
                    cell.titleLabel.textColor = .brightRed
                }
            } else if indexPath.row == 3 {
                if teamAccessCode != nil {
                    cell.titleLabel.text = teamAccessCode
                    cell.titleLabel.textColor = .newBlack
                } else {
                    cell.titleLabel.text = "Add Access Code"
                    cell.titleLabel.textColor = .brightRed
                }
            } else {
                cell.titleLabel.text = accountSettings[indexPath.row]
            }
            
            cell.dividerLine.backgroundColor = .newBlack.withAlphaComponent(0.12)
            cell.arrowImageView.setImageColor(color: .newBlack.withAlphaComponent(0.5))
            
            if indexPath.row == accountImages.count - 1 {
                cell.dividerLine.isHidden = true
            } else {
                cell.dividerLine.isHidden = false
            }
            
            cell.arrowImageView.setImageColor(color: .newBlack.withAlphaComponent(0.5))
            
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingsSwitchTableViewCellTableViewCell, for: indexPath) as! SettingsSwitchTableViewCellTableViewCell
            cell.pwSwitch.tag = indexPath.row
            cell.pwSwitch.addTarget(self, action: #selector(updateNotificationSetting(sender:)), for: .touchUpInside)
            cell.titleLabel.text = notifications[indexPath.row]
            cell.dividerLine.backgroundColor = .newBlack.withAlphaComponent(0.12)
            cell.titleLabel.textColor = .newBlack
            
            if indexPath.row == notifications.count - 1 {
                cell.dividerLine.isHidden = true
            } else {
                cell.dividerLine.isHidden = false
            }
            
            /*
            if indexPath.row == 0 {
                if newTradeNotificationEnabled {
                    cell.pwSwitch.setOn(true, animated: false)
                } else {
                    cell.pwSwitch.setOn(false, animated: false)
                }
            }
            */
            
            let user = Admin.current
            switch indexPath.row {
            case 0:
                cell.pwSwitch.setOn(user.tradeWonNotiSetting == 1, animated: false)
            case 1:
                cell.pwSwitch.setOn(user.tradeLostNotiSetting == 1, animated: false)
            case 2:
                cell.pwSwitch.setOn(user.teamChatNotiSetting == 1, animated: false)
            default:
                cell.pwSwitch.setOn(user.teamMemberNotiSetting == 1, animated: false)
            }
                        
                
            cell.arrowImageView.setImageColor(color: .newBlack.withAlphaComponent(0.5))
            
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingsTableViewCell, for: indexPath) as! SettingsTableViewCell
            cell.generalImageView.image = UIImage(named: socialsIcons[indexPath.row])
            cell.generalImageView.setImageColor(color: .newBlack)
            cell.titleLabel.text = socials[indexPath.row]
            cell.titleLabel.textColor = .newBlack
            cell.dividerLine.backgroundColor = .newBlack.withAlphaComponent(0.12)
            cell.arrowImageView.setImageColor(color: .newBlack.withAlphaComponent(0.5))
            
            if indexPath.row == socials.count - 1 {
                cell.dividerLine.isHidden = true
            } else {
                cell.dividerLine.isHidden = false
            }
            return cell
        } else {
            
            var supportArray = support
            if indexPath.row == supportArray.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: logoutTableViewCell, for: indexPath) as! LogoutTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: supportTableViewCell, for: indexPath) as! SupportTableViewCell
                cell.titleLabel.text = supportArray[indexPath.row]//.localiz()
                cell.titleLabel.textColor = .newBlack
                cell.dividerLine.backgroundColor = textColor.withAlphaComponent(0.1)
                cell.arrowImageView.setImageColor(color: .newBlack.withAlphaComponent(0.5))
                if indexPath.row == supportArray.count - 1 {
                    cell.dividerLine.isHidden = true
                } else {
                    cell.dividerLine.isHidden = false
                }
                
                cell.arrowImageView.setImageColor(color: .newBlack.withAlphaComponent(0.5))
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return .createAspectRatio(value: 110) //146
            } else {
                return .createAspectRatio(value: 136)
            }
        } else {
            return .createAspectRatio(value: 62)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let sectionTitleLabel = UILabel()
        sectionTitleLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 18))
        sectionTitleLabel.textColor = .newBlack
        sectionTitleLabel.textAlignment = .left
        sectionTitleLabel.numberOfLines = 0
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(sectionTitleLabel)
        sectionTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: .createAspectRatio(value: 22)).isActive = true
        sectionTitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
                        
        if section == 1 {
            sectionTitleLabel.text = "General"//.localiz()
        } else if section == 2 {
            sectionTitleLabel.text = "Notifications"//.localiz()
        } else if section == 3 {
            sectionTitleLabel.text = "Follow Us"//.localiz()
        } else {
            sectionTitleLabel.text = "Support"//.localiz()
        }
                
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            if section == 1 {
                return .createAspectRatio(value: 40)
            } else {
                return .createAspectRatio(value: 81)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                didTapPaymentHistory()
            }
        }
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                didTapMyTeamAppLink()
            case 1:
                didTapMyTeamWebLink()
            case 2:
                presentUpdateTeamNamePhoto()
            case 3:
                presentUpdateAccessCode()
            case 4:
                didTapMyFXBook()
            case 5:
                presentBankDebitCard()
            default:
                presentMyTeamSettings()
            }
        }
             
        if indexPath.section == 3 {
            switch indexPath.row {
            case 0:
                didTapSocial(cell: 1)
            case 1:
                didTapSocial(cell: 2)
            default:
                didTapSocial(cell: 3)
            }
        }
        
        if indexPath.section == 4 {
            switch indexPath.row {
            case 0:
                didTapTOS(cell: 1)
            case 1:
                didTapTOS(cell: 2)
            case 2:
                didTapTOS(cell: 3)
            case 3:
                didTapTOS(cell: 4)
            case 4:
                didTapTOS(cell: 5)
            case 5:
                didTapTOS(cell: 6)
                /*
            case 6:
                didTapDeleteAccount()
                */
            default:
                didTapLogout()
            }
        }
    }
}

//MARK: CIRCLE PHOTO DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension SettingsViewController: CircleCropViewControllerDelegate {
    @objc func replacePhotoClicked() {
        lightImpactGenerator()
        
        ImagePickerManager().pickImage(self){ image in
            if let image = image {
                self.pickedImage(image: image)
            } else {
                print("no photo retrieved")
            }
        }
    }
    
    func pickedImage(image: UIImage) {
        self.photo = image
        let circleCropController = CircleCropViewController()
        circleCropController.delegate = self
        circleCropController.image = image
        self.present(circleCropController, animated: true, completion: nil)
    }
    
    func circleCropDidCancel() {
        print("User canceled the crop flow")
    }
    
    func circleCropDidCropImage(_ image: UIImage) {
        self.photo = image.wxCompress()
        uploadImage()
    }
    
    func uploadImage() {
        guard let photo = self.photo else {
            print("photo is nil, can't upload")
            return
        }
    }
}

//MARK: UPDATE TEAM NAME PHOTO DELEGATE, UPDATE ACCESS CODE DELEGATE

extension SettingsViewController: UpdateTeamNameAndPhotoViewControllerDelegate, UpdateAccessCodeViewControllerDelegate {
    func didUpdateAccessCode() {
        getCurrentTeam()
    }
    
    func didUpdateTeamNamePhoto() {
        getCurrentTeam()
    }
}
