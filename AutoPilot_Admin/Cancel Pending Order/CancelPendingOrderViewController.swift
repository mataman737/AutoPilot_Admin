//
//  CancelPendingOrderViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/10/23.
//

import UIKit
import Lottie

protocol CancelPendingOrderViewControllerDelegate: AnyObject {
    func didCancelOrder()
}

class CancelPendingOrderViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var isDarkMode = UserDefaults()
    var varBlackColor: UIColor = UIColor.black
    var variableWhiteColor: UIColor = UIColor.white
    weak var delegate: CancelPendingOrderViewControllerDelegate?
    var opacityLayer = UIView()
    var mainScrollView = UIScrollView()
    var wrapper = UIView()
    var mainContainer = UIView()
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
    var swipeView = SwipeConfirmView()
    var checkmarkOneLottie = LottieAnimationView()
    var orderPlaced = UILabel()
    var bulletZero = UIView()
    var bulletOne = UIView()
    var legalLabelZero = UILabel()
    var legalLabelOne = UILabel()
    var disclaimerZero = "NVISIONU™ takes no responsibility for any losses or gains incurred based on any reliance on the information given."
    var disclaimerOne = "Trading Forex, CFDs or any market carries great risks and can lead to complete loss of funds. Do not trade with any funds that you can’t afford to lose. Trade at your own Risk. (Please refer to Risk Disclosure Statement)"
    
    var isDismissing = false
    var goToReminders = false
    var isOneClick = false
    var isCopyValues = false
    var contentType: CGFloat = 0
    var leadName: String = ""
    var isCrypto = false
    
    var textColor: UIColor = UIColor.white
    
    var forexSignal: MTInstantTradeStatus!
    var account: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        setupViews()
        perform(#selector(animateViewsIn), with: self, afterDelay: 0.01)
    }
}

//MARK: ACTIONS

extension CancelPendingOrderViewController {
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
    
    /*
    @objc func tappedAddToWatchlist() {
        if fromWatchList {
            guard let prospect = self.prospect else { return }
            delegate?.didTapChangeLeadStatus(prospect: prospect)
        } else {
            delegate?.addToWatchlistClicked()
        }
        lightImpactGenerator()
        UIView.animate(withDuration: 0.35) {
            self.newChatOption.alpha = 0
            self.newGroupOption.alpha = 0
            self.newChannelOption.alpha = 0
            self.shareOption.alpha = 0
        } completion: { (success) in
            self.successCheck.alpha = 1.0
            self.successCheck.play()
            UIView.animate(withDuration: 0.35) {
                self.addedToWatchListLabel.alpha = 1.0
            }
            self.perform(#selector(self.dimissVC), with: self, afterDelay: 1.5)
        }
    }
    */
    
    @objc func dimissVC() {
        UIView.animate(withDuration: 0.28) {
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

extension CancelPendingOrderViewController: UIScrollViewDelegate {
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

//MARK: SWIPEVIEW DELEGATE

extension CancelPendingOrderViewController: SwipeConfirmViewDelegate {
    func didConfirmDepositFunds() {
        /*
        let signalOrderTypeSelected = "ORDER_CANCEL"
        guard let order = forexSignal.order, let tradingPair = order.symbol, let lotSize = order.lots, let ticket = order.ticket, let entryPrice = order.openPrice else { return }
        let backofficeSignal = InstantTrade(orderId: String(ticket), positionId: String(ticket), signalId: nil, userId: User.current.id, enigmaId: User.current.enigmaId, account: self.account, tradingPair: tradingPair, orderType: signalOrderTypeSelected, lotSize: String(lotSize), entryPrice: String(entryPrice), takeProfit1: nil, takeProfit2: nil, takeProfit3: nil, takeProfitSelected: nil, stopLoss: nil, open: true)
        
        //print("\(signalOrderTypeSelected) 🔥🔥🔥 \(signalOrderType) 🔥🔥🔥")
                                            
        API.sharedInstance.newCloseMTInstantTrade(signal: backofficeSignal) { success, signalResponse, error in
            guard error == nil else {
                print("\(error!) 🧕🧕🧕")
                DispatchQueue.main.async {
                    ToastNotificationView().present(withMessage: "Error posting trade")
                    self.errorImpactGenerator()
                }
                return
            }
            
            //print("🧴🧴🧴 \(backofficeSignal) 🧴🧴🧴 \(signalOrderType)")
            
            guard success, let signalResponse = signalResponse, signalResponse.status != "error" else {
                //print("🐰🐰🐰 \(signalResponse?.errorMsg?.message) 🐰🐰🐰 \(signalOrderType)")
                
                DispatchQueue.main.async { [weak self] in
                    //print("Did this 🫀🫀🫀 222")
                    print("error posting instant forex trade")
                    if let sigErrorMsg = signalResponse?.errorMsg?.message {
                        if sigErrorMsg == "Member does not have a signal account." {
                            ToastNotificationView().present(withMessage: "Create signal account")
                            
                        } else if sigErrorMsg == "Invalid S/L or T/P" {
                            ToastNotificationView().present(withMessage: "Invalid Stop Loss or Take Profit")
                        } else if sigErrorMsg == "Not enough money" {
                            ToastNotificationView().present(withMessage: "Not enough money")
                        } else if sigErrorMsg == "Market is closed" {
                            ToastNotificationView().present(withMessage: "Market is closed")
                        } else {
                            ToastNotificationView().present(withMessage: sigErrorMsg) //Invalid order type
                        }
                        self?.errorImpactGenerator()
//                        self?.placedInstantTrade = false
                        print(sigErrorMsg)
                                                    
//                        self?.perform(#selector(self?.hideLoader), with: self, afterDelay: 0.1)
                    }
                    
                    self?.swipeView.resetSwipe()
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("Did this 🫀🫀🫀 333")
                UIView.animate(withDuration: 0.35, delay: 0.5, options: []) {
                    self?.legalLabelOne.alpha = 0
                    self?.bulletOne.alpha = 0
                    self?.legalLabelZero.alpha = 0
                    self?.bulletZero.alpha = 0
                    self?.swipeView.alpha = 0
                    self?.navTitleLabel.alpha = 0
                } completion: { success in
                    self?.delegate?.didCancelOrder()
                    self?.checkmarkOneLottie.alpha = 1.0
                    self?.perform(#selector(self?.showCheck), with: self, afterDelay: 1.0)
                }
            }
        }
        */
    }
    
    @objc func showCheck() {
        self.checkmarkOneLottie.play(fromFrame: 0, toFrame: 44, loopMode: .playOnce) { success in
            self.perform(#selector(self.dimissVC), with: self, afterDelay: 1.5)
        }
        UIView.animate(withDuration: 0.35) {
            self.orderPlaced.alpha = 1.0
        }
    }
        
}
