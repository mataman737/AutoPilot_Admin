//
//  MT_NewForexSignalViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit
import Lottie
import SafariServices
import NWWebSocket
import Network

protocol MT_NewForexSignalViewControllerDelegate: AnyObject {
    //func didPostNewManualInstantTrade()
    func didCreateForexSignal()
    func showNotiLoading()
}

class MT_NewForexSignalViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var isInTestMode = false
    var isDarkMode = UserDefaults()
    var variableColor = UIColor.newBlack
    var variableWhiteColor = UIColor.white
    weak var delegate: MT_NewForexSignalViewControllerDelegate?
    var mainScrollView = UIScrollView()
    var contentContainer = UIView()
    var opacityLayer = UIView()
    var loadingIndicator = UIActivityIndicatorView(style: .white)
    var tradingPairSelected = ""
    var orderTypeSelected = "Pick Order Type"
    
    var dismissTop: CGFloat = 54
    var dismissImageView = UIImageView()
    var dismissButton = UIButton()
    var downArrowImageView = UIImageView()
    var orderTypeLabel = UILabel()
    var assetTitleLabel = UILabel()
    var orderTypeButton = UIButton()
    var linkBrokerImageView = UIImageView()
    var linkBrokerButton = UIButton()
    
    var entryPriceTextField = UITextField()
    var takeProfitTextField = UITextField()
    var stopLossTextField = UITextField()

    var lotSizeContainer = UIView()
    var lotSizeTitleLabel = UILabel()
    var lotSizeDetailLabel = UILabel()
    var lotSizeUSDLabel = UILabel()
    var lotSizeTextField = UITextField()
    
    var entryPriceContainer = UIView()
    var entryPriceTitleLabel = UILabel()
    var entryPriceDetailLabel = UILabel()
    var entryPriceUSDLabel = UILabel()
    
    var takeProfitContainer = UIView()
    var takeProfitTitleLabel = UILabel()
    var takeProfitDetailLabel = UILabel()
    
    var takeProfitTwoContainer = UIView()
    var takeProfitTwoTitleLabel = UILabel()
    var takeProfitTwoDetailLabel = UILabel()
    var takeProfitTwoTextField = UITextField()
    
    var takeProfitThreeContainer = UIView()
    var takeProfitThreeTitleLabel = UILabel()
    var takeProfitThreeDetailLabel = UILabel()
    var takeProfitThreeTextField = UITextField()
    
    var stopLossContainer = UIView()
    var stopLossTitleLabel = UILabel()
    var stopLossDetailLabel = UILabel()
    var stopLossUSDLabel = UILabel()
    
    var tradeTypeContainer = UIView()
    var tradetypeTitleLabel = UILabel()
    var tradeTypeTextField = UITextField()
    var signalTypeButton = UIButton()
    var signalTypeSelected = ""
    
    var demoSignalContainer = UIView()
    var demoSignalTitleLabel = UILabel()
    var demoSignalButton = UIButton()
    var demoSignalCheckBoxImageView = UIImageView()
    
    var bulletZero = UIView()
    var bulletOne = UIView()
    
    var legalLabelZero = UILabel()
    var legalLabelOne = UILabel()
    
    var swipeView = SwipeConfirmView()
    var swipeViewBottom: CGFloat = 43
    var continueButton = ContinueButton()
    
    var orderOptions: [String] = ["Buy", "Sell", "Buy Stop", "Buy Limit", "Sell Stop", "Sell Limit"]
    var takeProfitOptions: [String] = []
    var signalTypeOptions: [String] = ["Scalping", "Swing"]
    
    var disclaimerZero = "Please make sure all the fields above are completed before posting a signal. Please note that once you swipe, the signal will be live and a push notification will go out to all users."
    var disclaimerOne = "Enigma Labs LLC takes no responsibility for any losses or gains incurred based on any reliance on the information given. Trading Forex, CFDs or any market carries great risks and can lead to complete loss of funds. Do not trade with any funds that you can’t afford to lose. Trade at your own Risk. (Please refer to Risk Disclosure Statement)"
    
    var isOrderType = true
    var checkmarkOneLottie = LottieAnimationView()
    var orderPlaced = UILabel()
    var checkBackOfficeLabel = UILabel()
    var gradientImageView = UIImageView()
    
    var forexSignal: Signal?
    var contentSize: CGFloat = 1.5
    var takeProfitSelected: String = "0.0"
    var brokers = [String]()
    
    var placedInstantTrade = false
    var isNotAllowedWithBroker = false
    var isPickingSignalType = false
    var isPostingSignal = false
    var account: String?
    var usersPreferredBroker = UserDefaults()
    var demoSignalSelected = false
    
    var signalEntryPrice = "143.123"
    var signalAsset = "USDJPY"
    var signalOrderType = "Buy"
    var isTypeSell = false
    var isPendingOrderType = false
    var canPlaceInstantTrade = false
    
    var livePriceContainer = UIView()
    var livePriceTitleLabel = UILabel()
    var livePriceLabel = UILabel()
    
    var forexBadAssets: [String] = ["XAUUSD", "XAGUSD", "WTI", "ETHUSD", "BTCUSD", "XPDUSD", "XPTUSD", "US100", "SPX500", "US500", "GER30", "NAS100", "USDJPY"]
    
    var socket: NWWebSocket?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupColors()
        modifyConstraints()
        setupViews()
        setupLoadingView()
        
        self.lotSizeTextField.becomeFirstResponder()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeround), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        if let socketURL = URL(string: "ws://a6dd70dff783de9cf.awsglobalaccelerator.com/wsadmin") {
            self.socket = NWWebSocket(url: socketURL)
            self.socket?.delegate = self
            self.socket?.connect()
        }
    }
}

extension MT_NewForexSignalViewController: WebSocketConnectionDelegate {
    func webSocketDidConnect(connection: WebSocketConnection) {
            // Respond to a WebSocket connection event
        print("did connect to ws")
        }

        func webSocketDidDisconnect(connection: WebSocketConnection,
                                    closeCode: NWProtocolWebSocket.CloseCode, reason: Data?) {
            // Respond to a WebSocket disconnection event
            print("disconnected from ws")
        }

        func webSocketViabilityDidChange(connection: WebSocketConnection, isViable: Bool) {
            // Respond to a WebSocket connection viability change event
        }

    func webSocketDidAttemptBetterPathMigration(result: Result<WebSocketConnection, NWError>) {
            // Respond to when a WebSocket connection migrates to a better network path
            // (e.g. A device moves from a cellular connection to a Wi-Fi connection)
        }

        func webSocketDidReceiveError(connection: WebSocketConnection, error: NWError) {
            // Respond to a WebSocket error event
            print("got ws error")
            print(error)
        }

        func webSocketDidReceivePong(connection: WebSocketConnection) {
            // Respond to a WebSocket connection receiving a Pong from the peer
        }

        func webSocketDidReceiveMessage(connection: WebSocketConnection, string: String) {
            // Respond to a WebSocket connection receiving a `String` message
            //print("got message")
            //print("\(string) 👽👽👽 111")
            
            guard let data = string.data(using: .utf8) else {
                print("couldn't convert string to data")
                return
            }
            
            //print("👽👽👽 222")
            
            do {
                let livePrices = try JSONDecoder().decode(LivePrices.self, from: data)
                
                if let livePrice = livePrices.priceForSymbol(symbol: tradingPairSelected) {
                    self.livePriceLabel.text = "$\(livePrice)"
                }
            } catch {
                //print("\(error) 👽👽👽 444")
            }
        }

        func webSocketDidReceiveMessage(connection: WebSocketConnection, data: Data) {
            // Respond to a WebSocket connection receiving a binary `Data` message
            print("got data")
        }
    
    public enum RoundingPrecision {
        case ones
        case tenths
        case hundredths
    }
    
    public func preciseRound(_ value: Double, precision: RoundingPrecision = .ones) -> Double {
        switch precision {
        case .ones:
            return round(value)
        case .tenths:
            return round(value * 10) / 10.0
        case .hundredths:
            return round(value * 100) / 100.0
        }
    }
}

//MARK: ACTIONS

extension MT_NewForexSignalViewController {
    
    @objc func checkPrevailLivePrice() {
        
        /*
        if signalOrderType.contains("Buy") {
            isTypeSell = false
        } else {
            isTypeSell = true
        }
        
        if signalOrderType != "Buy" && signalOrderType != "Sell" {
            isPendingOrderType = true
        } else {
            isPendingOrderType = false
        }
        
        var forexPrice = "0"
        //forexPrice = self.updateForexPriceEverySecond(signalSymbol: signalAsset)
        let decimalPlaces = signalEntryPrice.components(separatedBy: ".")[1]
        let entryPriceFloat = Float(signalEntryPrice)
        let lastBid = Float(forexPrice) //Float(quote.last.bid)
        let pipDifference = (((lastBid ?? 0) - (entryPriceFloat ?? 0)) * 10).rounded()
        let tip: Float = lastBid ?? 0
        let currentPriceUpdated: String = String(format: "%.\(decimalPlaces.count)f", tip)
        //cell.currentPrice = currentPriceUpdated
        //cell.pipDifference = Double(pipDifference)
                
            
            let noDecmialCurrentPrice = currentPriceUpdated.replacingOccurrences(of: ".", with: "")
            let noDecmialEntryPrice = signalEntryPrice.replacingOccurrences(of: ".", with: "")
            
            let livePriceDouble = Double(noDecmialCurrentPrice) ?? 0
            let signalEntryDouble = Double(noDecmialEntryPrice) ?? 0
            
            var pipvalue = 0.0
            
            if livePriceDouble > signalEntryDouble {
                //print("Live price is greater than Entry Price")
                pipvalue = ((livePriceDouble * 0.1) - (signalEntryDouble * 0.1)).rounded(toPlaces: 1)
                
                livePriceLabel.text = isTypeSell ? "Live: \(currentPriceUpdated) | -\(pipvalue) pips" : "Live: \(currentPriceUpdated) | \(pipvalue) pips"
                
                    if pipvalue > 15 {
                        //let pipDiff = pipvalue - 15
                        let pipDiff = ((pipvalue - 15).rounded(toPlaces: 2)).withCommas()
                        //cell.instantTradeDeactivatedLabel.text = "Instant Trade Deactivated by \(pipDiff) pips".localiz()
                        /*
                        if self.canDoDemoSignals || isPendingOrderType {
                            //cell.canPlaceInstantTrade = true
                            //cell.instantTradeDeactivatedLabel.text = ""
                        } else {
                            //cell.canPlaceInstantTrade = false
                        }
                        */
                    } else {
                        //cell.canPlaceInstantTrade = true
                        //cell.instantTradeDeactivatedLabel.text = ""
                    }
                
            } else {
                
                //print("Live Price is less than Entry Price")
                
                pipvalue = ((signalEntryDouble * 0.1) - (livePriceDouble * 0.1)).rounded(toPlaces: 1)
                
                livePriceLabel.text = isTypeSell ? "Live: \(currentPriceUpdated) | -\(pipvalue) pips" : "Live: \(currentPriceUpdated) | \(pipvalue) pips"
                
                    if pipvalue > 15 {
                        let pipDiff = ((pipvalue - 15).rounded(toPlaces: 2)).withCommas()
                        //cell.instantTradeDeactivatedLabel.text = "Instant Trade Deactivated by \(pipDiff) pips".localiz()
                        /*
                        if self.canDoDemoSignals || isPendingOrderType {
                            //cell.canPlaceInstantTrade = true
                            //cell.instantTradeDeactivatedLabel.text = ""
                        } else {
                            //cell.canPlaceInstantTrade = false
                        }
                        */
                    } else {
                        //cell.canPlaceInstantTrade = true
                        //cell.instantTradeDeactivatedLabel.text = ""
                    }
                                    
            }
            
            //cell.currentPricePipTimeLabel.textColor = cell.currentPricePipTimeLabel.text?.contains("-") == true ? .liveDataRed : .liveDataGreen
            
            let cpZeroCheck = currentPriceUpdated.removing(charactersOf: ".") //"0".removing(charactersOf: ".")
            if let czc = Int(cpZeroCheck) {
                //print("\(czc) 🥰🥰🥰 111")
                if Int(cpZeroCheck) == 0 {
                    canPlaceInstantTrade = false
                }
            }
            
        */
        
    }
    
    @objc func demoSignalTapped() {
        lightImpactGenerator()
        if demoSignalSelected {
            demoSignalCheckBoxImageView.image = UIImage(named: "emptyCheckBoxBlack")
            demoSignalSelected = false
        } else {
            demoSignalCheckBoxImageView.image = UIImage(named: "checkBoxFill")
            demoSignalSelected = true
        }
    }
    
    @objc func didTapSignalOptions() {
        lightImpactGenerator()
        isPickingSignalType = true
        self.view.endEditing(true)
        let pickOptionsVC = PickOptionViewController()
        pickOptionsVC.delegate = self
        pickOptionsVC.titleLabel.text = "Signal Type Options"
        pickOptionsVC.options = signalTypeOptions
        pickOptionsVC.shareURLButton.continueLabel.text = "Confirm"
        pickOptionsVC.modalPresentationStyle = .overFullScreen
        self.present(pickOptionsVC, animated: false)
    }
    
    @objc func dismissVC() {
        lightImpactGenerator()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func appMovedToForeround() {
        self.swipeView.arrowsAnimation.play()
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func didTapOrderType() {
        lightImpactGenerator()
        self.view.endEditing(true)
        isPickingSignalType = false
        let pickOptionsVC = PickOptionViewController()
        pickOptionsVC.delegate = self
        pickOptionsVC.titleLabel.text = "Order Type Options"
        pickOptionsVC.options = orderOptions
        pickOptionsVC.shareURLButton.continueLabel.text = "Confirm"
        pickOptionsVC.modalPresentationStyle = .overFullScreen
        self.present(pickOptionsVC, animated: false)
    }
    
}

//MARK: TEXTFIELD DELEGATE

extension MT_NewForexSignalViewController: UITextFieldDelegate {
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
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
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 || textField.tag == 2 {
            if textField.text != "" {
                //swipeView.isUserInteractionEnabled = true
            } else {
                //swipeView.isUserInteractionEnabled = false
            }
        }
    }
    
}

//MARK: PICK OPTIONS DELEGATE

extension MT_NewForexSignalViewController: PickOptionViewControllerDelegate {
    func didPickTradingPair(optionSelected: String) {
        //
    }
    
    func didPickOption(optionSelected: String) {
        if isPickingSignalType {
            tradeTypeTextField.text = optionSelected
            signalTypeSelected = optionSelected
        } else {
            orderTypeLabel.text = optionSelected
            if orderTypeSelected == "Buy" || orderTypeSelected == "Sell" {
                orderTypeSelected = "Market execution"
            } else {
                orderTypeSelected = optionSelected
            }
        }
    }
}

//MARK: SWIPEVIEW DELEGATE

extension MT_NewForexSignalViewController: SwipeConfirmViewDelegate {
    
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
    
    @objc func swipeViewReset() {
        swipeView.resetSwipe()
    }
    
    func didConfirmDepositFunds() {
        didTapConfirm()
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
    
    func checkTradingPair(tradingPair: String, containerView: UIView, entryString: String) -> Bool {
        
        if tradingPair.contains("JPY") == true {
            /*
            if tradingPair.contains("NZDJPY") == true {
                return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 2, countOne: 3)
            } else {
                //return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 3, countOne: 3)
                return checkForValidJPYFormat(entryString: entryString, wiggleView: containerView, countZero: 3, countZeroTwo: 2, countOne: 3)
            }
            */
            return true
        } else
        
        if tradingPair.contains("US30") == true {
            return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 5, countOne: 2)
        } else if tradingPair.contains("US500") == true ||  tradingPair.contains("SPX500") == true {
            return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 4, countOne: 2)
        } else if tradingPair.contains("XAUUSD") == true {
            return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 4, countOne: 3)
        } else if tradingPair.contains("XAGUSD") == true {
            return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 2, countOne: 5)
        } else if tradingPair.contains("USDMXN") == true {
            return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 2, countOne: 5)
        } else if tradingPair.contains("USDZAR") == true {
            return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 2, countOne: 5)
        }  else if tradingPair.contains("GER30") == true {
            return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 5, countOne: 2)
        } else if tradingPair.contains("NAS100") == true {
            return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 5, countOne: 2)
        } else if tradingPair.contains("US100") == true {
            return true
        } else {
            return checkForValidEntry(entryString: entryString, wiggleView: containerView, countZero: 1, countOne: 5)
        }
    }
    
    private func checkForValidEntry(entryString: String, wiggleView: UIView, countZero: Int, countOne: Int) -> Bool {
        let smth = entryString
        if let index = (smth.range(of: ".")?.lowerBound) {
          let beforeDecimal = String(smth.prefix(upTo: index))
            print("\(beforeDecimal) 🫦🫦🫦")
            if beforeDecimal.count != countZero { //1
                print("Before Decimal: \(beforeDecimal) 😨😨😨 CountZero: \(countZero) 😨😨😨 \(beforeDecimal.count) ploop \(entryString)")
                wiggleView.badWiggle()
                errorImpactGenerator()
                let toastNoti = ToastNotificationView()
                toastNoti.present(withMessage: "Invalid Format")
                self.perform(#selector(swipeViewReset), with: self, afterDelay: 0.01)
                print("this one 🧚‍♂️🧚‍♂️🧚‍♂️ 111")
                return false
            } else {
                let snippet = entryString
                if let range = snippet.range(of: ".") {
                    let afterDecimal = snippet[range.upperBound...]
                    print("\(afterDecimal) 😨😨😨 \(countOne) 😨😨😨 \(afterDecimal.count) caca \(entryString)")
                    if afterDecimal.count != countOne { //5
                        
                        wiggleView.badWiggle()
                        errorImpactGenerator()
                        let toastNoti = ToastNotificationView()
                        toastNoti.present(withMessage: "Invalid")
                        self.perform(#selector(swipeViewReset), with: self, afterDelay: 0.01)
                        print("this one 🧚‍♂️🧚‍♂️🧚‍♂️ 222")
                        return false
                    } else {
                        return true
                    }
                } else {
                    return false
                }
            }
        } else {
            return false
        }
    }
    
    private func checkForValidJPYFormat(entryString: String, wiggleView: UIView, countZero: Int, countZeroTwo: Int, countOne: Int) -> Bool {
        let smth = entryString
        if let index = (smth.range(of: ".")?.lowerBound) {
          let beforeDecimal = String(smth.prefix(upTo: index))
            if beforeDecimal.count != countZero { //1
                
                if beforeDecimal.count != countZeroTwo {
                    print("Before Decimal: \(beforeDecimal) 😨😨😨 CountZero: \(countZero) 😨😨😨 countZeroTwo: \(countZeroTwo)  😨😨😨 \(beforeDecimal.count) ploop \(entryString)")
                    wiggleView.badWiggle()
                    errorImpactGenerator()
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Invalid Format")
                    self.perform(#selector(swipeViewReset), with: self, afterDelay: 0.01)
                    print("this one 🧚‍♂️🧚‍♂️🧚‍♂️ 111")
                    return false
                } else {
                    return true
                }
                                
                                
            } else {
                let snippet = entryString
                if let range = snippet.range(of: ".") {
                    let afterDecimal = snippet[range.upperBound...]
                    print("\(afterDecimal) 😨😨😨 \(countOne) 😨😨😨 \(afterDecimal.count) caca \(entryString)")
                    if afterDecimal.count != countOne { //5
                        
                        wiggleView.badWiggle()
                        errorImpactGenerator()
                        let toastNoti = ToastNotificationView()
                        toastNoti.present(withMessage: "Invalid")
                        self.perform(#selector(swipeViewReset), with: self, afterDelay: 0.01)
                        print("this one 🧚‍♂️🧚‍♂️🧚‍♂️ 222")
                        return false
                    } else {
                        return true
                    }
                } else {
                    return false
                }
            }
        } else {
            return false
        }
    }
    
    ///////////////////
    
    @objc func didTapConfirm() {
        if tradingPairSelected != "" && orderTypeSelected != "Pick Order Type" && entryPriceTextField.text != "" && takeProfitTextField.text != "" && stopLossTextField.text != "" && signalTypeSelected != "" {
            if let entryString = entryPriceTextField.text {
                if !entryString.contains(".") {
                    print("did this crap 👘👘👘 000")
                    entryPriceContainer.badWiggle()
                    errorImpactGenerator()
                    self.perform(#selector(resetDelay), with: self, afterDelay: 0.1)
                    return
                } else {
                    print("did this crap 👘👘👘 111")
                    if checkTradingPair(tradingPair: tradingPairSelected, containerView: entryPriceContainer, entryString: entryString) == false {
                        swipeView.resetSwipe()
                        return
                    }
                }
            } else {
                print("did this crap 👘👘👘 222")
            }
            
            if let takeProfitString = takeProfitTextField.text {
                if !takeProfitString.contains(".") {
                    takeProfitContainer.badWiggle()
                    errorImpactGenerator()
                    self.perform(#selector(resetDelay), with: self, afterDelay: 0.1)
                    return
                } else {
                    if checkTradingPair(tradingPair: tradingPairSelected, containerView: takeProfitContainer, entryString: takeProfitString) == false {
                        swipeView.resetSwipe()
                        return
                    }
                }
            }
            
            if let stopLossString = stopLossTextField.text {
                if !stopLossString.contains(".") {
                    stopLossContainer.badWiggle()
                    errorImpactGenerator()
                    self.perform(#selector(resetDelay), with: self, afterDelay: 0.1)
                    return
                } else {
                    if checkTradingPair(tradingPair: tradingPairSelected, containerView: stopLossContainer, entryString: stopLossString) == false {
                        swipeView.resetSwipe()
                        return
                    }
                    
                }
            }
            
            if takeProfitTwoTextField.text != "" {
                if let takeProfitString = takeProfitTwoTextField.text {
                    if !takeProfitString.contains(".") {
                        takeProfitTwoContainer.badWiggle()
                        errorImpactGenerator()
                        self.perform(#selector(resetDelay), with: self, afterDelay: 0.1)
                        return
                    } else {
                        if checkTradingPair(tradingPair: tradingPairSelected, containerView: takeProfitTwoContainer, entryString: takeProfitString) == false {
                            swipeView.resetSwipe()
                            return
                        }
                        
                    }
                }
            }
            
            if takeProfitThreeTextField.text != "" {
                if let takeProfitString = takeProfitThreeTextField.text {
                    if !takeProfitString.contains(".") {
                        takeProfitThreeContainer.badWiggle()
                        errorImpactGenerator()
                        self.perform(#selector(resetDelay), with: self, afterDelay: 0.1)
                        return
                    } else {
                        if checkTradingPair(tradingPair: tradingPairSelected, containerView: takeProfitThreeContainer, entryString: takeProfitString) == false {
                            swipeView.resetSwipe()
                            return
                        }
                        
                    }
                }
            }
                        
            //confirmView.animateViewsin()
            
            if !isPostingSignal {
                isPostingSignal = true
                postSignal()
            }
            
        } else {
            errorImpactGenerator()
            //swipeView.resetSwipe()
            self.perform(#selector(resetDelay), with: self, afterDelay: 0.1)
            
            if entryPriceTextField.text == "" {
                entryPriceContainer.badWiggle()
            }
            
            if takeProfitTextField.text == "" {
                takeProfitContainer.badWiggle()
            }
            
            if stopLossTextField.text == "" {
                stopLossContainer.badWiggle()
            }
            
            if orderTypeLabel.text == "Pick Order Type" {
                orderTypeLabel.badWiggle()
            }
            
            if signalTypeSelected == "" {
                tradeTypeContainer.badWiggle()
            }
        }
    }
    
    @objc func resetDelay() {
        swipeView.resetSwipe()
    }
    
    @objc func postSignal() {
        self.showLoading()
        self.mainScrollView.isUserInteractionEnabled = false
        
        let forexSignal = SignalRequest(id: nil, hostId: Admin.current.id, providerId: nil, signalType: signalTypeSelected, teamId: Admin.current.teamId, asset: tradingPairSelected, orderType: orderTypeSelected, entryPrice: entryPriceTextField.text, takeProfit1: takeProfitTextField.text, takeProfit2: takeProfitTwoTextField.text, takeProfit3: takeProfitThreeTextField.text, stopLoss: stopLossTextField.text, active: true, time: nil, notes: nil, type: "forex", added: Date(), isTesting: demoSignalSelected) //demoSignalSelected //isInTestMode
        
        print("posted a signal! \(isInTestMode) 😸😸😸 \(forexSignal)")
                
        API.sharedInstance.postForexSignal(signal: forexSignal) { success, _, error in
            
            guard error == nil else {
                print("\(error!) 😸😸😸 222")
                
                DispatchQueue.main.async { [weak self] in
                    print("posted a signal! 🍗🍗🍗 pee")
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Unable to send signal!")
                    self?.isPostingSignal = false
                }
                
                return
            }
            
            guard success else {
                print("error posting signal")
                
                DispatchQueue.main.async { [weak self] in
                    print("posted a signal! 🍗🍗🍗 poop")
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Unable to send signal!")
                    self?.isPostingSignal = false
                }
                
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("posted a signal! 😸😸😸 333")
                self?.delegate?.showNotiLoading()
                //self?.perform(#selector(self?.broadcastSuccessDelay), with: self, afterDelay: 0.5)
                self?.delegate?.didCreateForexSignal()
                
                print("posted a signal! 🍗🍗🍗 444")
                
                
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
        
        
        //Uncomment this to demo
        /*
        self.perform(#selector(self.hideLoader), with: self, afterDelay: 0.1)
        UIView.animate(withDuration: 0.35, delay: 0.5, options: []) {
            self.contentContainer.alpha = 0
            self.contentContainer.transform = CGAffineTransform(scaleX: 0.45, y: 0.35)
            self.swipeView.alpha = 0
            self.contentContainer.transform = CGAffineTransform(scaleX: 0.45, y: 0.35)
        } completion: { success in
            self.checkmarkOneLottie.alpha = 1.0
            //guard let s = self else { return }
            self.perform(#selector(self.showCheck), with: self, afterDelay: 1.25)
        }
        */        
    }
}
