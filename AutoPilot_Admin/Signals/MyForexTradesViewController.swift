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
    static var titleText: String?

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
    var forexSignalsTableViewCell = "forexSignalsTableViewCell"
    var signalsTableViewCell = "signalsTableViewCell"
    var noSignalsTableViewCell = "noSignalsTableViewCell"
    
    var openOrdersTableViewCell = "openOrdersTableViewCell"
    var closedOrderTableViewCell = "closedOrderTableViewCell"
    
    var messagesEmptyState = EmptyStateView()
    
    var plusImageView = UIImageView()
    var plusButton = UIButton()

    var forexes = [Signal]()
    
    var signals = [Signal]()
    var weekZeroSignals = [Signal]()
    var weekOneSignals = [Signal]()
    var weekTwoSignals = [Signal]()
    var allRemainingSignals = [Signal]()
    var sixMonthCount = [Signal]()
    var sixMonthSignalCount = 0
    
    let tradingPairs = ["ADAUSD", "ALUMINIUM", "AUDCAD", "AUDCHF", "AUDJPY", "AUDNZD", "AUDUSD", "AUS200", "AUS200.spot", "AVEUSD", "BCHUSD", "BNBUSD", "BRAIND", "BRENT", "BRENT.spot", "BSVUSD", "BTCEUR", "BTCUSD", "BUND", "CADCHF", "CADJPY", "CHFJPY", "CHNIND", "CHNIND.spot", "COCOA", "COFFEE", "COPPER", "CORN", "COTTON", "DOGUSD", "DOTUSD", "DSHUSD", "EOSUSD", "ETHBTC", "ETHUSD", "EU50", "EU50.spot", "EURAUD", "EURCAD", "EURCHF", "EURCZK", "EURGBP", "EURHUF", "EURJPY", "EURNOK", "EURNZD", "EURPLN", "EURSEK", "EURTRY", "EURUSD", "FRA40", "FRA40.spot", "GAUTRY", "GAUUSD", "GBPAUD", "GBPCAD", "GBPCHF", "GBPJPY", "GBPNZD", "GBPUSD", "GER30", "GER30.spot", "HKIND", "HKIND.spot", "IND50", "ITA40", "ITA40.spot", "JAP225", "JAP225.spot", "KOSP200", "LNKUSD", "LTCUSD", "MEXIND", "NGAS", "NGAS.spot", "NZDCAD", "NZDCHF", "NZDJPY", "NZDUSD", "RUS50", "SA40", "SCHATZ", "SGDJPY", "SOYBEAN", "SPA35", "SPA35.spot", "SUGAR", "SUI20", "THTUSD", "TNOTE", "TRXUSD", "UK100", "UK100.spot", "UNIUSD", "US100", "US100.spot", "US2000", "US30", "US30.spot", "US500", "US500.spot", "USCUSD", "USDBIT", "USDCAD", "USDCHF", "USDCZK", "USDHKD", "USDHUF", "USDIDX", "USDINR", "USDJPY", "USDMXN", "USDNOK", "USDPLN", "USDRUB", "USDSEK", "USDTRY", "USDZAR", "VETUSD", "VIX", "W20", "WHEAT", "WTI", "WTI.spot", "XAGUSD", "XAUEUR", "XAUTRY", "XAUUSD", "XEMUSD", "XLMUSD", "XMRUSD", "XPDUSD", "XPTUSD", "XRPEUR", "XRPUSD", "XTZUSD", "ZINC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupNav()
        setupTable()
        setupEmptyStates()
        //setupLoadingIndicator()
        
        /*
        ChatClient.loginUser { error in
            guard error == nil else {
                print(error!)
                return
            }
        }
        */
        
        getForex()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        edgesForExtendedLayout = UIRectEdge.all
        extendedLayoutIncludesOpaqueBars = true
        self.loadingLottie.play()
    }
    
    func getForex() {
        /*
        API.sharedInstance.getForexSignals { success, forexes, error in
            guard error == nil else {
                print("🍑🍑🍑 \(error!) 🍑🍑🍑")
                return
            }
            
            guard success, let forexes = forexes else {
                print("🤷‍♂️🤷‍♂️🤷‍♂️ error getting forexes 🤷‍♂️🤷‍♂️🤷‍♂️ ")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                //self?.forexes = forexes
                //self?.mainFeedTableView.reloadData()
                print("\(forexes.count) 🚫🚫🚫")
                
                /*
                if let forexSignals = self?.forexes {
                    self?.forexes = forexSignals.sorted(by: {($0.added ?? Date()) > ($1.added ?? Date())})
                }
                */
                
                if forexes.count < 1 {
                    self?.messagesEmptyState.showViews()
                    print("did this 111 🚫🚫🚫")
                } else {
                    print("did this 222 🚫🚫🚫")
                }
                self?.perform(#selector(self?.hideLoader), with: self, afterDelay: 0.5)
                
                // FILTERING OUT SIGNALS //
                /*
                let sevenDaysOutDate = Calendar.current.date(
                    byAdding: .day,
                    value: -7,
                    to: Date()) ?? Date()
                
                let oneDayOut = Calendar.current.date(
                    byAdding: .day,
                    value: 1,
                    to: Date()) ?? Date()
                */
                
                //self?.forexes = (forexes.filter({($0.added ?? Date()) > sevenDaysOutDate})).sorted(by: {($0.added ?? Date()) > ($1.added ?? Date())})
                self?.forexes = forexes.sorted(by: {($0.added ?? Date()) > ($1.added ?? Date())})
                //self?.signals = signals.sorted(by: {($0.added ?? Date()) > ($1.added ?? Date())})
                
                //Uncomment this to see total # of trades over the past 6 months
                /*
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm"
                if let sixMonthsAgo = formatter.date(from: "2022/07/31 00:00") {
                    if let recentMonth = formatter.date(from: "2022/12/31 23:59") {
                        //self?.sixMonthCount = ((forexes.filter({($0.added ?? Date()) > sixMonthsAgo})).filter({($0.added ?? Date()) < recentMonth})).count
                        //print("\(self?.sixMonthCount.count) 🧠🧠🧠")
                        self?.sixMonthSignalCount = ((forexes.filter({($0.added ?? Date()) > sixMonthsAgo})).filter({($0.added ?? Date()) < recentMonth})).count
                        
                        //print("\(self?.sixMonthSignalCount) 🧠🧠🧠")
                    }
                }
                */
                            
                
                print("\(Date.today().setDayString()) 👾👾👾 000")
                
                //let todayString = Date.today().setDayString()
                
                /*
                let sevenDaysInFutureDate = Calendar.current.date(
                    byAdding: .day,
                    value: 4,
                    to: Date()) ?? Date()
                */
                
                let currentDate = Date().toLocalTime() //sevenDaysInFutureDate
                self?.currentWeekSaturday = currentDate.previous(.saturday)
                self?.currentWeekLastSaturday = currentDate.previous(.saturday).previous(.saturday)
                self?.lastWeekSaturday = currentDate.previous(.saturday).previous(.saturday).previous(.saturday)
                
                /*
                print("🧚‍♂️🧚‍♂️🧚‍♂️")
                print("\(self?.currentWeekSaturday)")
                print("\(self?.currentWeekLastSaturday)")
                print("\(self?.lastWeekSaturday)")
                print("🧚‍♂️🧚‍♂️🧚‍♂️")
                */
                
                //Current Weeks Siganls
                
                if let cws = self?.currentWeekSaturday {
                    if let lws = self?.currentWeekLastSaturday {
                        if let llws = self?.lastWeekSaturday {
                            self?.weekZeroSignals = forexes.filter({($0.added ?? Date()) > cws && $0.signalType?.lowercased() == "einstein"}).sorted(by: {($0.added ?? Date()) > ($1.added ?? Date())})
                            self?.weekOneSignals = forexes.filter({($0.added ?? Date()) < cws && $0.signalType?.lowercased() == "einstein"}).filter({($0.added ?? Date()) > lws && $0.signalType?.lowercased() == "einstein"}).sorted(by: {($0.added ?? Date()) > ($1.added ?? Date())})
                            self?.weekTwoSignals = forexes.filter({($0.added ?? Date()) < lws && $0.signalType?.lowercased() == "einstein"}).filter({($0.added ?? Date()) > llws && $0.signalType?.lowercased() == "einstein"}).sorted(by: {($0.added ?? Date()) > ($1.added ?? Date())})
                            self?.allRemainingSignals = forexes.filter({($0.added ?? Date()) < llws && $0.signalType?.lowercased() == "einstein"}).sorted(by: {($0.added ?? Date()) > ($1.added ?? Date())})
                            self?.mainFeedTableView.reloadData()
                            //print("✍️✍️✍️ \(self?.forexes.count)")
                            if let wZero = self?.weekZeroSignals.count {
                                if let wOne = self?.weekOneSignals.count {
                                    if let wTwo = self?.weekTwoSignals.count {
                                        if let allR = self?.allRemainingSignals.count {
                                            print("✍️✍️✍️ \(wZero) - \(wOne) - \(wTwo) - \(allR) | \(wZero + wOne + wTwo + allR)")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        */
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

    
}

//MARK: ACTIONS

extension MyForexTradesViewController {
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
        return 2
        
        //Uncomment this after Dylan brings in live data
        /*
        if allPositions.count < 1 && allOrders.count < 1 {
            activeEmptyState.showViews()
            return 0
        } else {
            activeEmptyState.hidViews()
            return 2
        }
        */
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return forexes.count
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
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        return .createAspectRatio(value: 173)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lightImpactGenerator()
        
        
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
        cell.currencyPairLabel.text = "EURUSD"
        cell.signalTimeLabel.text = "9/2 @ 2:15pm"
        cell.orderTypeLabel.text = "Buy"
        cell.entryPriceLabel.text = "1.12345"
        cell.currentPriceLabel.text = "1.12345"
             
        /*
        let signal = allPositions[indexPath.row]                
        
        cell.mtSignal = signal
        
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
            //into one that is readable and matches the 'All' tab
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
        }
        */
    }
    
    func setupPendingOrders(cell: OpenOrdersTableViewCell, indexPath: IndexPath) {
        cell.assetImageView.image = UIImage(named: "forexBotIcon")
        cell.currencyPairLabel.text = "EURUSD"
        cell.signalTimeLabel.text = "9/2 @ 2:15pm"
        cell.orderTypeLabel.text = "Buy"
        cell.entryPriceLabel.text = "1.12345"
        cell.currentPriceLabel.text = "1.12345"
        
        /*
        let signal = allOrders[indexPath.row]
        
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
        */
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
        /*
        if let livePrice = MyTabBarController.orderProfitUpdate?.livePrices.priceForSymbol(symbol: signalSymbol.removePeriodsAndDashes()) {
            if countDecimalPlaces(livePrice) > 5 {
                let roundToFive = roundToFiveDecimalPlaces(livePrice)
                return String(roundToFive)
            } else {
                return String(livePrice)
            }
        } else {
            return "0.0"
        }
        */
        return "0.0"
    }
}
