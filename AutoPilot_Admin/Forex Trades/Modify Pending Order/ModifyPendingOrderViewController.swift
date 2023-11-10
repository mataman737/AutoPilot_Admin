//
//  ModifyPendingOrderViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/4/23.
//

import UIKit
import Lottie

protocol ModifyPendingOrderViewControllerDelegate: AnyObject {
    func didModifyPendingOrder()
}

class ModifyPendingOrderViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    weak var delegate: ModifyPendingOrderViewControllerDelegate?

    var isNVUDemo = UserDefaults()
    var isDarkMode = UserDefaults()
    var varBlackColor: UIColor = UIColor.black
    var variableWhiteColor: UIColor = UIColor.white
    var mainScrollView = UIScrollView()
    var contentContainer = UIView()
    var opacityLayer = UIView()
    var loadingIndicator = UIActivityIndicatorView(style: .white)
    
    var dismissTop: CGFloat = 54
    var dismissImageView = UIImageView()
    var dismissButton = UIButton()
    var downArrowImageView = UIImageView()
    var orderTypeLabel = UILabel()
    var assetTitleLabel = UILabel()
    var orderTypeButton = UIButton()
    var linkBrokerImageView = UIImageView()
    var linkBrokerButton = UIButton()

    var lotSizeContainer = UIView()
    var lotSizeTitleLabel = UILabel()
    var lotSizeDetailLabel = UILabel()
    var lotSizeUSDLabel = UILabel()
    var lotSizeTextField = UITextField()
    
    var entryPriceContainer = UIView()
    var entryPriceTextField = UITextField()
    var entryPriceTitleLabel = UILabel()
    var entryPriceDetailLabel = UILabel()
    var entryPriceUSDLabel = UILabel()
    
    var takeProfitContainer = UIView()
    var takeProfitTitleLabel = UILabel()
    var takeProfitDetailLabel = UILabel()
    var takeProfitUSDLabel = UILabel()
    var takeProfitArrowImageView = UIImageView()
    var takeProfitButton = UIButton()
    var takeProfitTextField = UITextField()
    
    var stopLossContainer = UIView()
    var stopLossTitleLabel = UILabel()
    var stopLossDetailLabel = UILabel()
    var stopLossUSDLabel = UILabel()
    var stopLossTextField = UITextField()
    
    var bulletZero = UIView()
    var bulletOne = UIView()
    
    var legalLabelZero = UILabel()
    var legalLabelOne = UILabel()
    
    var swipeView = SwipeConfirmView()
    var swipeViewBottom: CGFloat = 43
    var continueButton = ContinueButton()
    
    var orderOptions: [String] = ["Market Execution", "Buy Stop", "Buy Limit", "Sell Stop", "Sell Limit"]
    var takeProfitOptions: [String] = []//["Take Profit 1 - 1.655", "Take Profit 2 - 1.755", "Take Profit 3 - 1.855"]
    var tpOptions: [String] = ["1.655", "1.755", "1.855"]
    
    var disclaimerZero = "Signals, Ideas, Insight, or Analysis is sent out strictly as Education, Information and is for entertainment purposes only, and does not constitute investment advice and you should not receive it as such. You must execute, approve and manage all trades. Any past performance shown and given is not indicative of future profits or results."
    var disclaimerOne = "Enigma Labs LLC takes no responsibility for any losses or gains incurred based on any reliance on the information given. Trading Forex, CFDs or any market carries great risks and can lead to complete loss of funds. Do not trade with any funds that you can’t afford to lose. Trade at your own Risk. (Please refer to Risk Disclosure Statement)"
    
    var isOrderType = true
    var checkmarkOneLottie = LottieAnimationView()
    var orderPlaced = UILabel()
    var checkBackOfficeLabel = UILabel()
    var gradientImageView = UIImageView()
    var orderTypeSelected = ""
    
    var forexSignal: MTInstantTradeStatus!
    var contentSize: CGFloat = 1.25
    var takeProfitSelected: String = "0.0"
    var brokers = [String]()
    
    var placedInstantTrade = false
    
    var account: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupColors()
        modifyConstraints()
        setupViews()
        getAccounts()
        setupLoadingView()
        
        self.lotSizeTextField.becomeFirstResponder()
        if let forexTPPrice1 = forexSignal?.instantTrade?.takeProfit1 {
            if forexTPPrice1 != "" {
                takeProfitOptions.append("Take Profit 1 - \(forexTPPrice1)")
            }
        }
        
        if let forexTPPrice2 = forexSignal?.instantTrade?.takeProfit2 {
            if forexTPPrice2 != "" {
                takeProfitOptions.append("Take Profit 2 - \(forexTPPrice2)")
            }
        }
        
        if let forexTPPrice3 = forexSignal?.instantTrade?.takeProfit3 {
            if forexTPPrice3 != "" {
                takeProfitOptions.append("Take Profit 3 - \(forexTPPrice3)")
            }
        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeround), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToForeround() {
        self.swipeView.arrowsAnimation.play()
    }
}

//MARK: ACTIONS

extension ModifyPendingOrderViewController {
    @objc func dismissVC() {
        lightImpactGenerator()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func didTapTakeProfit() {
        lightImpactGenerator()
        self.view.endEditing(true)
        let pickOptionsVC = PickOptionViewController()
        pickOptionsVC.delegate = self
        pickOptionsVC.titleLabel.text = "Take Profit Options"
        pickOptionsVC.options = takeProfitOptions
        pickOptionsVC.shareURLButton.continueLabel.text = "Confirm"
        pickOptionsVC.modalPresentationStyle = .overFullScreen
        self.present(pickOptionsVC, animated: false) {
            //
        }
        isOrderType = false
    }
    
    func getAccounts() {
        /*
        API.sharedInstance.getMTTradingAccounts { success, accounts, error in
            guard error == nil else {
                print("\(error!) 🖕🖕🖕 000")
                return
            }
            
            guard success, let accounts = accounts else {
                print("error getting accounts 🖕🖕🖕 111")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.brokers = accounts
                //print("🎃🎃🎃 \(self?.brokers) 🎃🎃🎃")
                //self?.account = self?.brokers[0]
                //print("🎃🎃🎃 \(self?.brokers) 🎃🎃🎃 \(self?.account)")
                //self?.timePickerView.reloadAllComponents()
            }
        }
        */
    }
}

//MARK: TEXTFIELD DELEGATE

extension ModifyPendingOrderViewController: UITextFieldDelegate {
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /*
        let newText = textField.text!.replacingCharacters(in: Range(range, in: textField.text!)!, with: string)
        if let range = newText.range(of: ".") {
            let phone = newText[range.upperBound...]
            if phone.count == 3 {
                return false
            }
        }
        let valueZero = Float("\(newText)")
        let multiplier = (valueZero ?? 0) * 10.0
        let roundedValue = round(multiplier * 100) / 100.0
        self.lotSizeUSDLabel.text = "$\(roundedValue)0 per PIP"
        */
        return true
    }
    
}

//MARK: PICK OPTIONS DELEGATE

extension ModifyPendingOrderViewController: PickOptionViewControllerDelegate {
    func didPickTradingPair(optionSelected: String) {
        //
    }
    
    func didPickOption(optionSelected: String) {
        if optionSelected.contains("Take Profit 1") {
            self.takeProfitTextField.text = forexSignal.instantTrade?.takeProfit1
        } else if optionSelected.contains("Take Profit 2") {
            self.takeProfitTextField.text = forexSignal.instantTrade?.takeProfit2
        } else {
            self.takeProfitTextField.text = forexSignal.instantTrade?.takeProfit3
        }
    }
}

//MARK: SWIPEVIEW DELEGATE

extension ModifyPendingOrderViewController: SwipeConfirmViewDelegate {
    
    @objc func showLoading() {
        self.opacityLayer.isHidden = false
        UIView.animate(withDuration: 0.35, delay: 0) {
            self.opacityLayer.alpha = 1.0
        }
    }
    
    @objc func hideLoader() {
        UIView.animate(withDuration: 0.35, delay: 0, options: []) {
            self.opacityLayer.alpha = 0
        } completion: { success in
            self.opacityLayer.isHidden = true
        }
    }
    
    func modifyOrderString(orderString: String, sigEntryPrice: String, sigTakeProfitOne: String) -> String {
        var updatedOrderString = ""
        
        print("\(orderString) 🫶🫶🫶 000")
        if orderString.lowercased() == "market execution" {
            if let entryDouble = Double(sigEntryPrice) {
                if let takeProfitDouble = Double(sigTakeProfitOne) {
                    if entryDouble > takeProfitDouble {
                        print("Sell - is greater ☀️☀️☀️ \(entryDouble) - \(takeProfitDouble)")
                        updatedOrderString = "Sell"
                    } else {
                        print("Buy - is less than ☀️☀️☀️ \(entryDouble) - \(takeProfitDouble)")
                        updatedOrderString = "Buy"
                    }
                }
            }
        } else {
            
            switch orderString.lowercased() {
            case "buy stop":
                updatedOrderString = "BuyStop"
            case "sell limit":
                updatedOrderString = "SellLimit"
            case "sell stop":
                updatedOrderString = "SellStop"
            case "buy limit":
                updatedOrderString = "BuyLimit"
            //Market execution
            default:
                updatedOrderString = ""
            }
        }
        
        print("\(updatedOrderString) 🫶🫶🫶 111")
        return updatedOrderString
    }
    
    func didConfirmDepositFunds() {
        
        if takeProfitTextField.text == "" || stopLossTextField.text == "" {
            errorImpactGenerator()
            
            ToastNotificationView().present(withMessage: "Complete all fields")
            swipeView.resetSwipe()
            
            if takeProfitTextField.text == "" {
                takeProfitTextField.badWiggle()
            }
            
            if stopLossTextField.text == "" {
                stopLossTextField.badWiggle()
            }
            
            print("😪😪😪 \(self.account) 😪😪😪")
        }
//        else if self.account == nil {
//            errorImpactGenerator()
//            ToastNotificationView().present(withMessage: "Broker not selected")
//            swipeView.resetSwipe()
//        }
        else {
            self.showLoading()
            
            if placedInstantTrade {
                print("Don't place order again 🤓🤓🤓")
            } else {
                placedInstantTrade = true
                
                let signalOrderTypeSelected = "ORDER_MODIFY"
                let backofficeSignal = InstantTrade(orderId: forexSignal.instantTrade?.orderId, positionId: forexSignal.instantTrade?.orderId, signalId: self.forexSignal.instantTrade?.signalId, userId: nil, account: self.account, tradingPair: nil, orderType: signalOrderTypeSelected, lotSize: nil, entryPrice: entryPriceTextField.text, takeProfit1: nil, takeProfit2: nil, takeProfit3: nil, takeProfitSelected: self.takeProfitTextField.text, stopLoss: stopLossTextField.text, open: true)
                
                //print("\(signalOrderTypeSelected) 🔥🔥🔥 \(signalOrderType) 🔥🔥🔥")
                
                API.sharedInstance.updateSignal(signal: backofficeSignal) { success, signalResponse, error in
                    guard error == nil else {
                        print(error!)
                        DispatchQueue.main.async { [weak self] in
                            ToastNotificationView().present(withMessage: "Error posting trade")
                            self?.errorImpactGenerator()
                            self?.perform(#selector(self?.hideLoader), with: self, afterDelay: 0.1)
                            self?.swipeView.resetSwipe()
                        }
                        return
                    }
                    
                    //print("🧴🧴🧴 \(backofficeSignal) 🧴🧴🧴 \(signalOrderType)")
                    
                    guard success else {
                        print("error posting trade")
                        DispatchQueue.main.async {
                            ToastNotificationView().present(withMessage: "Error posting trade")
                            self.errorImpactGenerator()
                        }
                        return
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        print("Did this 🫀🫀🫀 333")
                        self?.delegate?.didModifyPendingOrder()
                        self?.perform(#selector(self?.hideLoader), with: self, afterDelay: 0.1)
                        UIView.animate(withDuration: 0.35, delay: 0.5, options: []) {
                            self?.contentContainer.alpha = 0
                            self?.contentContainer.transform = CGAffineTransform(scaleX: 0.45, y: 0.35)
                            self?.swipeView.alpha = 0
                            self?.contentContainer.transform = CGAffineTransform(scaleX: 0.45, y: 0.35)
                        } completion: { success in
                            self?.checkmarkOneLottie.alpha = 1.0
                            guard let s = self else { return }
                            s.perform(#selector(s.showCheck), with: s, afterDelay: 1.25)
                        }
                    }
                }
            }
        }
    }
    
    @objc func showCheck() {
        self.checkmarkOneLottie.play(fromFrame: 0, toFrame: 44, loopMode: .playOnce) { success in
            self.perform(#selector(self.closeVC), with: self, afterDelay: 1.5)
        }
        UIView.animate(withDuration: 0.35) {
            self.orderPlaced.alpha = 1.0
            self.checkBackOfficeLabel.alpha = 1.0
        }
    }
    
    @objc func closeVC(){
        self.dismiss(animated: true, completion: nil)
    }
}
