//
//  TeamMemberOptionsViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/12/23.
//

import UIKit
import Lottie
import EventKit
import MessageUI

protocol TeamMemberOptionsViewControllerDelegate: AnyObject {
    //func didTapJoinSession(training: LiveTraining)
    //func didTapSetReminder(training: LiveTraining)
    //func didTapMore()
    func didUpdateUserSubStatus()
}

class TeamMemberOptionsViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var isDarkMode = UserDefaults()
    var opacityLayer = UIView()
    var mainScrollView = UIScrollView()
    var wrapper = UIView()
    var mainContainer = UIView()
    var navView = UIView()
    var navTitleLabel = UILabel()
    var dateLabel = UILabel()
    var keyLine = UIView()
    var newChannelOption = OptionsView()
    var sendContentOption = OptionsView()
    let toastView = ToastNotificationView()
    var isDismissing = false
    var leadName: String = ""
    var phoneNumber: String = ""
    var lineGraphView = ChartsLineGraphView()
    var totalPercentChangeLabel = UILabel()
    weak var delegate: TeamMemberOptionsViewControllerDelegate?
    var entryPriceLock = UIImageView()    
    var textColor: UIColor = UIColor.white
    var lotPercentView = LotSizePercentSwitchView()
    var subStatus = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLineGraph()
        setupColors()
        perform(#selector(animateViewsIn), with: self, afterDelay: 0.01)
    }
}

//MARK: ACTIONS

extension TeamMemberOptionsViewController {
    @objc func animateViewsIn() {
        self.mainContainer.presentAndBounce()
        UIView.animate(withDuration: 0.2) {
            self.opacityLayer.alpha = 0.75
        } completion: { (success) in
            if self.subStatus {
                self.lotPercentView.tradingIsTrue()
            } else {
                self.lotPercentView.tradingIsFalse()
            }
        }
    }
    
    @objc func dimissVC() {
        UIView.animate(withDuration: 0.2) {
            self.mainScrollView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.opacityLayer.alpha = 0
        } completion: { (success) in
            self.dismiss(animated: false) {
                //
            }
        }
    }
}

//MARK: SCROLLVIEW DELEGATE

extension TeamMemberOptionsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 1 {
            let yOffset = scrollView.contentOffset.y// + 44
            if yOffset > -44 {
                scrollView.setContentOffset(CGPoint(x: 0, y: -44), animated: false)
            }
            
            if yOffset < -85 {
                if !isDismissing {
                    dimissVC()
                    isDismissing = true
                }
            }
        }
                
    }
}

//MARK: CALENDAR ACTION

extension TeamMemberOptionsViewController {
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
}

extension TeamMemberOptionsViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        if result == .sent {
            print("Message was sent!!!")
        } else {
            print("Message was not sent!!!")
        }
        
        controller.dismiss(animated: true) {
            print("Go back to Subscription")
        }
    }
    
    @objc func didTapPhoneCall() {
        
    }
    
    @objc func makePhoneCall() {
        lightImpactGenerator()
        guard let phoneURL = URL(string: "tel://\(phoneNumber)") else {
            // Invalid phone number
            return
        }
        
        if UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            // Unable to initiate a phone call
        }
    }
    
    @objc func sendMessage() {
        lightImpactGenerator()
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = [phoneNumber]
        //composeVC.body = messageString
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        }
    }
}

//MARK: LOT SIZE PERCENT DELEGATE

extension TeamMemberOptionsViewController: LotSizePercentSwitchViewDelegate {
    func didTapSwitchOption(option: Int) {
        if option == 0 {
            updateUserPaidStatus(phone: self.phoneNumber, paid: true)
        } else {
            updateUserPaidStatus(phone: self.phoneNumber, paid: false)
        }
        
        
    }
    
    func updateUserPaidStatus(phone: String, paid: Bool) {
        API.sharedInstance.updateUserPaidStatus(paidUpdateRequest: UserUpdatePaidRequest(phone: phone, paid: paid)) { success, user, error in
            guard error == nil else {
                print("\(error!) 🫠🫠🫠 000")
                return
            }
            
            guard success, let user = user else {
                print("error updating user status 🫠🫠🫠 111")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("\(user.firstName) | \(user.paid) 🫠🫠🫠 222")
                let toastNoti = ToastNotificationView()
                self?.delegate?.didUpdateUserSubStatus()
                if let subStatus = user.paid {
                    if subStatus {
                        toastNoti.present(withMessage: "Set to Paid!")
                    } else {
                        toastNoti.present(withMessage: "Set to Unpaid")
                    }
                }
            }
        }
    }
}
