//
//  MyConnectedBrokerAccountViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/11/23.
//

import UIKit

protocol MyConnectedBrokerAccountViewControllerDelegate: AnyObject {
    func didSelectAddNewBroker()
    func didDeleteBroker()
}

class MyConnectedBrokerAccountViewController: UIViewController {
        
    var isTradingPercentBased = UserDefaults()
    var isDarkMode = UserDefaults()
    weak var delegate: MyConnectedBrokerAccountViewControllerDelegate?
    var blackLayer = UIView()
    var contentContainer = UIView()
    var myBrokersTableView = UITableView()
    var myBrokerOptionsTableViewCell = "myBrokerOptionsTableViewCell"
    var addBrokerTableViewCell = "addBrokerTableViewCell"
    let tableViewHeaderFooterReuseIdentifier = "MyHeaderFooterClass"
    var whiteBGView = UIView()
    var confirmButton = ContinueButton()
    var tableTop: NSLayoutConstraint!
    var selectedOption: Int = 0
    var brokers = [String]()
    var didSelectAddNewBroker = false
    var confirmView = ConfirmAlertView()
    var usersPreferredBroker = UserDefaults()
    var brokerSelectedToDelete = ""
    var canAddMultipleBrokers = false
    var balanceDouble: Double = 0
    var userTradingPercent = UserDefaults()
    var userLotSize = UserDefaults()
    var didSetTradingDefault = UserDefaults()
    //var tradingDefaults: TradingDefaults?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getAccounts()
        getTradingDefaults()
        setupColors()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateViewsIn()
    }

    func getAccounts() {
        /*
        API.sharedInstance.getMTTradingAccounts { success, accounts, error in
            guard error == nil else {
                print("\(error!) 😶‍🌫️😶‍🌫️😶‍🌫️ 000")
                return
            }
            
            guard success, let accounts = accounts else {
                print("error getting accounts")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.brokers = accounts
                print("⚡️⚡️⚡️ \(accounts) ⚡️⚡️⚡️")
                self?.myBrokersTableView.reloadData()
                
                
                if self?.brokers.count == 1 {
                    self?.usersPreferredBroker.set(self?.brokers[0], forKey: "selectedBroker")
                } else {
                    if let preferredBroker = self?.usersPreferredBroker.value(forKey: "selectedBroker") {
                        if let brokerCount = self?.brokers.count {
                            if brokerCount > 0 {
                                for brkr in 0...(brokerCount) - 1 {
                                    if self?.brokers[brkr] == preferredBroker as! String {
                                        self?.myBrokersTableView.selectRow(at: IndexPath(row: brkr + 1, section: 0), animated: false, scrollPosition: .none)
                                    }
                                }
                            }
                        }
                    }
                }
                //print("\(self?.brokers)")
                //print("\(self?.usersPreferredBroker.value(forKey: "selectedBroker")) 👅👅👅")
            }
        }
        */
    }
    
    func getTradingDefaults() {
        /*
        API.sharedInstance.getTradingDefaults { success, defaults, error in
            guard error == nil else {
                print("\(error!) 🥼🥼🥼 000")
                return
            }
            
            guard success, let defaults = defaults else {
                print("error getting trading defaults 🥼🥼🥼 111")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("\(defaults) 🥼🥼🥼 222")
                self?.tradingDefaults = defaults
                self?.myBrokersTableView.reloadData()
            }
        }
        */
    }
}

//MARK: ACTIONS

extension MyConnectedBrokerAccountViewController {
    @objc func animateViewsIn() {
        UIView.animate(withDuration: 0.35, delay: 0.1, options: []) {
            self.blackLayer.alpha = 0.75
            self.view.layoutIfNeeded()
            self.contentContainer.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { success in
            //
        }
    }
        
    @objc func dismissViews() {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.blackLayer.alpha = 0
            self.contentContainer.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { (success) in
            self.dismiss(animated: false) {
                if self.didSelectAddNewBroker {
                    //self.errorImpactGenerator()
                    //let toastNoti = ToastNotificationView()
                    //toastNoti.presentError(withMessage: "Coming soon!")
                    self.delegate?.didSelectAddNewBroker()
                }
            }
        }
    }
    
    @objc func confirmTapped() {
        successImpactGenerator()
        /*
        confirmView.showLoadingSpinner()
        print("🥳🥳🥳 000")
        API.sharedInstance.deleteMTAccount(account: brokerSelectedToDelete) { success, _, error in
            guard error == nil else {
                print("\(error!) 🥳🥳🥳 111")
                
                DispatchQueue.main.async {
                    self.errorImpactGenerator()
                    let toastNoti = ToastNotificationView()
                    toastNoti.presentError(withMessage: "Error deleting account")
                    self.dismissViews()
                }
                
                return
            }
            
            guard success else {
                print("error deleting account")
                
                DispatchQueue.main.async {
                    self.errorImpactGenerator()
                    let toastNoti = ToastNotificationView()
                    toastNoti.presentError(withMessage: "Error deleting account")
                    self.dismissViews()
                }
                
                return
            }
            
            DispatchQueue.main.async {
                print("did this 🥳🥳🥳 333")
                self.perform(#selector(self.confirmDeleteDelay), with: self, afterDelay: 0.5)
                self.delegate?.didDeleteBroker()
            }
        }
        */
    }
    
    @objc func confirmDeleteDelay() {
        self.confirmView.showDeny()
    }
    
    @objc func presentDefaultTradingAmtVC() {
        lightImpactGenerator()
        /*
        self.view.endEditing(true)
        let pickOptionsVC = DefaultTradingAmountViewController()
        pickOptionsVC.delegate = self
        pickOptionsVC.accountBalance = balanceDouble
        pickOptionsVC.accountBalancePercentSelected = false
        //pickOptionsVC.dollarsPerPipSelected = dollarsPerPipSelected
        //pickOptionsVC.delegate = self
        pickOptionsVC.modalPresentationStyle = .overFullScreen
        self.present(pickOptionsVC, animated: false)
        */
    }
}


//MARK: TableView Delegate & Datasource

extension MyConnectedBrokerAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brokers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myBrokerOptionsTableViewCell, for: indexPath) as! MyBrokerOptionsTableViewCell
        cell.dividerLine.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 230/255, alpha: 1.0)
        cell.containerView.backgroundColor = .white
        let accountName = brokers[indexPath.row - 1].trimAccount()
        
        /*
        if let userDefaultLot = tradingDefaults?.lotSize {
            cell.serverLabel.text = "\(userDefaultLot) lot size"
            self.didSetTradingDefault.setValue(true, forKey: "didSetTradingDefault")
        } else {
            cell.serverLabel.text = "Set default trading amount"
        }
        */
        
        /*
         if didSetTradingDefault.bool(forKey: "didSetTradingDefault") {
         if isTradingPercentBased.bool(forKey: "isTradingPercentBased") {
         if let tradingPercent = userTradingPercent.string(forKey: "userTradingPercent") {
         cell.serverLabel.text = "\(tradingPercent)%"
         } else {
         cell.serverLabel.text = "Set default trading amount"
         }
         } else {
         
         if let tradingPercent = userLotSize.string(forKey: "userLotSize") {
         cell.serverLabel.text = "\(tradingPercent) lot size"
         } else {
         cell.serverLabel.text = "Set default trading amount"
         }
         }
         } else {
         cell.serverLabel.text = "Set default trading amount"
         }
         */
        
        cell.containerLabel.text = "\(accountName)"
        //cell.serverLabel.text = brokers[indexPath.row - 1].getServer()
        cell.delegate = self
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = .white
        cell.containerLabel.textColor = .newBlack
        cell.serverLabel.textColor = .newBlack.withAlphaComponent(0.5)
        cell.threeDotsImageView.setImageColor(color: .newBlack.withAlphaComponent(0.5))
        
        if let preferredBroker = usersPreferredBroker.value(forKey: "selectedBroker") {
            if brokers[indexPath.row - 1] == preferredBroker as! String {
                cell.selectedState()
            }
            cell.brokerIndex = indexPath.row - 1
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .createAspectRatio(value: 60)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .createAspectRatio(value: 500)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if canAddMultipleBrokers {
            return .createAspectRatio(value: 80)
        } else {
            if indexPath.row == 0 {
                return 0
            } else {
                return .createAspectRatio(value: 80)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = MyBrokersHeader()
        headerView.dividerLine.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 230/255, alpha: 1.0)
        headerView.whiteView.backgroundColor = .white
        headerView.checkoutTitleLabel.text = "My Brokers"
        headerView.checkoutTitleLabel.textColor = .newBlack
        headerView.numberOfItemsLabel.text = brokers.count > 1 ? "\(brokers.count) connected brokers" : "\(brokers.count) connected broker"
        headerView.numberOfItemsLabel.textColor = .newBlack.withAlphaComponent(0.5)
        headerView.dismissButton.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
        headerView.invisibleButton.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let cell = tableView.cellForRow(at: indexPath) as! MyBrokerOptionsTableViewCell
            cell.didMakeSelection()
            usersPreferredBroker.set(brokers[indexPath.row - 1], forKey: "selectedBroker")
            //print("\(self.usersPreferredBroker.value(forKey: "selectedBroker")) 🔥🔥🔥")
            presentDefaultTradingAmtVC()
        } else {
            self.didSelectAddNewBroker = true
            self.dismissViews()
            
        }
    }
    
    /*
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //Uncomment when we want to allow multiple brokers
        if canAddMultipleBrokers {
            if indexPath.row != 0 {
                let cell = tableView.cellForRow(at: indexPath) as! MyBrokerOptionsTableViewCell
                cell.newOptionSelected()
            }
        }
         
        print("\(indexPath.row) 🩲🩲🩲")
    }
    */
}

//MARK: ITEM OPTIONS DELEGATE

extension MyConnectedBrokerAccountViewController: MyBrokerOptionsTableViewCellDelegate {
    func clickedToDeleteBroker(brokersIndex: Int) {
        /*
        brokerSelectedToDelete = brokers[brokersIndex]
        let accountName = brokerSelectedToDelete.trimAccount()
        confirmView.reqTitleLabel.text = "Delete \(accountName)"
        let deleteDetailString = "The \(accountName) account will\nbe deleted along with the connection to\nthe broker."
        //"By tapping confirm, the \(accountName) account will be deleted along with the connection to the broker."
        confirmView.reqDetailLabel.setupLineHeight(myText: deleteDetailString, myLineSpacing: 3)
        confirmView.reqDetailLabel.textAlignment = .center
        confirmView.confirmLabel.textColor = .red
        confirmView.animateViewsin()
        */
    }
}

//MARK: CONFIRM VIEW DELEGATE

extension MyConnectedBrokerAccountViewController: ConfirmAlertViewDelegte {
    func cancelTapped() {
        
    }
    
    func didFinishCheckmarkAnimation() {
        successImpactGenerator()
        dismissViews()
    }
    
    func popVCBack() {
        //
    }
    
    func didCompleteLoadingAnimation() {
        //
    }
}
