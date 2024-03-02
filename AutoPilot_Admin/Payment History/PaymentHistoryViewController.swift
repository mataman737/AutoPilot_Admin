//
//  PaymentHistoryViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/23/23.
//

import UIKit
import Lottie

class PaymentHistoryViewController: UIViewController {
    
    var loadingContainer = UIView()
    var loadingLottie = LottieAnimationView()
    var navView = UIView()
    var backImageView = UIImageView()
    var titleLabel = UILabel()
    var dividerLine = UIView()
    var bellImageView = UIImageView()
    var bellButton = UIButton()
    var mainfeedTableView = UITableView()
    var subscriberCountTableViewCell = "subscriberCountTableViewCell"
    var monthLineGraphTableViewCell = "monthLineGraphTableViewCell"
    
    var subscriptions: [String] = ["Total", "Silver", "Gold", "Platinum"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupTableView()
    }
}

//MARK: ACTIONS

extension PaymentHistoryViewController {
    @objc func dismissVC() {
        lightImpactGenerator()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE

extension PaymentHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptions.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: monthLineGraphTableViewCell, for: indexPath) as! MonthLineGraphTableViewCell
            cell.lineGraphView.populateChartData()
            cell.lineGraphView.setUplineChart()
            cell.lineGraphView.lineChart.dataToAppend =  [30, 45, 40, 55, 50, 43, 48, 50, 30, 38, 42, 58, 34, 45, 48, 30, 33, 15, 18, 16, 19, 14, 25, 22, 23, 21, 22, 40, 42, 50, 45, 38, 33, 35, 30, 26, 25, 20, 19, 23, 20, 20, 30, 35, 38, 37, 36, 80, 70, 75, 72, 68, 67, 68, 62, 70, 63, 59, 62, 70, 71, 73, 74, 70, 63, 64, 65, 57, 55, 53, 52, 60, 61, 62, 69, 70, 72, 71, 65, 60, 61, 62, 59, 60, 62, 63, 58, 67, 68, 63]
            cell.lineGraphView.lineChart.populateData()
            cell.lineGraphView.lineChart.lineChartSetup()
            
            cell.monthLabel.text = "August 2023"
            cell.payoutAmountLabel.text = "$23,480"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: subscriberCountTableViewCell, for: indexPath) as! SubscriberCountTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return .createAspectRatio(value: 187)
        } else {
            return .createAspectRatio(value: 68)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .createAspectRatio(value: 55)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .white
        
        let footerDivider = UIView()
        footerDivider.backgroundColor = .black.withAlphaComponent(0.1)
        footerDivider.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(footerDivider)
        footerDivider.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        footerDivider.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        footerDivider.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
        footerDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let footerLabel = UILabel()
        let footerText = "*Payment disbursed on September 15 to debit card ending in 4389"
        footerLabel.setupLabel(text: footerText, txtColor: .black, font: .poppinsRegular(ofSize: .createAspectRatio(value: 10)), txtAlignment: .left)
        footerView.addSubview(footerLabel)
        footerLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        footerLabel.bottomAnchor.constraint(equalTo: footerDivider.topAnchor, constant: -.createAspectRatio(value: 27)).isActive = true
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}
