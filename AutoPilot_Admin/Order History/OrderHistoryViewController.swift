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
        
        if orders.count > 1 {
            orderHistoryEmptyState.isHidden = true
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
            print("did this \(signal.order?.type) 👘👘👘 ~~~")
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
}
