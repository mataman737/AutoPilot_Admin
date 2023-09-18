//
//  OrderHistoryViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/10/23.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    
    var navView = UIView()
    var backImageView = UIImageView()
    var backButton = UIButton()
    var titleLabel = UILabel()
    var mainFeedTableView = UITableView()
    var closedOrderTableViewCell = "closedOrderTableViewCell"
    var orders = [MTInstantTradeStatus]()
    var orderHistoryEmptyState = EmptyStateView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNav()
        setupTable()
        setupEmptyStates()
        
        print("\(orders.count) 😅😅😅")
        
        if orders.count > 0 {
            orderHistoryEmptyState.isHidden = true
            orderHistoryEmptyState.hidViews()
        } else {
            orderHistoryEmptyState.isHidden = false
            orderHistoryEmptyState.showViews()
        }
    }

}

//MARK: ACTIONS

extension OrderHistoryViewController {
    @objc func dismissVC() {
        lightImpactGenerator()
        self.dismiss(animated: true)
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE ------------------------------------------------------------------------------------------------------------------------------------

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: closedOrderTableViewCell, for: indexPath) as! ClosedOrderTableViewCell
        setupOrderHistoryValues(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func setupOrderHistoryValues(cell: ClosedOrderTableViewCell, indexPath: IndexPath) {
        cell.assetImageView.image = UIImage(named: "forexBotIcon")

        let signal = orders[indexPath.row]
        
        if let tradingPairZero = signal.order?.symbol {
            cell.currencyPairLabel.text = tradingPairZero.removePeriodsAndDashes()
        }
        
        cell.entryPriceLabel.text = "entry price"
        
        if let openPrice = signal.order?.openPrice {
            cell.entryPriceLabel.text = String(openPrice)
            
        } else {
            cell.entryPriceLabel.text = "nil"
        }
        
        if let currentP = signal.order?.closePrice {
            cell.currentPriceLabel.text = "\(currentP)"
        } else {
            cell.currentPriceLabel.text = "nil"
        }
        
        if let profitValue = signal.order?.profit {
            if let commissionValue = signal.order?.commission {
                let orderProfit = (profitValue + commissionValue).rounded(toPlaces: 4)
                //print("\(profitValue + commissionValue) 🫦🫦🫦")
                cell.unrealizedProfitLabel.text = orderProfit.withCommas()
                if orderProfit > 0 {
                    cell.unrealizedProfitLabel.textColor = .metaTraderBlue
                } else {
                    cell.unrealizedProfitLabel.textColor = .brightRed
                }
            }
        }
        
        //print("did this \(signal.order?.ex?.volume) 👘👘👘 333")
                
        if let volume = signal.order?.lots {
            //print("did this \(signal.order?.type) 👘👘👘 ~~~")
            if let orderType = signal.order?.type {
                if orderType.contains("Sell") {
                    cell.orderTypeLabel.text = "Sell \(volume.rounded(toPlaces: 2))"
                    cell.orderTypeLabel.textColor = UIColor(red: 191/255, green: 103/255, blue: 103/255, alpha: 1.0)
                    //print("did this 👘👘👘 000")
                } else {
                    cell.orderTypeLabel.text = "Buy \(volume.rounded(toPlaces: 2))"
                    cell.orderTypeLabel.textColor = UIColor(red: 103/255, green: 191/255, blue: 151/255, alpha: 1.0)
                    //print("did this 👘👘👘 111")
                }
            }
        }
        
        //print("invalid time zone 😹😹😹 111")
        
        if let time = signal.order?.openTime {
            
            // Create a date formatter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = time.detectDateFormat()
            
            // Convert the string to a Date object
            if let date = dateFormatter.date(from: time) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "M/d @ h:mma"
                let formattedDate = outputFormatter.string(from: date)
                cell.signalTimeLabel.text = formattedDate
            } else {
                cell.signalTimeLabel.text = "Invalid date time"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .createAspectRatio(value: 140)
    }
}
