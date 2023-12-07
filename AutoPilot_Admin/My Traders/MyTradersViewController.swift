//
//  MyTradersViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 10/3/23.
//

import UIKit

class MyTradersViewController: UIViewController {

    var navView = UIView()
    var backImageView = UIImageView()
    var titleLabel = UILabel()
    var dividerLine = UIView()
    var bellImageView = UIImageView()
    var bellButton = UIButton()
    var mainfeedTableView = UITableView()
    var teamMemberTableViewCell = "teamMemberTableViewCell"
    var plusButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupNav()
        setupTableView()
    }
}

//MARK: ACTIONS

extension MyTradersViewController {
    @objc func dismissVC() {
        lightImpactGenerator()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goToAddTrader() {
        lightImpactGenerator()
        let updateAccessCodeVC = PickTraderTypeViewController()//AddTraderViewController()
        updateAccessCodeVC.delegate = self
        updateAccessCodeVC.modalPresentationStyle = .overFullScreen
        self.present(updateAccessCodeVC, animated: false)
    }
}

//MARK: PICK TRADER TYPE DELEGATE

extension MyTradersViewController: PickTraderTypeViewControllerDelegate {
    func didTapTrader(type: String) {
        let updateAccessCodeVC = AddTraderViewController()
        updateAccessCodeVC.traderType = type
        updateAccessCodeVC.titleLabel.text = type == "admin" ? "Add New Admin" : "Add New Trader"
        updateAccessCodeVC.modalPresentationStyle = .overFullScreen
        self.present(updateAccessCodeVC, animated: false)
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE

extension MyTradersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teamMemberTableViewCell, for: indexPath) as! TeamMemberTableViewCell
        cell.chatNameLabel.text = "John Doe"
        cell.chatDescriptionLabel.text = "Trader"
        cell.circleImageView.image = UIImage(named: "enigmaUserPH")
        cell.last30DayPercentChange.isHidden = true
        return cell
    }
    
    func convertToDateFormatted(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/d/yy"
        
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .createAspectRatio(value: 73)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lightImpactGenerator()
    }
}
