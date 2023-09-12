//
//  SettingsViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import Foundation
import UIKit
import Lottie

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
    }
    
    func setupLoadingIndicator() {
        loadingContainer.isHidden = false
        loadingContainer.alpha = 1.0
        loadingContainer.backgroundColor = .white//UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingContainer)
        loadingContainer.fillSuperview()
//        loadingContainer.topAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
//        loadingContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        loadingContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        loadingContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let checkAnimation = LottieAnimation.named("tripleSpinner")
        loadingLottie.isUserInteractionEnabled = false
        loadingLottie.alpha = 1.0
        loadingLottie.loopMode = .loop
        loadingLottie.animation = checkAnimation
        loadingLottie.contentMode = .scaleAspectFill
        loadingLottie.backgroundColor = .clear
        loadingLottie.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.addSubview(loadingLottie)
        loadingLottie.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor).isActive = true
        loadingLottie.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor).isActive = true
        loadingLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingLottie.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingLottie.play()
        //print("😀😀😀 - \(loadingLottie.logHierarchyKeypaths()) - 😀😀😀")
    
        var i = 0
        let loadingLayers = ["Shape Layer 1.Ellipse 1.Stroke 1.Color", "Shape Layer 2.Ellipse 1.Stroke 1.Color", "Shape Layer 3.Ellipse 1.Stroke 1.Color"]
        for layer in 1...loadingLayers.count {
            let keyPath = AnimationKeypath(keypath: "\(loadingLayers[layer - 1])")
            if i == 0 {
                let colorProvider = ColorValueProvider(UIColor(red: 225/255, green: 61/255, blue: 227/255, alpha: 1.0).lottieColorValue)
                loadingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 1 {
                let colorProvider = ColorValueProvider(UIColor(red: 229/255, green: 93/255, blue: 132/255, alpha: 1.0).lottieColorValue)
                loadingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else {
                let colorProvider = ColorValueProvider(UIColor(red: 232/255, green: 121/255, blue: 47/255, alpha: 1.0).lottieColorValue)
                loadingLottie.setValueProvider(colorProvider, keypath: keyPath)
            }
            i += 1
        }
    }
}



