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
import AVFoundation
import AVKit

class MyForexTradesViewController: UIViewController {
    
    let fromLogin = UserDefaults()
    var transitionView = UIView()
    var appLogoImageView = UIImageView()
    var loadingContainer = UIView()
    var loadingLottie = LottieAnimationView()
    var navView = UIView()
    var titleLabel = UILabel()
    var dividerLine = UIView()
    var mainFeedTableView = UITableView()
    var openOrdersTableViewCell = "openOrdersTableViewCell"
    var plusImageView = UIImageView()
    var plusButton = UIButton()
    var bookImageView = UIImageView()
    var bookButton = UIButton()
    var brokerLinkImageView = UIImageView()
    var brokerLinkButton = UIButton()
    var activeOrders = [MTInstantTradeStatus]()
    var pendingOrders = [MTInstantTradeStatus]()
    var closedOrders = [MTInstantTradeStatus]()
    var openOrderMenuVC: OpenOrderMenuViewController?
    var adminOnboardingView = OnboardingView()
    var myForexTradesEmptyState = EmptyStateView()
    var didSetTeamNamePhoto = UserDefaults()
    var didSetAccessCode = UserDefaults()
    var didConnectBroker = UserDefaults()
    var didGetOrders = false
    var didGetClosedOrders = false
    var onboardingCompleted = false
    var brokers = [String]()
    var team: Team?
    var teamAccessCode: String? {
        return team?.accessCode
    }
    var teamName: String? {
        return team?.name
    }
    
    var teamMyFxBookLink: String? {
        return team?.fxBook
    }
    
    //Video & Audio
    var player = AVPlayer()
    var playerLoop = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentAdmin()
        getCurrentTeam()
        setupNav()
        setupEmptyStates()
        setupTable()
        setupLoadingIndicator()
        playLoopingVideo()
        updateOnboardingRows()
        setupTransition()
        
        self.perform(#selector(hideTransitionView), with: self, afterDelay: 1.0)
        
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
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeround), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in
            if let error = error {
                print("D'oh: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    center.delegate = appDelegate.notificationDelegate
                    let deafultCategory = UNNotificationCategory(identifier: "signal", actions: [], intentIdentifiers: [],      hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
                    
                    let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("Open", comment: ""), options: UNNotificationActionOptions.foreground)
                    let imageCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
                    center.setNotificationCategories(Set([deafultCategory, imageCategory]))
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        edgesForExtendedLayout = UIRectEdge.all
        extendedLayoutIncludesOpaqueBars = true
        //getAccounts()

        playerLoop.play()
        loadingLottie.play()
    }
    
    @objc func appMovedToForeround() {
        self.playerLoop.play()
    }
    
    func getAccounts() {
        API.sharedInstance.getMTTradingAccounts { success, accounts, error in
            guard error == nil else {
                print("\(error!) 👽👽👽")
                return
            }
            
            guard success, let accounts = accounts else {
                print("error getting accounts 👽👽👽")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.brokers = accounts
                self?.updateOnboardingRows()
                print("\(accounts.count) 👽👽👽 \(self?.onboardingCompleted)")
                if accounts.count > 0 && self?.onboardingCompleted == true {
                    self?.getOpenOrders()
                    self?.getClosedOrders()
                } else {                    
                    self?.hideLoader()
                }
                self?.mainFeedTableView.reloadData()
            }
        }
    }
    
    func getCurrentAdmin() {
        API.sharedInstance.getCurrentAdmin { success, admin, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let admin = admin else {
                print("error getting admin")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                Admin.current = admin
                print("\(admin.permissions) 👽👽👽")
                Admin.saveCurrentAdmin()
            }
        }
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
                self?.updateOnboardingRows()
                self?.getAccounts()
            }
        }
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
                self?.activeOrders = orders.filter({$0.order?.type == "Buy" || $0.order?.type == "Sell"}).sorted(by: {($0.order?.openTime?.convertToDate() ?? Date()) > ($1.order?.openTime?.convertToDate() ?? Date())})
                self?.pendingOrders = orders.filter({$0.order?.type != "Buy" && $0.order?.type != "Sell"}).sorted(by: {($0.order?.openTime?.convertToDate() ?? Date()) > ($1.order?.openTime?.convertToDate() ?? Date())})
                
                self?.didGetOrders = true
                self?.mainFeedTableView.reloadData()
                
                if self?.didGetOrders == true && self?.didGetClosedOrders == true {
                    self?.hideLoader()
                    
                    if let activeOrdersCount = self?.activeOrders.count, let pendingOrdersCount = self?.pendingOrders.count {
                        if activeOrdersCount > 0 || pendingOrdersCount > 0 {
                            self?.myForexTradesEmptyState.isHidden = true
                            self?.myForexTradesEmptyState.hidViews()
                        } else {
                            self?.myForexTradesEmptyState.isHidden = false
                            self?.myForexTradesEmptyState.showViews()
                        }
                    }
                }
            }
        }
    }
    
    func getClosedOrders() {
        API.sharedInstance.getClosedOrders { success, orders, error in
            guard error == nil else {
                print("\(error!) 👹👹👹 111")
                return
            }
            
            guard success, let orders = orders else {
                print("error getting closed orders 👹👹👹 111")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.closedOrders = orders.sorted(by: {($0.order?.closeTime?.convertToDate() ?? Date()) > ($1.order?.closeTime?.convertToDate() ?? Date())})
                self?.didGetClosedOrders = true
                self?.mainFeedTableView.reloadData()
                
                if self?.didGetOrders == true && self?.didGetClosedOrders == true {
                    self?.hideLoader()
                    
                    if let activeOrdersCount = self?.activeOrders.count, let pendingOrdersCount = self?.pendingOrders.count {
                        if activeOrdersCount > 0 || pendingOrdersCount > 0 {
                            self?.myForexTradesEmptyState.isHidden = true
                            self?.myForexTradesEmptyState.hidViews()
                        } else {
                            self?.myForexTradesEmptyState.isHidden = false
                            self?.myForexTradesEmptyState.showViews()
                        }
                    }
                }
            }
        }
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
            
            for index in 0...orders.count {
                for section in 0...1 {
                    if let cell = mainFeedTableView.cellForRow(at: IndexPath(row: index, section: section)) as? OpenOrdersTableViewCell {
                        if let currentOrder = orders.first(where: {$0.ticket == cell.order?.ticket}), let profit = currentOrder.profit, let commission = currentOrder.commission {
                            if let signalTradingPair = currentOrder.symbol {
                                let forexPrice = self.updateForexPriceEverySecond(signalSymbol: signalTradingPair)
                                cell.currentPriceLabel.text = forexPrice
                            }
                            let unrealizedProfit = (profit + commission).rounded(toPlaces: 2)
                            //cell.unrealizedProfitLabel.textColor = unrealizedProfit >= 0 ? .brightGreen : .brightRed
                            
                            let numberString = String(unrealizedProfit)
                            
                            cell.unrealizedProfitLabel.text = "\(unrealizedProfit.withCommas())"
                            
                            //openOrderMenuVC?.loadingIndicator.isHidden = true
                            //openOrderMenuVC?.loadingIndicator.stopAnimating()
                            
                            //print("did this 🥱🥱🥱")
                            //openOrderMenuVC?.unrealizedProfitLabel.text = "\(unrealizedProfit)"
                            
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
}

//MARK: SET UP VIDEO & AUDIO ------------------------------------------------------------------------------------------------------------------------------------

extension MyForexTradesViewController {
    private func playLoopingVideo() {
        // VIDEO
        guard let path = Bundle.main.path(forResource: "attempt_4", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
      
        playerLoop = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: playerLoop)
        playerLoop.isMuted = true
        playerLayer.frame = CGRect(x: 0, y: 0, width: .createAspectRatio(value: 175), height: .createAspectRatio(value: 175))
      
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        adminOnboardingView.animationView.layer.addSublayer(playerLayer)
        self.playerLoop.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerLoop.currentItem, queue: .main) { [weak self] _ in
            self?.playerLoop.seek(to: CMTime.zero)
            self?.playerLoop.play()
        }
    }
}

//MARK: ACTIONS ------------------------------------------------------------------------------------------------------------------------------------

extension MyForexTradesViewController {
    @objc func didTapMyFXBook() {
        lightImpactGenerator()
        let updateAccessCodeVC = SetMyFXBookLinkViewController()
        updateAccessCodeVC.team = self.team
        updateAccessCodeVC.delegate = self
        updateAccessCodeVC.modalPresentationStyle = .overFullScreen
        self.present(updateAccessCodeVC, animated: false)
    }
    
    @objc func presentUpdateTeamNamePhoto() {
        lightImpactGenerator()
        let updateTeamNamePhotoVC = UpdateTeamNameAndPhotoViewController()
        updateTeamNamePhotoVC.team = self.team
        updateTeamNamePhotoVC.delegate = self
        updateTeamNamePhotoVC.modalPresentationStyle = .overFullScreen
        self.present(updateTeamNamePhotoVC, animated: false)
    }
    
    @objc func presentUpdateAccessCode() {
        lightImpactGenerator()
        let updateAccessCodeVC = UpdateAccessCodeViewController()
        updateAccessCodeVC.team = self.team
        updateAccessCodeVC.delegate = self
        updateAccessCodeVC.modalPresentationStyle = .overFullScreen
        self.present(updateAccessCodeVC, animated: false)
    }
    
    @objc func connectBrokerTapped() {
        lightImpactGenerator()
        if brokers.count > 0 {
            let myBrokerVC = MyConnectedBrokerAccountViewController()
            myBrokerVC.brokers = self.brokers
            myBrokerVC.modalPresentationStyle = .overFullScreen
            self.present(myBrokerVC, animated: false, completion: nil)
        } else {
            let connectBrokerVC = ConnectBrokerViewController()
            connectBrokerVC.delegate = self
            connectBrokerVC.modalPresentationStyle = .overFullScreen
            self.present(connectBrokerVC, animated: false, completion: nil)
        }
    }
    
    @objc func showOrderHistoryVC() {
        lightImpactGenerator()
        let orderHistoryVC = OrderHistoryViewController()
        if onboardingCompleted {
            orderHistoryVC.orders = self.closedOrders
        }
        self.present(orderHistoryVC, animated: true, completion: nil)
    }
    
    @objc func hideTransitionView() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.appLogoImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.appLogoImageView.alpha = 0
        })
        
        UIView.animate(withDuration: 0.5, animations: {
            self.transitionView.alpha = 0
        }) { (success) in
            self.transitionView.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
        
    }
    
    @objc func didTapPlus() {
        if onboardingCompleted {
            lightImpactGenerator()
            let pickOptionVC = PickOptionViewController()
            pickOptionVC.delegate = self
            pickOptionVC.modalPresentationStyle = .overFullScreen
            pickOptionVC.titleLabel.text = "Pick Trading Pair"
            pickOptionVC.shareURLButton.continueLabel.text = "Confirm Traiding Pair"
            self.present(pickOptionVC, animated: false, completion: nil)
        } else {
            
            if self.brokers.count > 0 {
            
            //if didConnectBroker.bool(forKey: "didConnectBroker") {
                let toastNoti = ToastNotificationView()
                toastNoti.present(withMessage: "Complete onboarding first!")
                errorImpactGenerator()
            } else {
                adminOnboardingView.brokerContainer.badWiggle()
                adminOnboardingView.connectBrokerImageView.badWiggle()
                errorImpactGenerator()
            }
        }
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE ------------------------------------------------------------------------------------------------------------------------------------

extension MyForexTradesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        if activeOrders.count < 1 && pendingOrders.count < 1 {
            //activeEmptyState.showViews()
            return 0
        } else {
            //activeEmptyState.hidViews()
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if activeOrders.count > 0 || pendingOrders.count > 0 {
            myForexTradesEmptyState.isHidden = true
        } else {
            myForexTradesEmptyState.isHidden = false
        }
        
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
        return .createAspectRatio(value: 140) //173
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
    
    func didCreateForexSignal() {
        //getForex()
        print("did this 🤞🤞🤞")
        self.getOpenOrders()
    }
}

//MARK: SETUP CELLS

extension MyForexTradesViewController {
    func setupActivePositions(cell: OpenOrdersTableViewCell, indexPath: IndexPath) {
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
            cell.currentPriceLabel.text = forexPrice
        }
        
        if let volume = signal.order?.lots { //signal.order?.ex?.volume
            if let orderType = signal.order?.type {
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
            // Create a date formatter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = time.detectDateFormat()
            
            // Convert the string to a Date object
            if let date = dateFormatter.date(from: time) {
                if let eetTimeZone = TimeZone(abbreviation: "EET") {
                    //CET & MSD is 11 hours off. we need 10 - EET //BST is 12 hours off
                    let convertedDate = date.convert(from: eetTimeZone, to: TimeZone.current).monthDayAndTime()
                    cell.signalTimeLabel.text = convertedDate
                } else {
                    cell.signalTimeLabel.text = "Invalid time zone"
                }
            } else {
                cell.signalTimeLabel.text = "Invalid date time"
            }
        }
    }
    
    func setupPendingOrders(cell: OpenOrdersTableViewCell, indexPath: IndexPath) {
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
            // Create a date formatter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = time.detectDateFormat()
            
            // Convert the string to a Date object
            if let date = dateFormatter.date(from: time) {
                if let eetTimeZone = TimeZone(abbreviation: "EET") {
                    //CET & MSD is 11 hours off. we need 10 - EET //BST is 12 hours off
                    let convertedDate = date.convert(from: eetTimeZone, to: TimeZone.current).monthDayAndTime()
                    cell.signalTimeLabel.text = convertedDate
                } else {
                    print("invalid time zone 😹😹😹")
                }
            } else {
                cell.signalTimeLabel.text = "Invalid date time"
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
        //print("did this 🤷‍♂️🤷‍♂️🤷‍♂️ \(signalSymbol.removePeriodsAndDashes())")
        
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
        self.getClosedOrders()
    }
}

//MARK: CLOSE ORDER DELEGATE

extension MyForexTradesViewController: CancelPendingOrderViewControllerDelegate {
    func didCancelOrder() {
        self.getOpenOrders()
        self.getClosedOrders()
    }
}

//MARK: CLOSE ORDER DELEGATE

extension MyForexTradesViewController: SetMyFXBookLinkViewControllerDelegate {
    func didUpdateMyFXBookLink() {
        //updateOnboardingRows()
        getCurrentTeam()
    }
    
    
}

//MARK: UPDATE TEAM NAME PHOTO DELEGATE, UPDATE ACCESS CODE DELEGATE

extension MyForexTradesViewController: UpdateTeamNameAndPhotoViewControllerDelegate, UpdateAccessCodeViewControllerDelegate {
    func didUpdateAccessCode() {
        updateOnboardingRows()
        getCurrentTeam()
    }
    
    func didUpdateTeamNamePhoto() {
        //updateOnboardingRows()
        getCurrentTeam()
    }
    
    func updateOnboardingRows() {
        if brokers.count > 0 {
            adminOnboardingView.connectBrokerImageView.image = UIImage(named: "onboardingGreenBubble")
        }
        
        if teamName != nil {
            adminOnboardingView.namePhotoImageView.image = UIImage(named: "onboardingGreenBubble")
        }
        
        if teamAccessCode != nil {
            adminOnboardingView.accessCodeImageView.image = UIImage(named: "onboardingGreenBubble")
        }
        
        print(teamMyFxBookLink)
        
        if teamMyFxBookLink != nil {
            adminOnboardingView.connectMyFXBookImageView.image = UIImage(named: "onboardingGreenBubble")
        }
        
        print("\(brokers.count) 😓😓😓 \(teamMyFxBookLink)")
        
        
        if teamName != nil && teamAccessCode != nil && teamMyFxBookLink != nil && brokers.count > 0 {
            adminOnboardingView.isHidden = true
            onboardingCompleted = true
        } else {
            adminOnboardingView.isHidden = false
        }
        
    }
}

//MARK: CONNECT BROKER DELEGATE

extension MyForexTradesViewController: ConnectBrokerViewControllerDelegate {
    func didAddBrokerAccount() {
        self.getAccounts()
    }
    
    func cantConnectBroker() {
        //
    }
}
