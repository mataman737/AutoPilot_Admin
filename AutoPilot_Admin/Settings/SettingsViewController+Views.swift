//
//  SettingsViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import Foundation
import UIKit

extension SettingsViewController {
    
    func setupNav() {
        if isDarkMode.bool(forKey: "isDarkMode") {
            self.view.backgroundColor = .darkModeBackground
            textColor = .white
        } else {
            self.view.backgroundColor = .white//UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
            textColor = .black
        }
    }
    
    func setupTableView() {
        mainFeedTableView = UITableView(frame: self.view.frame, style: .grouped)
        mainFeedTableView.isScrollEnabled = false
        mainFeedTableView.alpha = 1.0
        mainFeedTableView.isScrollEnabled = true
        mainFeedTableView.backgroundColor = .clear
        mainFeedTableView.delegate = self
        mainFeedTableView.dataSource = self
        mainFeedTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: settingsTableViewCell)
        mainFeedTableView.register(SettingsSwitchTableViewCellTableViewCell.self, forCellReuseIdentifier: settingsSwitchTableViewCellTableViewCell)
        mainFeedTableView.register(SettingsSwitchImageTableViewCell.self, forCellReuseIdentifier: settingsSwitchImageTableViewCell)
        mainFeedTableView.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: profileImageTableViewCell)
        mainFeedTableView.register(SupportTableViewCell.self, forCellReuseIdentifier: supportTableViewCell)
        mainFeedTableView.register(LogoutTableViewCell.self, forCellReuseIdentifier: logoutTableViewCell)
        mainFeedTableView.allowsSelection = true
        mainFeedTableView.allowsMultipleSelection = false
        mainFeedTableView.contentInset = .zero
        mainFeedTableView.showsVerticalScrollIndicator = false
        mainFeedTableView.separatorStyle = .none
        mainFeedTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: .createAspectRatio(value: 80), right: 0)
        mainFeedTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainFeedTableView)
        mainFeedTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainFeedTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mainFeedTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainFeedTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
    
    func setupLaunchTransition() {
        purpGradientBG.isUserInteractionEnabled = false
        purpGradientBG.alpha = 0
        purpGradientBG.backgroundColor = .black
        purpGradientBG.contentMode = .scaleAspectFill
        self.view.addSubview(purpGradientBG)
        purpGradientBG.fillSuperview()
        
        /*
        enigmaEImageView.image = UIImage(named: "bullXSherbert")
        enigmaEImageView.contentMode = .scaleAspectFill
        enigmaEImageView.translatesAutoresizingMaskIntoConstraints = false
        purpGradientBG.addSubview(enigmaEImageView)
        enigmaEImageView.centerYAnchor.constraint(equalTo: purpGradientBG.centerYAnchor, constant: 0).isActive = true
        enigmaEImageView.centerXAnchor.constraint(equalTo: purpGradientBG.centerXAnchor).isActive = true
        enigmaEImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        enigmaEImageView.widthAnchor.constraint(equalToConstant: 188).isActive = true //167.32
        */
        
        /*
        enigmaEImageView.isHidden = true
        //enigmaEImageView.alpha = 0
        enigmaEImageView.image = UIImage(named: "bull_sherbert") //bull_sherbert //newEnigmaE
        enigmaEImageView.contentMode = .scaleAspectFill
        enigmaEImageView.backgroundColor = .green.withAlphaComponent(0.5)
        enigmaEImageView.translatesAutoresizingMaskIntoConstraints = false
        purpGradientBG.addSubview(enigmaEImageView)
        //enigmaE.centerYAnchor.constraint(equalTo: transitionView.centerYAnchor).isActive = true
        enigmaEImageView.centerYAnchor.constraint(equalTo: purpGradientBG.centerYAnchor, constant: -17).isActive = true
        enigmaEImageView.centerXAnchor.constraint(equalTo: purpGradientBG.centerXAnchor).isActive = true
        enigmaEImageView.heightAnchor.constraint(equalToConstant: 181).isActive = true
        enigmaEImageView.widthAnchor.constraint(equalToConstant: 167.32).isActive = true
        */
    }
}



