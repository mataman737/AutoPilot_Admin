//
//  ConnectViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/27/23.
//

import Foundation
import UIKit
import Lottie

extension ConnectViewController {
    
    func modifyConstraints() {
        
        
    }
    
    func setupNav() {
        
        view.backgroundColor = UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
                        
        navView.backgroundColor = .white
        navView.backgroundColor = UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
        navView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 90)).isActive = true
        
        backImageView.image = UIImage(named: "arrowLeft")
        backImageView.setImageColor(color: .black)
        backImageView.contentMode = .scaleAspectFill
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backImageView)
        backImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 13).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -8).isActive = true
        backImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        backImageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: 10).isActive = true
        backButton.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: 10).isActive = true
        
        titleLabel.text = "My Team"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .newBlack
        titleLabel.font = .sofiaProMedium(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: navView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor).isActive = true
        
        dividerLine.backgroundColor = UIColor.newBlack.withAlphaComponent(0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 0).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: 0).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
        plusImageView.image = UIImage(named: "videoIcon")
        plusImageView.setImageColor(color: .black)
        plusImageView.contentMode = .scaleAspectFill
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(plusImageView)
        plusImageView.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: -24).isActive = true
        plusImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 0).isActive = true
        plusImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        plusImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        plusButton.addTarget(self, action: #selector(createNewEvent), for: .touchUpInside)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(plusButton)
        plusButton.leadingAnchor.constraint(equalTo: plusImageView.leadingAnchor, constant: -10).isActive = true
        plusButton.topAnchor.constraint(equalTo: plusImageView.topAnchor, constant: -10).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: plusImageView.trailingAnchor, constant: 10).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: plusImageView.bottomAnchor, constant: 10).isActive = true
                        
        bellImageView.image = UIImage(named: "notiBell")
        bellImageView.setImageColor(color: .black)
        bellImageView.contentMode = .scaleAspectFill
        bellImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(bellImageView)
        bellImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 17).isActive = true
        bellImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 0).isActive = true
        bellImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        bellImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        bellButton.addTarget(self, action: #selector(didTapNotiBell), for: .touchUpInside)
        bellButton.backgroundColor = .clear
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(bellButton)
        bellButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 0).isActive = true
        bellButton.topAnchor.constraint(equalTo: navView.topAnchor, constant: 0).isActive = true
        bellButton.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        bellButton.trailingAnchor.constraint(equalTo: bellImageView.trailingAnchor, constant: 20).isActive = true
        
        rewardsImageView.image = UIImage(named: "whitelistKey")
        rewardsImageView.setImageColor(color: .black)
        rewardsImageView.contentMode = .scaleAspectFill
        rewardsImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(rewardsImageView)
        rewardsImageView.trailingAnchor.constraint(equalTo: plusImageView.leadingAnchor, constant: -15).isActive = true
        rewardsImageView.centerYAnchor.constraint(equalTo: plusImageView.centerYAnchor, constant: 0).isActive = true
        rewardsImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        rewardsImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        //rewardsButton.addTarget(self, action: #selector(didTapWhiteList), for: .touchUpInside)
        rewardsButton.backgroundColor = .clear
        rewardsButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(rewardsButton)
        rewardsButton.leadingAnchor.constraint(equalTo: rewardsImageView.leadingAnchor, constant: -15).isActive = true
        rewardsButton.topAnchor.constraint(equalTo: navView.topAnchor, constant: 0).isActive = true
        rewardsButton.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        rewardsButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: 0).isActive = true
        
    }
    
    func setupTableView() {
        discoverTableView = UITableView(frame: self.view.frame, style: .grouped)
        discoverTableView.alpha = 1.0
        discoverTableView.isScrollEnabled = true
        discoverTableView.backgroundColor = .clear
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        discoverTableView.register(ConnectChannelTableViewCell.self, forCellReuseIdentifier: connectChannelTableViewCell)
        discoverTableView.register(TeamMemberTableViewCell.self, forCellReuseIdentifier: teamMemberTableViewCell)
        discoverTableView.allowsSelection = true
        discoverTableView.allowsMultipleSelection = false
        discoverTableView.contentInset = .zero
        discoverTableView.showsVerticalScrollIndicator = false
        discoverTableView.separatorStyle = .none
        discoverTableView.contentInset = UIEdgeInsets(top: .createAspectRatio(value: 20), left: 0, bottom: 100, right: 0)
        discoverTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(discoverTableView)
        discoverTableView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        discoverTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        discoverTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        discoverTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupLoadingIndicator() {
        
        loadingContainer.isHidden = false
        loadingContainer.alpha = 1.0
        loadingContainer.backgroundColor = .white//UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingContainer)
        loadingContainer.topAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        loadingContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loadingContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loadingContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
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

