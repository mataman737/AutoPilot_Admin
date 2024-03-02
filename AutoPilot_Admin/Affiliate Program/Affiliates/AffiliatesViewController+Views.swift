//
//  AffiliatesViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 11/30/23.
//

import Foundation
import UIKit
import Lottie

extension AffiliatesViewController {
    func setupNav() {
        navView.backgroundColor = .darkModeBackground
        navView.layer.zPosition = 2
        navView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 55)).isActive = true
        
        backImageView.image = UIImage(named: "newDownArrow")
        backImageView.setImageColor(color: .white)
        backImageView.contentMode = .scaleAspectFill
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backImageView)
        backImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: .createAspectRatio(value: 16)).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -.createAspectRatio(value: 4)).isActive = true
        backImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        backImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        backButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        backButton.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        
        titleLabel.text = "Affiliates"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .darkModeTextColor
        titleLabel.font = .poppinsSemiBold(ofSize: .createAspectRatio(value: 18))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: navView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor).isActive = true
    }
    
    func setupTableView() {
        mainfeedTableView = UITableView(frame: self.view.frame, style: .grouped)
        mainfeedTableView.alpha = 1.0
        mainfeedTableView.isScrollEnabled = true
        mainfeedTableView.backgroundColor = .clear
        mainfeedTableView.delegate = self
        mainfeedTableView.dataSource = self
        mainfeedTableView.register(TeamMemberTableViewCell.self, forCellReuseIdentifier: teamMemberTableViewCell)
        mainfeedTableView.register(TeamMembersEmptyStateCell.self, forCellReuseIdentifier: teamMembersEmptyStateCell)
        mainfeedTableView.allowsSelection = true
        mainfeedTableView.allowsMultipleSelection = false
        mainfeedTableView.contentInset = .zero
        mainfeedTableView.showsVerticalScrollIndicator = false
        mainfeedTableView.separatorStyle = .none
        mainfeedTableView.contentInset = UIEdgeInsets(top: .createAspectRatio(value: 0), left: 0, bottom: 100, right: 0)
        mainfeedTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainfeedTableView)
        mainfeedTableView.topAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        mainfeedTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainfeedTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainfeedTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
