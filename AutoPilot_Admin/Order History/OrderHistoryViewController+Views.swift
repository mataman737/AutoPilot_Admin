//
//  OrderHistoryViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/10/23.
//

import Foundation
import UIKit

extension OrderHistoryViewController {
    
    func setupNav() {
        
                
        navView.backgroundColor = .white
        navView.backgroundColor = .white//UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
        navView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 50)).isActive = true
        
        backImageView.image = UIImage(named: "newDownArrow")
        backImageView.contentMode = .scaleAspectFill
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backImageView)
        backImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: .createAspectRatio(value: 17)).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -.createAspectRatio(value: 8)).isActive = true
        backImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        backImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        backButton.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        
        titleLabel.text = "Trade History"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .newBlack
        titleLabel.font = .sofiaProMedium(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: navView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor).isActive = true
    }
    
    func setupTable() {
        mainFeedTableView = UITableView(frame: self.view.frame, style: .plain)
        mainFeedTableView.isScrollEnabled = false
        mainFeedTableView.alpha = 1.0
        mainFeedTableView.isScrollEnabled = true
        mainFeedTableView.backgroundColor = .clear//UIColor(red: 244/255, green: 245/255, blue: 274/255, alpha: 1.0)
        mainFeedTableView.delegate = self
        mainFeedTableView.dataSource = self
        mainFeedTableView.register(ClosedOrderTableViewCell.self, forCellReuseIdentifier: closedOrderTableViewCell)
        mainFeedTableView.allowsSelection = true
        mainFeedTableView.allowsMultipleSelection = false
        mainFeedTableView.contentInset = .zero
        mainFeedTableView.showsVerticalScrollIndicator = false
        mainFeedTableView.separatorStyle = .none
        mainFeedTableView.automaticallyAdjustsScrollIndicatorInsets = false
        mainFeedTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        mainFeedTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainFeedTableView)
        mainFeedTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainFeedTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainFeedTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mainFeedTableView.topAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
    }
    
    func setupEmptyStates() {
        orderHistoryEmptyState.isHidden = true
        //orderHistoryEmptyState.delegate = self
        orderHistoryEmptyState.lockLabel.text = "😭"
        orderHistoryEmptyState.lockTitleLabel.text = "No Closed Orders"//"Chat with Addison"
        orderHistoryEmptyState.lockDetailLabel.setupLineHeight(myText: "All of your closed orders will be displayed\nhere once you start trading!", myLineSpacing: 4)
        orderHistoryEmptyState.lockDetailLabel.textAlignment = .center
        orderHistoryEmptyState.squadUpButton.setTitle("Browse Darrell's Program", for: .normal)
        orderHistoryEmptyState.squadUpButton.isHidden = true
        orderHistoryEmptyState.backgroundColor = .clear
        orderHistoryEmptyState.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(orderHistoryEmptyState)
        orderHistoryEmptyState.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        orderHistoryEmptyState.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        orderHistoryEmptyState.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 245)).isActive = true
        orderHistoryEmptyState.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 305)).isActive = true
    }
}
