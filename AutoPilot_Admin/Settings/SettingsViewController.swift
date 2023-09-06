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
    
    var isNVUDemo = UserDefaults()
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
    var upgradeAccountTableViewCell = "upgradeAccountTableViewCell"
    var settingsSwitchImageTableViewCell = "settingsSwitchImageTableViewCell"
    var settingsSwitchTableViewCellTableViewCell = "settingsSwitchTableViewCellTableViewCell"
    
    var accountImages: [String] = ["genLink", "genLink", "accessKey"] //dollardarkinactive //genBox
    var accountSettings: [String] = ["My Team App Link", "My Team Web Link", "Access Code: SlimJim"]
    var notifications: [String] = ["Announcements Update", "Events Update", "Livestream"]
    var socials: [String] = ["Facebook", "Youtube", "Instagram"]
    var socialsIcons: [String] = ["fbIcon", "ytIcon", "igIcon"]
    var support: [String] = ["Terms of Service", "Policies & Procedures", "Privacy Policy", "Refund Policy", "Delete Account"]
    var supportNVU: [String] = ["Terms of Service", "Policies & Procedures", "Privacy Policy", "Refund Policy", "Income Disclosure Statement", "Subscription Terms and Conditions", "Delete Account"]
    
    var dismissArrowImageView = UIImageView()
    
    var textColor: UIColor = UIColor.white
    var upgradeHidden = true//false
    
    //var accountDetails: AccountDetails?
    //var userInfo: UserInfo?
    var photo: UIImage?
    
    var notFirstTimeInSettings = UserDefaults()
    var announcementsUpdateOn = UserDefaults()
    var eventsUpdateOn = UserDefaults()
    var newForexSignalOn = UserDefaults()
    var newCryptoSignalOn = UserDefaults()
    var signalThreadUpdateOn = UserDefaults()
    //var nvuAccountInfo: NVUAccountInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
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
        setupLaunchTransition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        edgesForExtendedLayout = UIRectEdge.all
        extendedLayoutIncludesOpaqueBars = true
                
        //navigationController?.navigationBar.isHidden = true
        //tabBarController?.tabBar.shadowImage = UIImage()
        //tabBarController?.tabBar.backgroundImage = UIImage()
        //tabBarController?.tabBar.clipsToBounds = true
        //extendedLayoutIncludesOpaqueBars = true
        
        showTabBar()
    }

}

//MARK: ACTIONS ------------------------------------------------------------------------------------------------------------------------------------

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    @objc func didTapWeAreBFX() {
        lightImpactGenerator()
        /*
        if #available(iOS 15.0, *) {
            let weAreBFXVC = WeAreBFXViewController()
            if let edgeRank = self.accountDetails?.result?.edgeRank.current {
                weAreBFXVC.rank = edgeRank
            }
            //weAreBFXVC.originalImageView.kf.setImage(with: "")
            self.present(weAreBFXVC, animated: true)
        } else {
            // Fallback on earlier versions
        }
        */
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
    
    @objc func didTapMyOrders() {
        lightImpactGenerator()
                
        if isNVUDemo.bool(forKey: "isNVUDemo") {
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "Links required")
        } else {
            if let url = URL(string: "https://office.bfxstandard.com/v1/myCompensationPayout/") { //https://office.bfxstandard.com/v1/myCompensationPayout/   //https://office.bfxstandard.com/v1/myOrderStatus/
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
        }
    }
    
    @objc func dismissVC() {
        lightImpactGenerator()
        self.dismiss(animated: true, completion: nil)
        self.delegate?.didDismissSettings()
    }
    
    /*
    @objc func didTapUpgradeAccount() {
        let upgradeAccVC = UpgradeAccountViewController()
        //upgradeAccVC.modalPresentationStyle = .overFullScreen
        self.present(upgradeAccVC, animated: true, completion: nil)
    }
    */
    
    @objc func didTapUpgradeAccount() {
        /*
        let eventSourceVC = EventSourceWebViewController()
        eventSourceVC.urlString = "https://office.enigmanetwork.io/v1/AccountUpgrade/"
        self.present(eventSourceVC, animated: true) {
            //
        }
        */
        if let url = URL(string: "https://office.bfxstandard.com/v1/AccountUpgrade/") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    @objc func didTapLogout() {
        lightImpactGenerator()
        
        try? Disk.clear(.applicationSupport)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SplashTwoViewController") as! SplashTwoViewController
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
    
    @objc func showFreshDeck() {
        let toastNoti = ToastNotificationView()
        toastNoti.present(withMessage: "Link required")
    }
    
    @objc func didTapSocial(cell: Int) {
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
    
    @objc func didTapLink() {
        lightImpactGenerator()
        
        /*
        let toastNoti = ToastNotificationView()
        toastNoti.present(withMessage: "Coming soon")
        */
        
        let profileLinkVC = MyProfileLinkViewController()
        profileLinkVC.webAlias = "holachola"
        profileLinkVC.modalPresentationStyle = .overFullScreen
        self.present(profileLinkVC, animated: false, completion: nil)
        
        
        /*
        let urlString = "https://qrco.de/be0IjS"
        let items = [URL(string: urlString)]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        self.present(ac, animated: true)
        */
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

//MARK: TABLEVIEW DELEGATE & DATASOURCE ------------------------------------------------------------------------------------------------------------------------------------

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return accountSettings.count
        } else if section == 2 {
            return notifications.count
        } else if section == 3 {
            return socials.count
        } else {
            return supportNVU.count + 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: profileImageTableViewCell, for: indexPath) as! ProfileImageTableViewCell
            let profileImageTapped = UITapGestureRecognizer(target: self, action: #selector(replacePhotoClicked))
            cell.profileImageView.addGestureRecognizer(profileImageTapped)
            cell.dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
            cell.nameLabel.text = "Settings"
            
            cell.profileImageView.image = UIImage(named: "avatarph")
            cell.profileImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white : .newBlack)
            cell.dateJoinedLabel.text = "johngalt@gmail.com"
            
                cell.dismissArrowImageView.setImageColor(color: textColor)
            cell.nameLabel.textColor = textColor
            cell.dateJoinedLabel.textColor = textColor.withAlphaComponent(0.5)
            return cell
        } else if indexPath.section == 1 {
            //if indexPath.row != accountSettings.count - 1 {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: settingsTableViewCell, for: indexPath) as! SettingsTableViewCell
                cell.generalImageView.image = UIImage(named: accountImages[indexPath.row])
                cell.generalImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white : .newBlack)
                cell.titleLabel.text = accountSettings[indexPath.row]//.localiz()
                cell.titleLabel.textColor = isDarkMode.bool(forKey: "isDarkMode") ? .white : .newBlack
                cell.dividerLine.backgroundColor = isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.12) : .newBlack.withAlphaComponent(0.12)
                cell.arrowImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.5) : .newBlack.withAlphaComponent(0.5))
                
                if indexPath.row == accountImages.count - 1 {
                    cell.dividerLine.isHidden = true
                } else {
                    cell.dividerLine.isHidden = false
                }
                
                cell.arrowImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.5) : .newBlack.withAlphaComponent(0.5))
                
                return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingsSwitchTableViewCellTableViewCell, for: indexPath) as! SettingsSwitchTableViewCellTableViewCell
            cell.titleLabel.text = notifications[indexPath.row]//.localiz()
            cell.dividerLine.backgroundColor = isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.12) : .newBlack.withAlphaComponent(0.12)//.newBlack.withAlphaComponent(0.12)
            cell.titleLabel.textColor = isDarkMode.bool(forKey: "isDarkMode") ? .white : .newBlack
            
            if indexPath.row == notifications.count - 1 {
                cell.dividerLine.isHidden = true
            } else {
                cell.dividerLine.isHidden = false
            }
            
            /*
            if indexPath.row == 0 {
                if User.current.announcementNotiSetting == 1 {
                    cell.pwSwitch.setOn(true, animated: false)
                } else {
                    cell.pwSwitch.setOn(false, animated: false)
                }
                cell.pwSwitch.addTarget(self, action: #selector(didSwitchAnnouncementNoti), for: .valueChanged)
            } else if indexPath.row == 1 {
                if User.current.eventsNotiSetting == 1 {
                    cell.pwSwitch.setOn(true, animated: false)
                } else {
                    cell.pwSwitch.setOn(false, animated: false)
                }
                cell.pwSwitch.addTarget(self, action: #selector(didSwitchEventsUpdate), for: .valueChanged)
            } else if indexPath.row == 2 {
                if User.current.forexSignalNotiSetting == 1 {
                    cell.pwSwitch.setOn(true, animated: false)
                } else {
                    cell.pwSwitch.setOn(false, animated: false)
                }
                cell.pwSwitch.addTarget(self, action: #selector(didSwitchNewForexSignal), for: .valueChanged)
            } else if indexPath.row == 3 {
                if User.current.cryptoSignalNotiSetting == 1 {
                    cell.pwSwitch.setOn(true, animated: false)
                } else {
                    cell.pwSwitch.setOn(false, animated: false)
                }
                cell.pwSwitch.addTarget(self, action: #selector(didSwitchNewCryptoSignal), for: .valueChanged)
            } else if indexPath.row == 4 {
                if User.current.signalThreadNotiSetting == 1 {
                    cell.pwSwitch.setOn(true, animated: false)
                } else {
                    cell.pwSwitch.setOn(false, animated: false)
                }
                cell.pwSwitch.addTarget(self, action: #selector(didSwitchSignalThreadUpdate), for: .valueChanged)
            }
            */
                
            cell.arrowImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.5) : .newBlack.withAlphaComponent(0.5))
            
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingsTableViewCell, for: indexPath) as! SettingsTableViewCell
            cell.generalImageView.image = UIImage(named: socialsIcons[indexPath.row])
            cell.generalImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white : .newBlack)
            cell.titleLabel.text = socials[indexPath.row]
            cell.titleLabel.textColor = isDarkMode.bool(forKey: "isDarkMode") ? .white : .newBlack
            cell.dividerLine.backgroundColor = isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.12) : .newBlack.withAlphaComponent(0.12)
            cell.arrowImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.5) : .newBlack.withAlphaComponent(0.5))
            
            if indexPath.row == socials.count - 1 {
                cell.dividerLine.isHidden = true
            } else {
                cell.dividerLine.isHidden = false
            }
            return cell
        } else {
            
            var supportArray = supportNVU
            if indexPath.row == supportArray.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: logoutTableViewCell, for: indexPath) as! LogoutTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: supportTableViewCell, for: indexPath) as! SupportTableViewCell
                cell.titleLabel.text = supportArray[indexPath.row]//.localiz()
                cell.titleLabel.textColor = isDarkMode.bool(forKey: "isDarkMode") ? .white : .newBlack
                cell.dividerLine.backgroundColor = textColor.withAlphaComponent(0.1)
                cell.arrowImageView.setImageColor(color: .newBlack.withAlphaComponent(0.5))
                if indexPath.row == supportArray.count - 1 {
                    cell.dividerLine.isHidden = true
                } else {
                    cell.dividerLine.isHidden = false
                }
                
                cell.arrowImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.5) : .newBlack.withAlphaComponent(0.5))
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return .createAspectRatio(value: 110) //146
            } else {
                if upgradeHidden {
                    return 0
                } else {
                    return .createAspectRatio(value: 96)
                }
            }
        } else {
            return .createAspectRatio(value: 62)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let sectionTitleLabel = UILabel()
        sectionTitleLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 18))
        sectionTitleLabel.textColor = isDarkMode.bool(forKey: "isDarkMode") ? .white : .newBlack
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
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                didTapLanguage()
            case 1:
                didTapLink()
            case 2:
                didTapMyOrders()
            //case 3:
                //didTapPastResults()
            default:
                //didTapWeAreBFX()
                print("nada")
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
                //print("tapped this")
            }
        }
        
        if indexPath.section == 4 {
            
            if isNVUDemo.bool(forKey: "isNVUDemo") {
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
                case 6:
                    didTapDeleteAccount()
                default:
                    didTapLogout()
                    //print("tapped this")
                }
            } else {
                switch indexPath.row {
                case 0:
                    showFreshDeck()
                case 1:
                    didTapTOS(cell: 1)
                case 2:
                    didTapTOS(cell: 2)
                case 3:
                    didTapTOS(cell: 3)
                case 4:
                    didTapTOS(cell: 4)
                case 5:
                    didTapDeleteAccount()
                default:
                    didTapLogout()
                    //print("tapped this")
                }
            }
        }
    }
    
}

//MARK: CIRCLE PHOTO DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension SettingsViewController: CircleCropViewControllerDelegate {
    @objc func replacePhotoClicked() {
        lightImpactGenerator()
        /*
        ImagePickerManager().pickImage(self){ image in
            if let image = image {
                self.pickedImage(image: image)
            } else {
                print("no photo retrieved")
            }
        }
        */
        
    }
    
    func pickedImage(image: UIImage) {
        self.photo = image
        let circleCropController = CircleCropViewController()
        circleCropController.delegate = self
        circleCropController.image = image
        self.present(circleCropController, animated: true, completion: nil)
    }
    
    func uploadImage() {
        
        //self.profileImageView.image = UIImage.init(named: "userImagePH")
        
        
        guard let photo = self.photo else {
            print("photo is nil, can't upload")
            return
        }
        
        //profileImageView.image = photo
        /*
        ImageUploader.uploadImage(image: photo) { (error, success, url) in
            if let error = error {
                print(error)
                return
            }
            
            guard success else {
                print("upload failed")
                return
            }
            
            User.current.profilePhotoUrl = url
            
//            self.delegate?.didUpdatePhoto?()
            
            API.sharedInstance.updateUser(user: User.current) { (success, user, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                guard success, let user = user else {
                    print("failed updating user")
                    return
                }
                
                DispatchQueue.main.async {
                    User.current = user
                    User.saveCurrentUser()
                }
            }
        }
        */
    }
    
    func circleCropDidCropImage(_ image: UIImage) {
        self.photo = image.wxCompress()
        uploadImage()
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = mainFeedTableView.cellForRow(at: indexPath) as! ProfileImageTableViewCell
        cell.profileImageView.image = photo
    }
    
    func circleCropDidCancel() {
        print("User canceled the crop flow")
    }
}
