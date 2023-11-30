//
//  AffiliatesViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 11/30/23.
//

import UIKit

class AffiliatesViewController: UIViewController {
    
    var navView = UIView()
    var backImageView = UIImageView()
    var backButton = UIButton()
    var titleLabel = UILabel()
    var mainfeedTableView = UITableView()
    var teamMemberTableViewCell = "teamMemberTableViewCell"
    var teamMembersEmptyStateCell = "teamMembersEmptyStateCell"
    var affiliates: [[String]] = [["John Ramos", "12 active | 20 lifetime"], ["John Ramos", "9 active | 14 lifetime"], ["John Ramos", "6 active | 7 lifetime"], ["John Ramos", "2 active | 2 lifetime"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.masksToBounds = true
        self.hidesBottomBarWhenPushed = true
        self.view.backgroundColor = .darkModeBackground
        setupNav()
        setupTableView()
    }
}

//MARK: ACTIONS

extension AffiliatesViewController {
    @objc func popBack() {
        lightImpactGenerator()
        self.dismiss(animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE

extension AffiliatesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if affiliates.count > 0 {
            return affiliates.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if affiliates.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: teamMemberTableViewCell, for: indexPath) as! TeamMemberTableViewCell
            
            let member = affiliates[indexPath.row]
            
            cell.chatNameLabel.textColor = .white
            cell.chatDescriptionLabel.textColor = .white.withAlphaComponent(0.5)
            cell.last30DayPercentChange.textColor = .white.withAlphaComponent(0.5)
            cell.chatNameLabel.text = "John Ramos"
            cell.chatDescriptionLabel.text = "12 active | 20 lifetime"
            cell.last30DayPercentChange.text = "\(indexPath.row + 1)"
            
            
            /*
            cell.chatNameLabel.text = "\(member.firstName ?? "") \(member.lastName ?? "")"
            if let joinDate = member.teamJoinDate {
                cell.chatDescriptionLabel.text = "Member since: \(convertToDateFormatted(joinDate))"
            } else {
                cell.chatDescriptionLabel.text = "No join date"
            }
            
            if let urlString = member.profilePhotoUrl, let url = URL(string: urlString) {
                cell.circleImageView.kf.setImage(with: url)
            } else {
                cell.circleImageView.image = UIImage(named: "enigmaUserPH")
            }
            */
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: teamMembersEmptyStateCell, for: indexPath) as! TeamMembersEmptyStateCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if affiliates.count > 0 {
            return .createAspectRatio(value: 73)
        } else {
            return .createAspectRatio(value: 400)
        }
    }
}
