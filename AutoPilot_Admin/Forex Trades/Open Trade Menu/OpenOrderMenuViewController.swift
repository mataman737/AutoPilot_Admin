//
//  OpenOrderMenuViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/6/23.
//

import UIKit
import Lottie

protocol OpenOrderMenuViewControllerDelegate: AnyObject {
    func didTapModifyTrade(signal: MTInstantTradeStatus)
    func didTapCloseTrade(signal: MTInstantTradeStatus)
    func didSubscribeUnsubscibe(signal: MTInstantTradeStatus)
}

class OpenOrderMenuViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var isNVUDemo = UserDefaults()
    var isDarkMode = UserDefaults()
    var varBlackColor: UIColor = UIColor.black
    var variableWhiteColor: UIColor = UIColor.white
    var opacityLayer = UIView()
    var mainScrollView = UIScrollView()
    var wrapper = UIView()
    var mainContainer = UIView()
    var tradeDetailsContainer = UIView()
    var detailDivider = UIView()
    var entryPriceTitleLabel = UILabel()
    var currentPriceTitleLabel = UILabel()
    var entryPriceLabel = UILabel()
    var currentPriceLabel = UILabel()
    var arrowImageView = UIImageView()
    var unrealizedProfitTitleLabel = UILabel()
    var unrealizedProfitLabel = UILabel()
    var takeProfitTitleLabel = UILabel()
    var takeProfitLabel = UILabel()
    var stopLossTitleLabel = UILabel()
    var stopLossLabel = UILabel()
    var loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    var navView = UIView()
    var navTitleLabel = UILabel()
    var keyLine = UIView()
    var leadImageView = UIImageView()
    var leadNameLabel = UILabel()
    var newChatOption = OptionsView()
    var newGroupOption = OptionsView()
    var newChannelOption = OptionsView()
    var shareOption = OptionsView()
    var sendContentOption = OptionsView()
    var successCheck = LottieAnimationView()
    var addedToWatchListLabel = UILabel()
    let toastView = ToastNotificationView()
    
    var isDismissing = false
    var goToReminders = false
    var isOneClick = false
    var isCopyValues = false
    var isNotification = false
    var isSubscribed = false
    //var isLink = false
    var contentType: CGFloat = 0
    var leadName: String = ""
    var isCrypto = false
            
    weak var delegate: OpenOrderMenuViewControllerDelegate?
    var entryPriceLock = UIImageView()
    
    var textColor: UIColor = UIColor.white
    
    var forexSignal: MTInstantTradeStatus!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        setupViews()
        perform(#selector(animateViewsIn), with: self, afterDelay: 0.01)
    }

}

//MARK: ACTIONS

extension OpenOrderMenuViewController {
    @objc func animateViewsIn() {
        UIView.animate(withDuration: 0.35) {
            self.opacityLayer.alpha = 0.75
            self.mainContainer.transform = CGAffineTransform(translationX: 0, y: 0)
            self.keyLine.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc func newFollowupReminderTapped() {
        if isCrypto {
            errorImpactGenerator()
            newChannelOption.badWiggle()
            entryPriceLock.badWiggle()
        } else {
            lightImpactGenerator()
            isOneClick = true
            self.dimissVC()
        }
    }
    
    @objc func didTapMarketingCenter() {
        lightImpactGenerator()
        isCopyValues = true
        self.dimissVC()
    }
    
    @objc func didTapSubscribe() {
        lightImpactGenerator()
        isNotification = true
        if isSubscribed {
            shareOption.iconImageView.image = UIImage(named: "thickBell")
            shareOption.optionTitleLabel.text = "Receive Updates"
            shareOption.optionDetailLabel.text = "Be notified when there is an update"
            isSubscribed = false
        } else {
            shareOption.iconImageView.image = UIImage(named: "thickBellUnsub")
            shareOption.optionTitleLabel.text = "Cancel Updates"
            shareOption.optionDetailLabel.text = "Cancel notifications for updates"
            isSubscribed = true
        }
        
        self.dimissVC()
    }
    
    @objc func dimissVC() {
        UIView.animate(withDuration: 0.28) {
            self.mainScrollView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.opacityLayer.alpha = 0
        } completion: { (success) in
            self.dismiss(animated: false) {
                if self.isOneClick {
                    self.delegate?.didTapModifyTrade(signal: self.forexSignal)
                }
                
                else if self.isCopyValues {
                    self.delegate?.didTapCloseTrade(signal: self.forexSignal)
                }
                
                else if self.isNotification {
                    self.delegate?.didSubscribeUnsubscibe(signal: self.forexSignal)
                }
                
            }
        }
    }
}

//MARK: SCROLLVIEW DELEGATE

extension OpenOrderMenuViewController: UIScrollViewDelegate {
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

