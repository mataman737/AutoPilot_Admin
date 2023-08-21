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
        
    var thisWeeksMondayDate = Date()
    var thisWeeksSundayDate = Date()
    
    var currentWeekSaturday = Date()
    var currentWeekLastSaturday = Date()
    
    var lastWeekSaturday = Date()
    var lastLastWeekLastSaturday = Date()
    
    //var tradingPairs: [String] = ["AUDCAD", "AUDCHF", "AUDJPY", "AUDNZD", "AUDUSD", "CADCHF", "CADJPY", "CHFJPY", "EURAUD", "EURCAD", "EURCHF", "EURGBP", "EURJPY", "EURNOK", "EURNZD", "EURPLN", "EURSEK", "EURTRY", "EURUSD", "GBPAUD", "GBPCAD", "GBPCHF", "GBPJPY", "GBPNZD", "GBPUSD", "NZDCAD", "NZDCHF", "NZDJPY", "NZDUSD", "SGDJPY", "USDCAD", "USDCHF", "USDCNH", "USDHKD", "USDJPY", "USDMXN", "USDZAR", "USDMXN", "USDNOK", "USDPLN", "USDRUB", "USDSEK", "USDSGD", "USDTRY", "USDZAR", "US100", "US30", "US500", "SPX500", "NAS100", "WTI", "XAGUSD", "XAUUSD", "XPTUSD", "XPDUSD", "BTCUSD", "ETHUSD", "GER30"]
    
    let tradingPairs = ["ADAUSD", "ALUMINIUM", "AUDCAD", "AUDCHF", "AUDJPY", "AUDNZD", "AUDUSD", "AUS200", "AUS200.spot", "AVEUSD", "BCHUSD", "BNBUSD", "BRAIND", "BRENT", "BRENT.spot", "BSVUSD", "BTCEUR", "BTCUSD", "BUND", "CADCHF", "CADJPY", "CHFJPY", "CHNIND", "CHNIND.spot", "COCOA", "COFFEE", "COPPER", "CORN", "COTTON", "DOGUSD", "DOTUSD", "DSHUSD", "EOSUSD", "ETHBTC", "ETHUSD", "EU50", "EU50.spot", "EURAUD", "EURCAD", "EURCHF", "EURCZK", "EURGBP", "EURHUF", "EURJPY", "EURNOK", "EURNZD", "EURPLN", "EURSEK", "EURTRY", "EURUSD", "FRA40", "FRA40.spot", "GAUTRY", "GAUUSD", "GBPAUD", "GBPCAD", "GBPCHF", "GBPJPY", "GBPNZD", "GBPUSD", "GER30", "GER30.spot", "HKIND", "HKIND.spot", "IND50", "ITA40", "ITA40.spot", "JAP225", "JAP225.spot", "KOSP200", "LNKUSD", "LTCUSD", "MEXIND", "NGAS", "NGAS.spot", "NZDCAD", "NZDCHF", "NZDJPY", "NZDUSD", "RUS50", "SA40", "SCHATZ", "SGDJPY", "SOYBEAN", "SPA35", "SPA35.spot", "SUGAR", "SUI20", "THTUSD", "TNOTE", "TRXUSD", "UK100", "UK100.spot", "UNIUSD", "US100", "US100.spot", "US2000", "US30", "US30.spot", "US500", "US500.spot", "USCUSD", "USDBIT", "USDCAD", "USDCHF", "USDCZK", "USDHKD", "USDHUF", "USDIDX", "USDINR", "USDJPY", "USDMXN", "USDNOK", "USDPLN", "USDRUB", "USDSEK", "USDTRY", "USDZAR", "VETUSD", "VIX", "W20", "WHEAT", "WTI", "WTI.spot", "XAGUSD", "XAUEUR", "XAUTRY", "XAUUSD", "XEMUSD", "XLMUSD", "XMRUSD", "XPDUSD", "XPTUSD", "XRPEUR", "XRPUSD", "XTZUSD", "ZINC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupNav()
        setupTable()
        setupEmptyStates()
        setupLoadingIndicator()
        
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
        return 4
        //return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if weekZeroSignals.count > 0 {
                return weekZeroSignals.count
            } else {
                return 1
            }
        case 1:
            if weekOneSignals.count > 0 {
                return weekOneSignals.count
            } else {
                return 1
            }
        case 2:
            if weekTwoSignals.count > 0 {
                return weekTwoSignals.count
            } else {
                return 1
            }
        default:
            if allRemainingSignals.count > 0 {
                return allRemainingSignals.count
            } else {
                return 1
            }
        }
        //return forexes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            if weekZeroSignals.count > 0 {
                signals = weekZeroSignals
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: noSignalsTableViewCell, for: indexPath) as! NoSignalsTableViewCell
                return cell
            }
                        
        case 1:
            //signal = weekOneSignals[indexPath.row]
            
            if weekOneSignals.count > 0 {
                //signal = weekOneSignals[indexPath.row]
                signals = weekOneSignals
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: noSignalsTableViewCell, for: indexPath) as! NoSignalsTableViewCell
                return cell
            }
            
        case 2:
            //signal = weekTwoSignals[indexPath.row]
            
            if weekTwoSignals.count > 0 {
                //signal = weekTwoSignals[indexPath.row]
                signals = weekTwoSignals
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: noSignalsTableViewCell, for: indexPath) as! NoSignalsTableViewCell
                return cell
            }
            
        default:
            //signal = allRemainingSignals[indexPath.row]
            
            if allRemainingSignals.count > 0 {
                //signal = allRemainingSignals[indexPath.row]
                signals = allRemainingSignals
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: noSignalsTableViewCell, for: indexPath) as! NoSignalsTableViewCell
                return cell
            }
        }
        
        var signal = signals[indexPath.row]//signals[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: signalsTableViewCell, for: indexPath) as! SignalsTableViewCell
                                        
        cell.currencyPairLabel.text = signal.asset
        cell.signal = signal
                        
        cell.orderTypeLabel.text = signal.orderType
        if let signalEntry = signal.entryPrice {
            cell.entryPriceLabel.text = "\(signalEntry)"
        }
        
        if let signalTP1 = signal.takeProfit1 {
            if signalTP1 == "" {
                cell.tpOnePriceLabel.text = "-"
            } else {
                cell.tpOnePriceLabel.text = "\(signalTP1)"
            }
        } else {
            cell.tpOnePriceLabel.text = "-"
        }
        
        if let signalTP2 = signal.takeProfit2 {
            if signalTP2 == "" {
                cell.tpTwoPriceLabel.text = "-"
            } else {
                cell.tpTwoPriceLabel.text = "\(signalTP2)"
            }
        } else {
            cell.tpTwoPriceLabel.text = "-"
        }
        
        
        if let signalTP3 = signal.takeProfit3 {
            if signalTP3 == "" {
                cell.tpThreePriceLabel.text = "-"
            } else {
                cell.tpThreePriceLabel.text = "\(signalTP3)"
            }
        } else {
            cell.tpThreePriceLabel.text = "-"
        }
        
        if let signalStop = signal.stopLoss {
            cell.stopPriceLabel.text = "\(signalStop)"
        }
        
        if let noteLabelText = signal.notes {
            cell.noteLabel.setupLineHeight(myText: noteLabelText, myLineSpacing: 4)
        }
        
        if signal.type == "forex" {
            cell.assetImageView.image = UIImage(named: "forexBotIcon")
            cell.tickerLabel.isHidden = true
            cell.dividerLabel.isHidden = true
            //print("did this 🍑🍑🍑 111")
        } else {
            cell.assetImageView.image = UIImage(named: "cryptoBotIcon")
            cell.tickerLabel.isHidden = true
            cell.dividerLabel.isHidden = true
        }
                        
        if let signalDate = signal.added {
            let formatter = DateFormatter()
            formatter.timeZone = NSTimeZone.local
            formatter.dateFormat = "h:mm aa M/dd/yy"
            cell.signalTimeLabel.text = formatter.string(from: signalDate)
        }
        
        if signal.active == true {
            cell.contentView.alpha = 1.0
        } else {
            cell.contentView.alpha = 0.4
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ForexSignalsHeaderView()
        headerView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        switch section {
        case 0:
            headerView.dateLabel.text = "After \(self.currentWeekSaturday.setDateShortHand())"
            headerView.signalCountLabel.text = "\(self.weekZeroSignals.count)"
        case 1:
            headerView.dateLabel.text = "Between \(self.currentWeekSaturday.setDateShortHand()) - \(self.currentWeekLastSaturday.setDateShortHand())"
            headerView.signalCountLabel.text = "\(self.weekOneSignals.count)"
        case 2:
            headerView.dateLabel.text = "Between \(self.currentWeekLastSaturday.setDateShortHand()) - \(self.lastWeekSaturday.setDateShortHand())"
            headerView.signalCountLabel.text = "\(self.weekTwoSignals.count)"
        default:
            headerView.dateLabel.text = "On or Before \(self.lastWeekSaturday.setDateShortHand())"
            headerView.signalCountLabel.text = "\(self.allRemainingSignals.count)"
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lightImpactGenerator()
        
        var canPresentUpdateVC = false
        var signalsSelected = weekZeroSignals
        
        switch indexPath.section {
        case 0:
            signalsSelected = weekZeroSignals
            canPresentUpdateVC = weekZeroSignals.count > 0
        case 1:
            signalsSelected = weekOneSignals
            canPresentUpdateVC = weekOneSignals.count > 0
        case 2:
            signalsSelected = weekTwoSignals
            canPresentUpdateVC = weekTwoSignals.count > 0
        default:
            signalsSelected = allRemainingSignals
            canPresentUpdateVC = allRemainingSignals.count > 0
        }
        
        if canPresentUpdateVC {
            /*
            let updateSignalVC = UpdateSignalViewController()
            updateSignalVC.delegate = self
            updateSignalVC.signal = signalsSelected[indexPath.row]
            updateSignalVC.isDeactivate = signalsSelected[indexPath.row].active
            updateSignalVC.modalPresentationStyle = .overFullScreen
            self.present(updateSignalVC, animated: false, completion: nil)
            */
        }
    }
}

//MARK: UPDATE SIGNALS DELEGATE
/*
extension MyForexTradesViewController: UpdateSignalViewControllerDelegate {
    func didTapEditSignal(signal: Signal) {
        
        let modifyVC = ModifySignalViewController()
        modifyVC.delegate = self
        modifyVC.forexSignal = signal
        modifyVC.modalPresentationStyle = .overFullScreen
        self.present(modifyVC, animated: true, completion: nil)
        
    }
    
    func didTapViewSource() {
        //
    }
    
    func didTapViewContent(contentType: CGFloat) {
        //
    }
    
    func didTapShareWithLeads() {
        //
    }
    
    func didUpdateSignals() {
        self.loadingContainer.alpha = 1.0
        self.loadingContainer.isHidden = false
        self.loadingLottie.play()
        getForex()
    }
}
*/

//MARK: MODIFY SIGNAL DELEGATE
/*
extension MyForexTradesViewController: ModifySignalViewControllerDelegate {
    func didModifySignal() {
        getForex()
    }
}
*/

//MARK: PICK OPTIONS DELEGATE

extension MyForexTradesViewController: PickOptionViewControllerDelegate {
    func didPickOption(optionSelected: String) {
        /*
        print("did this bitch 🎃🎃🎃 000")
        let newNotiVC = MT_NewForexSignalViewController()
        newNotiVC.signalTypeSelected = "Einstein"
        newNotiVC.tradeTypeTextField.text = "Einstein"
        newNotiVC.delegate = self
        newNotiVC.tradingPairSelected = optionSelected
        newNotiVC.assetTitleLabel.text = optionSelected
        newNotiVC.modalPresentationStyle = .overFullScreen
        self.present(newNotiVC, animated: true, completion: nil)
        */
    }
}

//MARK: NEW FOREX SIGNAL POSTED
/*
extension MyForexTradesViewController: MT_NewForexSignalViewControllerDelegate {
    func showNotiLoading() {
        self.loadingContainer.alpha = 1.0
        self.loadingContainer.isHidden = false
    }
    
    func didCreateForexSignal(signal: Signal) {
        getForex()
        print("did this 🤞🤞🤞")
    }
}
*/
