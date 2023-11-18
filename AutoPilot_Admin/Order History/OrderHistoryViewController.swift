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
        let signal = orders[indexPath.row]
        
        if let currentP = signal.order?.closePrice,
           let tradingPairZero = signal.order?.symbol,
           let openPrice = signal.order?.openPrice,
           let profitValue = signal.order?.profit,
           let commissionValue = signal.order?.commission,
           let volume = signal.order?.lots, let orderType = signal.order?.type, let time = signal.order?.closeTime,
           let pipDifference = calculatePipDifference(tradingPair: tradingPairZero, entryPriceStr: openPrice, closePriceStr: currentP) {
            
            cell.currentPriceLabel.text = calucateRoundedPosition(tradingPair: tradingPairZero, price: currentP)//"\(currentP)"
            cell.entryPriceLabel.text = calucateRoundedPosition(tradingPair: tradingPairZero, price: openPrice)//"\(currentP)"//String(openPrice)
                        
            let orderProfit = (profitValue + commissionValue).rounded(toPlaces: 4)
            cell.unrealizedProfitLabel.text = orderProfit.withCommas()
            if orderProfit > 0 {
                cell.unrealizedProfitLabel.textColor = .metaTraderBlue
            } else if orderProfit == 0 {
                cell.unrealizedProfitLabel.textColor = .lightGray
            } else {
                cell.unrealizedProfitLabel.textColor = .brightRed
            }
            
            if tradingPairZero != "" {
                let isSingular = pipDifference == 1
                let pipText = isSingular ? "pip" : "pips"
                if pipDifference > 0 {
                    cell.tickerLabel.text = "+\(pipDifference) \(pipText)"
                } else if pipDifference == 0 {
                    cell.tickerLabel.text = "\(pipDifference) pips"
                } else {
                    cell.tickerLabel.text = "-\(pipDifference) \(pipText)"
                }
                
                cell.orderTypeLabel.textColor = UIColor(red: 103/255, green: 191/255, blue: 151/255, alpha: 1.0)
                
            } else {
                cell.currencyPairLabel.text = "Deposit"
                cell.orderTypeLabel.text = "+"
            }
            
            if orderType.contains("Sell") {
                cell.orderTypeLabel.text = "Sell \(volume.rounded(toPlaces: 2))"
                cell.orderTypeLabel.textColor = UIColor(red: 191/255, green: 103/255, blue: 103/255, alpha: 1.0)
            } else {
                cell.orderTypeLabel.text = "Buy \(volume.rounded(toPlaces: 2))"
                cell.orderTypeLabel.textColor = UIColor(red: 103/255, green: 191/255, blue: 151/255, alpha: 1.0)
            }
            
            if tradingPairZero != "" {
                cell.currencyPairLabel.text = tradingPairZero
            } else {
                cell.currencyPairLabel.text = "Deposit"
                cell.orderTypeLabel.text = "+"
            }
            
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
            //}
        } else {
            cell.currentPriceLabel.text = "nil"
            cell.entryPriceLabel.text = "nil"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .createAspectRatio(value: 140)
    }
    
    func calculatePipDifference(tradingPair: String, entryPriceStr: Double, closePriceStr: Double) -> Int? {
        var pipValue: Double = 0.0001 // Default pip value for most currency pairs
        
        // Check trading pair type
        if tradingPair.hasSuffix("JPY") {
            pipValue = 0.01
        } else if tradingPair.contains("XAUUSD") || tradingPair.contains("30") || tradingPair.contains("100") || tradingPair.contains("500") {
            pipValue = 0.1
        } else if tradingPair == "US30" {
            pipValue = 1
        }
        
        let pipDifferenceStopLoss = Int(round(abs(closePriceStr - entryPriceStr) / pipValue))
        return pipDifferenceStopLoss
    }
    
    func calucateRoundedPosition(tradingPair: String, price: Double) -> String? {
        var stringPrice = ""
        if tradingPair.hasSuffix("JPY") {
            stringPrice = "\(price.rounded(toPlaces: 3))"
        } else if tradingPair.contains("XAUUSD") || tradingPair.contains("30") || tradingPair.contains("100") || tradingPair.contains("500") {
            stringPrice = "\(price.rounded(toPlaces: 2))"
        } else {
            stringPrice = "\(price.rounded(toPlaces: 5))"
        }
        return stringPrice
    }
    
}
