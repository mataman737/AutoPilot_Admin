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
    var traders = [Admin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupNav()
        setupTableView()
        getTeamTraders()
    }
    
    func getTeamTraders() {
        API.sharedInstance.getTeamTraders { success, traders, error in
            guard error == nil else {
                print(error!)
                print("\(error!) 😶‍🌫️😶‍🌫️😶‍🌫️ 000")
                return
            }
            
            guard success, let traders = traders else {
                print("error getting traders 😶‍🌫️😶‍🌫️😶‍🌫️ 111")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.traders = traders
                print("\(traders.count) did this 😶‍🌫️😶‍🌫️😶‍🌫️ 222 \n\(traders[0])")
                for trader in traders {
                    print("\(trader.displayName) 😶‍🌫️😶‍🌫️😶‍🌫️ \(trader.adminType)")
                }
                
                self?.mainfeedTableView.reloadData()
            }
        }
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
        return traders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teamMemberTableViewCell, for: indexPath) as! TeamMemberTableViewCell
        let tradersIndex = traders[indexPath.row]
        cell.chatNameLabel.text = tradersIndex.displayName
        if let adminType = tradersIndex.adminType {
            cell.chatDescriptionLabel.text = tradersIndex.adminType
        } else {
            cell.chatDescriptionLabel.text = "No type"
        }
        //cell.circleImageView.image = UIImage(named: "enigmaUserPH")
        
        if let urlString = tradersIndex.profilePhotoUrl, let url = URL(string: urlString) {
            cell.circleImageView.kf.setImage(with: url)
        } else {
            cell.circleImageView.image = UIImage(named: "enigmaUserPH")
        }
        
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
