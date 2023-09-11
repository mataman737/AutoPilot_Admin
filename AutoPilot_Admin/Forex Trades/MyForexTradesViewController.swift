//
//  MyForexTradesViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit
import Lottie
import StreamChat
import StreamChatUI

class MyForexTradesViewController: UIViewController {
    
    let fromLogin = UserDefaults()
    static var titleText: String?
    var transitionView = UIView()
    var loadingContainer = UIView()
    var loadingLottie = LottieAnimationView()
    var navHeight: CGFloat = 90
    var navView = UIView()
    var backImageView = UIImageView()
    var backButton = UIButton()
    var titleLabel = UILabel()
    var detailContainer = UIView()
    var assetLabel = UILabel()
    var buyLabel = UILabel()
    var sellLabel = UILabel()
    var dividerLine = UIView()
    var pastResultsImageView = UIImageView()
    var pastResultsButton = UIButton()
    var padlockImageView = UIImageView()
    var padlockButton = UIButton()
    var mainFeedTableView = UITableView()
    var openOrdersTableViewCell = "openOrdersTableViewCell"
    var closedOrderTableViewCell = "closedOrderTableViewCell"
    var messagesEmptyState = EmptyStateView()
    var plusImageView = UIImageView()
    var plusButton = UIButton()
    var bookImageView = UIImageView()
    var bookButton = UIButton()
    var brokerLinkImageView = UIImageView()
    var brokerLinkButton = UIButton()

    var forexes = [Signal]()
    var signals = [Signal]()
    var weekZeroSignals = [Signal]()
    var weekOneSignals = [Signal]()
    var weekTwoSignals = [Signal]()
    var allRemainingSignals = [Signal]()
    var sixMonthCount = [Signal]()
    var sixMonthSignalCount = 0
    var activeOrders = [MTInstantTradeStatus]()
    var pendingOrders = [MTInstantTradeStatus]()
    var openOrderMenuVC: OpenOrderMenuViewController?
    
    let tradingPairs = ["ADAUSD", "ALUMINIUM", "AUDCAD", "AUDCHF", "AUDJPY", "AUDNZD", "AUDUSD", "AUS200", "AUS200.spot", "AVEUSD", "BCHUSD", "BNBUSD", "BRAIND", "BRENT", "BRENT.spot", "BSVUSD", "BTCEUR", "BTCUSD", "BUND", "CADCHF", "CADJPY", "CHFJPY", "CHNIND", "CHNIND.spot", "COCOA", "COFFEE", "COPPER", "CORN", "COTTON", "DOGUSD", "DOTUSD", "DSHUSD", "EOSUSD", "ETHBTC", "ETHUSD", "EU50", "EU50.spot", "EURAUD", "EURCAD", "EURCHF", "EURCZK", "EURGBP", "EURHUF", "EURJPY", "EURNOK", "EURNZD", "EURPLN", "EURSEK", "EURTRY", "EURUSD", "FRA40", "FRA40.spot", "GAUTRY", "GAUUSD", "GBPAUD", "GBPCAD", "GBPCHF", "GBPJPY", "GBPNZD", "GBPUSD", "GER30", "GER30.spot", "HKIND", "HKIND.spot", "IND50", "ITA40", "ITA40.spot", "JAP225", "JAP225.spot", "KOSP200", "LNKUSD", "LTCUSD", "MEXIND", "NGAS", "NGAS.spot", "NZDCAD", "NZDCHF", "NZDJPY", "NZDUSD", "RUS50", "SA40", "SCHATZ", "SGDJPY", "SOYBEAN", "SPA35", "SPA35.spot", "SUGAR", "SUI20", "THTUSD", "TNOTE", "TRXUSD", "UK100", "UK100.spot", "UNIUSD", "US100", "US100.spot", "US2000", "US30", "US30.spot", "US500", "US500.spot", "USCUSD", "USDBIT", "USDCAD", "USDCHF", "USDCZK", "USDHKD", "USDHUF", "USDIDX", "USDINR", "USDJPY", "USDMXN", "USDNOK", "USDPLN", "USDRUB", "USDSEK", "USDTRY", "USDZAR", "VETUSD", "VIX", "W20", "WHEAT", "WTI", "WTI.spot", "XAGUSD", "XAUEUR", "XAUTRY", "XAUUSD", "XEMUSD", "XLMUSD", "XMRUSD", "XPDUSD", "XPTUSD", "XRPEUR", "XRPUSD", "XTZUSD", "ZINC"]
    
    var isBrokerConnected = true
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupNav()
        setupTable()
        setupEmptyStates()
        //setupTransition()
        //hideTransitionView()
        //setupLoadingIndicator()
        
        /*
        ChatClient.loginUser { error in
            guard error == nil else {
                print(error!)
                return
            }
        }
        */
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(orderProfits(notification:)), name: NSNotification.Name("orderUpdate"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        edgesForExtendedLayout = UIRectEdge.all
        extendedLayoutIncludesOpaqueBars = true
        
        getOpenOrders()
        loadingLottie.play()
    }
    
    func getOpenOrders() {
        API.sharedInstance.getOpenOrders { success, orders, error in
            guard error == nil else {
                print("\(error!) 👹👹👹 111")
                return
            }
            
            guard success, let orders = orders else {
                print("error getting orders 👹👹👹 111")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.activeOrders = orders.filter({$0.instantTrade?.signalType == "Einstein" || $0.instantTrade?.signalType == "Magnus" || $0.instantTrade?.signalType == nil}).filter({$0.order?.type == "Buy" || $0.order?.type == "Sell"})
                self?.pendingOrders = orders.filter({$0.instantTrade?.signalType == "Einstein" || $0.instantTrade?.signalType == "Magnus" || $0.instantTrade?.signalType == nil}).filter({$0.order?.type != "Buy" && $0.order?.type != "Sell"})
                
                self?.mainFeedTableView.reloadData()
            }
        }
    }
    
    func showErrorEmptyState() {
        self.messagesEmptyState.showViews()
        self.messagesEmptyState.lockDetailLabel.setupLineHeight(myText: "Error loading signals", myLineSpacing: 4)
        self.messagesEmptyState.lockDetailLabel.textAlignment = .center
        self.perform(#selector(self.hideLoader), with: self, afterDelay: 0.5)
    }
    
    @objc func hideLoader() {
        UIView.animate(withDuration: 0.5) {
            self.loadingContainer.alpha = 0
        } completion: { success in
            self.loadingContainer.isHidden = true
        }
    }
    
    @objc func orderProfits(notification: NSNotification) {
        if let orderUpdate = notification.userInfo?["orderUpdate"] as? OrderProfitUpdate {
            let orders = orderUpdate.data.orders
            
            if let balance = orderUpdate.data.balance?.rounded(toPlaces: 2) {
//                storedBalance = "$\(balance.withCommas())"
//                navTitleLabel.text = "$\(balance.withCommas())"
//                tradingAccBalanceBC?.navTitleLabel.text = "\(balance.withCommas())"
//                balanceAmount = "\(balance.withCommas())"
//                balanceDouble = balance
                
                /*
                if self.brokers.count == 0 {
                    navTitleLabel.text = "Ed. Ideas"
                    self.eyeImageView.isHidden = true
                    self.eyeButton.isHidden = true
                } else {
                    self.eyeImageView.isHidden = false
                    self.eyeButton.isHidden = false
                }
                */
                
                /*
                if hideBalance.bool(forKey: "hideBalance") == true {
                    navTitleLabel.text = "$•••••"
                    eyeImageView.image = UIImage(named: "eye-off")
                    eyeImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white : .black)
                }
                */
                
                //print("\(hideBalance.bool(forKey: "hideBalance")) 📬📬📬")
                
            } else {
//                navTitleLabel.text = "Einstein"
//                tradingAccBalanceBC?.balanceLabel.text = "-"
            }
            
            /*
            if let equity = orderUpdate.data.equity?.rounded(toPlaces: 2) {
                self.equityAmount = "\(equity.withCommas())"
            }
            
            if let margin = orderUpdate.data.margin?.rounded(toPlaces: 2) {
                self.marginAmount = "\(margin.withCommas())"
            }
            
            if let freeMargin = orderUpdate.data.freeMargin?.rounded(toPlaces: 2) {
                self.freeMarginAmount = "\(freeMargin.withCommas())"
            }
            
            if let profit = orderUpdate.data.profit?.rounded(toPlaces: 2) {
                self.marginLvlPercentAmount = "\(profit.withCommas())"
            }
            */
            
            //orderUpdate.data.balance
            
            for index in 0...activeOrders.count {
                if let cell = mainFeedTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? OpenOrdersTableViewCell {
                    if let currentOrder = orders.first(where: {$0.ticket == cell.order?.ticket}), let profit = currentOrder.profit, let commission = currentOrder.commission {
                        let unrealizedProfit = (profit + commission).rounded(toPlaces: 2)
                        //cell.unrealizedProfitLabel.textColor = unrealizedProfit >= 0 ? .brightGreen : .brightRed
                        
                        let numberString = String(unrealizedProfit)
                        /*
                        if numberString.contains("-") {
                            cell.unrealizedProfitLabel.textColor = .brightRed
                        } else {
                            cell.unrealizedProfitLabel.textColor = .brightGreen
                        }
                        */
                        
                        cell.unrealizedProfitLabel.text = "\(unrealizedProfit.withCommas())"
                        
                        openOrderMenuVC?.loadingIndicator.isHidden = true
                        openOrderMenuVC?.unrealizedProfitLabel.text = "\(unrealizedProfit)"
                                                
                        if numberString.contains("-") {
                            openOrderMenuVC?.unrealizedProfitLabel.textColor = .brightRed
                            cell.unrealizedProfitLabel.textColor = .brightRed
                        } else {
                            openOrderMenuVC?.unrealizedProfitLabel.textColor = .brightGreen
                            cell.unrealizedProfitLabel.textColor = .brightGreen
                        }
                    }
                }
            }
        }
    }
    
}

//MARK: ACTIONS

extension MyForexTradesViewController {
    @objc func connectBrokerTapped() {
        lightImpactGenerator()
        if isBrokerConnected {
            let myBrokerVC = MyConnectedBrokerAccountViewController()
            myBrokerVC.modalPresentationStyle = .overFullScreen
            self.present(myBrokerVC, animated: false, completion: nil)
        } else {
            let connectBrokerVC = ConnectBrokerViewController()
            connectBrokerVC.modalPresentationStyle = .overFullScreen
            self.present(connectBrokerVC, animated: false, completion: nil)
        }
    }
    
    @objc func showOrderHistoryVC() {
        lightImpactGenerator()
        let newNotiVC = OrderHistoryViewController()
        self.present(newNotiVC, animated: true, completion: nil)
    }
    
    @objc func hideTransitionView() {
        /*
        UIView.animate(withDuration: 0.5) {
            self.transitionView.alpha = 0
        } completion: { success in
            self.transitionView.isHidden = true
        }
        */
    }
    
    @objc func presentPastResultsManager() {
        lightImpactGenerator()
        /*
        let newNotiVC = PastResultsManagerViewController()
        newNotiVC.sixMonthTradeCount = sixMonthSignalCount
        //newNotiVC.modalPresentationStyle = .overFullScreen
        self.present(newNotiVC, animated: true, completion: nil)
        */
    }
    
    @objc func presentSecretVC() {
        lightImpactGenerator()
        /*
        let newNotiVC = AutomatedTraderViewController()
        //newNotiVC.modalPresentationStyle = .overFullScreen
        self.present(newNotiVC, animated: true, completion: nil)
        */
    }
    
    @objc func didTapPlus() {
        lightImpactGenerator()
        
        /*
        let newNotiVC = MT_NewForexSignalViewController()//NewForexSignalViewController()
        //newNotiVC.delegate = self
        newNotiVC.modalPresentationStyle = .overFullScreen
        self.present(newNotiVC, animated: true, completion: nil)
        */
        
        let pickOptionVC = PickOptionViewController()
        pickOptionVC.delegate = self
        pickOptionVC.modalPresentationStyle = .overFullScreen
        pickOptionVC.titleLabel.text = "Pick Trading Pair"
        pickOptionVC.options = tradingPairs
        pickOptionVC.shareURLButton.continueLabel.text = "Confirm Traiding Pair"
        self.present(pickOptionVC, animated: false, completion: nil)
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE

extension MyForexTradesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        if activeOrders.count < 1 && pendingOrders.count < 1 {
//            activeEmptyState.showViews()
            return 0
        } else {
//            activeEmptyState.hidViews()
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return activeOrders.count
        } else {
            return pendingOrders.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: openOrdersTableViewCell, for: indexPath) as! OpenOrdersTableViewCell
        
        if indexPath.section == 0 {
            setupActivePositions(cell: cell, indexPath: indexPath)
        } else {
            setupPendingOrders(cell: cell, indexPath: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ActivePendingHeaderView()
        if section == 0 {
            headerView.sectionLabel.text = "Open Orders"
        } else {
            headerView.sectionLabel.text = "Pending Orders"
        }
                                            
        headerView.backgroundColor = .clear//UIColor.white
        headerView.sectionLabel.textColor = .black.withAlphaComponent(0.5)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            
            if pendingOrders.count < 1 {
                return 0
            } else {
                return 60
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {        
        return .createAspectRatio(value: 173)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lightImpactGenerator()
        
        if indexPath.section == 0 {
            
            //----- Show Open Trade Menu -----//
            
            let order = activeOrders[indexPath.row]
            
            let signalOptionsVC = OpenOrderMenuViewController()
            signalOptionsVC.forexSignal = order
            signalOptionsVC.delegate = self
            
            signalOptionsVC.navTitleLabel.text = order.order?.symbol
            /*
            var signal: MTInstantTradeStatus
            signal = allPositions[indexPath.row]
            signalOptionsVC?.forexSignal = signal
            signalOptionsVC?.navTitleLabel.text = signal.order?.symbol
            */
            signalOptionsVC.modalPresentationStyle = .overFullScreen
            self.present(signalOptionsVC, animated: false)
        } else {
            
            //----- Show Pending Trade Menu -----//
            
            let order = pendingOrders[indexPath.row]
            
            let signalOptionsVC = PendingOrderMenuViewController()
            signalOptionsVC.order = order
            signalOptionsVC.delegate = self
            
            /*
            var signal: MTInstantTradeStatus
            signal = allOrders[indexPath.row]
            signalOptionsVC.forexSignal = signal
            signalOptionsVC.navTitleLabel.text = signal.order?.symbol
            */
            signalOptionsVC.modalPresentationStyle = .overFullScreen
            self.present(signalOptionsVC, animated: false)
        }
                
    }
}

//MARK: OPEN TRADE DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension MyForexTradesViewController: OpenOrderMenuViewControllerDelegate {
    func didTapModifyTrade(signal: MTInstantTradeStatus) {
        let signalOptionsVC = ModifyOpenOrderViewController()
        signalOptionsVC.assetTitleLabel.text = signal.order?.symbol
//        signalOptionsVC.account = brokers.first
        signalOptionsVC.forexSignal = signal
        signalOptionsVC.delegate = self
        signalOptionsVC.modalPresentationStyle = .overFullScreen
        self.present(signalOptionsVC, animated: true)
    }
    
    func didTapCloseTrade(signal: MTInstantTradeStatus) {
        let closeOderVC = CloseOrderViewController()
//        closeOderVC.account = brokers.first
        closeOderVC.delegate = self
        closeOderVC.forexSignal = signal
        closeOderVC.modalPresentationStyle = .overFullScreen
        self.present(closeOderVC, animated: false)
    }
    
    func didSubscribeUnsubscibe(signal: MTInstantTradeStatus) {
        //
    }
}

//MARK: PENDING TRADE DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension MyForexTradesViewController: PendingOrderMenuViewControllerDelegate {
    func didTapModifyPendingTrade(signal: MTInstantTradeStatus) {
        let signalOptionsVC = ModifyPendingOrderViewController()
        signalOptionsVC.delegate = self
        signalOptionsVC.assetTitleLabel.text = signal.order?.symbol
//        signalOptionsVC.account = brokers.first
        signalOptionsVC.forexSignal = signal
        signalOptionsVC.modalPresentationStyle = .overFullScreen
        self.present(signalOptionsVC, animated: true)
    }
    
    func didTapClosePendingTrade(signal: MTInstantTradeStatus) {
        let signalOptionsVC = CancelPendingOrderViewController()
//        signalOptionsVC.account = brokers.first
        signalOptionsVC.delegate = self
        signalOptionsVC.forexSignal = signal
        signalOptionsVC.modalPresentationStyle = .overFullScreen
        self.present(signalOptionsVC, animated: false)
    }
    
    func didSubscribeUnsubscibePending(signal: MTInstantTradeStatus) {
        //
    }
    
    
}

//MARK: MODIFY OPEN ORDER DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension MyForexTradesViewController: ModifyOpenOrderViewControllerDelegate {
    func didModifyOpenOrder() {
        getOpenOrders()
//        showLoader()
//        getAccounts()
    }
}

//MARK: MODIFY PENDING ORDER DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension MyForexTradesViewController: ModifyPendingOrderViewControllerDelegate {
    func didModifyPendingOrder() {
        getOpenOrders()
//        showLoader()
//        getAccounts()
    }
}


//MARK: PICK OPTIONS DELEGATE

extension MyForexTradesViewController: PickOptionViewControllerDelegate {
    func didPickOption(optionSelected: String) {
        print("did this bitch 🎃🎃🎃 000")
        let newNotiVC = MT_NewForexSignalViewController()
        newNotiVC.signalTypeSelected = "Einstein"
        newNotiVC.tradeTypeTextField.text = "Einstein"
        newNotiVC.delegate = self
        newNotiVC.tradingPairSelected = optionSelected
        newNotiVC.assetTitleLabel.text = optionSelected
        newNotiVC.modalPresentationStyle = .overFullScreen
        self.present(newNotiVC, animated: true, completion: nil)
    }
}

//MARK: NEW FOREX SIGNAL POSTED

extension MyForexTradesViewController: MT_NewForexSignalViewControllerDelegate {
    func showNotiLoading() {
        self.loadingContainer.alpha = 1.0
        self.loadingContainer.isHidden = false
    }
    
    func didCreateForexSignal(signal: Signal) {
        //getForex()
        print("did this 🤞🤞🤞")
    }
}

//MARK: SETUP CELLS

extension MyForexTradesViewController {
    func setupActivePositions(cell: OpenOrdersTableViewCell, indexPath: IndexPath) {
        cell.assetImageView.image = UIImage(named: "forexBotIcon")
        /*
        cell.currencyPairLabel.text = "EURUSD"
        cell.signalTimeLabel.text = "9/2 @ 2:15pm"
        cell.orderTypeLabel.text = "Buy"
        cell.entryPriceLabel.text = "1.12345"
        cell.currentPriceLabel.text = "1.12345"
        */
             
        let signal = activeOrders[indexPath.row]
        
        cell.order = signal.order
        cell.orderStatus = signal
        
        if let tradingPairZero = signal.order?.symbol {
            let updatedString = tradingPairZero
            cell.currencyPairLabel.text = updatedString.removePeriodsAndDashes()
        }
                
        if let openPrice = signal.order?.openPrice {
            cell.entryPriceLabel.text = "\(openPrice)"
        } else {
            cell.entryPriceLabel.text = "nil"
        }
        
        if let signalTradingPair = signal.order?.symbol {
            let forexPrice = self.updateForexPriceEverySecond(signalSymbol: signalTradingPair)
            print("\(signalTradingPair) 🩳🩳🩳 \(forexPrice)")
            cell.currentPriceLabel.text = forexPrice
        }
        
        if let volume = signal.order?.lots { //signal.order?.ex?.volume
            if let orderType = signal.order?.type {
                //print("\(orderType) 🩳🩳🩳")
                if orderType.contains("Sell") {
                    cell.orderTypeLabel.text = "Sell \(volume)"
                    cell.orderTypeLabel.textColor = UIColor(red: 191/255, green: 103/255, blue: 103/255, alpha: 1.0)
                } else {
                    cell.orderTypeLabel.text = "Buy \(volume)"
                    cell.orderTypeLabel.textColor = UIColor(red: 103/255, green: 191/255, blue: 151/255, alpha: 1.0)
                }
            }
        }
        
        print("\(signal.order?.openTime) 🙏🙏🙏 000")
        
        if let time = signal.order?.openTime {
            var date: Date?
            let splitTime = time.components(separatedBy: "T")
            let datePart = splitTime[0]
            let timePart = splitTime[1].replacingOccurrences(of: ".000Z", with: "")
            let timeString = "\(datePart) \(timePart)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            date = dateFormatter.date(from:timeString)
            
            //print("invalid time zone 😹😹😹 \(date)")
            
            if let formattedDate = formatDate(time) {
                print("\(formattedDate) 😹😹😹")
                cell.signalTimeLabel.text = formattedDate
            } else {
                print("Invalid date string 😹😹😹")
            }
            
            //Change the format of the string
            //into one that is readable and matches the 'All' tab
            /*
            if let sigDate = date {
                if let estTimeZone = TimeZone(abbreviation: "GMT") {
                    //CET & MSD is 11 hours off. we need 10 - EET //BST is 12 hours off //GMT is 13 hours off
                    let startConverted = setTimeString(theDate: sigDate.convert(from: estTimeZone, to: TimeZone.current))
                    //10 hour difference
                    //cell.signalTimeLabel.text = "\(formatter.string(from: sigDate)) | \(startConverted)"
                    cell.signalTimeLabel.text = startConverted
                } else {
                    print("invalid time zone 😹😹😹")
                }
            }
            */
        }
    }
    
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "M/d @ h:mma"
            outputFormatter.amSymbol = "am"
            outputFormatter.pmSymbol = "pm"
            
            return outputFormatter.string(from: date)
        }
        
        return nil // Return nil if date parsing fails
    }
    
    func setupPendingOrders(cell: OpenOrdersTableViewCell, indexPath: IndexPath) {
        cell.assetImageView.image = UIImage(named: "forexBotIcon")
        cell.currencyPairLabel.text = "EURUSD"
        cell.signalTimeLabel.text = "9/2 @ 2:15pm"
        cell.orderTypeLabel.text = "Buy"
        cell.entryPriceLabel.text = "1.12345"
        cell.currentPriceLabel.text = "1.12345"
        
        let signal = pendingOrders[indexPath.row]
        
        cell.order = signal.order
        cell.orderStatus = signal
        
        if let tradingPairZero = signal.order?.symbol {
            cell.currencyPairLabel.text = tradingPairZero
        }
        
        if let openPrice = signal.order?.openPrice {
            cell.entryPriceLabel.text = "\(openPrice)"
        } else {
            cell.entryPriceLabel.text = "nil"
        }
        
        if let signalTradingPair = signal.order?.symbol {
            let forexPrice = self.updateForexPriceEverySecond(signalSymbol: signalTradingPair)
            cell.currentPriceLabel.text = forexPrice
        }
                
        cell.unrealizedProfitLabel.text = "N/A"
        cell.unrealizedProfitLabel.textColor = .black.withAlphaComponent(0.25)
        if let volume = signal.order?.lots {
            if let orderType = signal.order?.type?.uppercased() {
                cell.orderTypeLabel.text = "\(orderType.modifyNonMarketExecution()) \(volume)"
                if orderType.contains("BUY") {
                    cell.orderTypeLabel.textColor = UIColor(red: 43/255, green: 226/255, blue: 139/255, alpha: 1.0)
                } else {
                    cell.orderTypeLabel.textColor = UIColor(red: 226/255, green: 43/255, blue: 43/255, alpha: 1.0)
                }
            }
        }
        
        if let time = signal.order?.openTime {
            var date: Date?
            let splitTime = time.components(separatedBy: "T")
            let datePart = splitTime[0]
            let timePart = splitTime[1].replacingOccurrences(of: ".000Z", with: "")
            let timeString = "\(datePart) \(timePart)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            date = dateFormatter.date(from:timeString)
            
            //Change the format of the string
            if let sigDate = date {
                if let estTimeZone = TimeZone(abbreviation: "GMT") {
                    //CET & MSD is 11 hours off. we need 10 - EET //BST is 12 hours off
                    let startConverted = setTimeString(theDate: sigDate.convert(from: estTimeZone, to: TimeZone.current))
                    //10 hour difference
                    //cell.signalTimeLabel.text = "\(formatter.string(from: sigDate)) | \(startConverted)"
                    cell.signalTimeLabel.text = startConverted
                } else {
                    print("invalid time zone 😹😹😹")
                }
            }
        }
    }
    
    func setTimeString(theDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = "h:mmaa M/dd/yy"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter.string(from: theDate)
    }
    
    @objc func updateForexPriceEverySecond(signalSymbol: String) -> String {
        print("did this 🤷‍♂️🤷‍♂️🤷‍♂️ \(signalSymbol.removePeriodsAndDashes())")
        
        if let livePrice = MyTabBarController.orderProfitUpdate?.livePrices.priceForSymbol(symbol: signalSymbol.removePeriodsAndDashes()) {
            if countDecimalPlaces(livePrice) > 5 {
                let roundToFive = roundToFiveDecimalPlaces(livePrice)
                return String(roundToFive)
            } else {
                return String(livePrice)
            }
        } else {
            return "no live price"
        }
    }
    
    func roundToFiveDecimalPlaces(_ number: Double) -> Double {
        let decimalNumber = Decimal(number)
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        formatter.roundingMode = .halfUp

        if let roundedNumber = formatter.string(from: decimalNumber as NSDecimalNumber),
           let result = Double(roundedNumber) {
            return result
        } else {
            return number
        }
    }
    
    func countDecimalPlaces(_ number: Double) -> Int {
        let numberString = String(number)
        if let decimalIndex = numberString.firstIndex(of: ".") {
            let decimalPlacesCount = numberString.distance(from: decimalIndex, to: numberString.endIndex) - 1
            return max(0, decimalPlacesCount) // Ensure non-negative count
        }
        return 0 // No decimal point found
    }
}

//MARK: CLOSE ORDER DELEGATE

extension MyForexTradesViewController: CloseOrderViewControllerDelegate {
    func didCloseOrder() {
        self.getOpenOrders()
    }
}

//MARK: CLOSE ORDER DELEGATE

extension MyForexTradesViewController: CancelPendingOrderViewControllerDelegate {
    func didCancelOrder() {
        self.getOpenOrders()
    }
}

