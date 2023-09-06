//
//  MyForexTradesViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import Foundation
import UIKit
import Lottie

extension MyForexTradesViewController {
    
    func setupNav() {
        
        view.backgroundColor = UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
                        
        navView.backgroundColor = .white
        navView.backgroundColor = UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
        navView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: navHeight).isActive = true
            
        backImageView.image = UIImage(named: "pastResultsIcon")
        backImageView.contentMode = .scaleAspectFill
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backImageView)
        backImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 17).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -8).isActive = true
        backImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        backImageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        backButton.addTarget(self, action: #selector(presentPastResultsManager), for: .touchUpInside)
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: 10).isActive = true
        backButton.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: 10).isActive = true
        
        padlockImageView.image = UIImage(named: "repeat")
        padlockImageView.contentMode = .scaleAspectFill
        padlockImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(padlockImageView)
        padlockImageView.leadingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: 17).isActive = true
        padlockImageView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -8).isActive = true
        padlockImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        padlockImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        padlockButton.addTarget(self, action: #selector(presentSecretVC), for: .touchUpInside)
        padlockButton.backgroundColor = .clear
        padlockButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(padlockButton)
        padlockButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
        padlockButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        padlockButton.trailingAnchor.constraint(equalTo: padlockImageView.trailingAnchor, constant: 10).isActive = true
        padlockButton.bottomAnchor.constraint(equalTo: padlockImageView.bottomAnchor, constant: 10).isActive = true
        
        titleLabel.text = "My Trades"
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
        
        //
        
        plusImageView.image = UIImage(named: "plusImg")
        //plusImageView.backgroundColor = .blue
        plusImageView.contentMode = .scaleAspectFill
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(plusImageView)
        plusImageView.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: -17).isActive = true
        plusImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 0).isActive = true
        plusImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        plusImageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(plusButton)
        plusButton.leadingAnchor.constraint(equalTo: plusImageView.leadingAnchor, constant: -10).isActive = true
        plusButton.topAnchor.constraint(equalTo: plusImageView.topAnchor, constant: -10).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: plusImageView.trailingAnchor, constant: 10).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: plusImageView.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupTable() {
        mainFeedTableView = UITableView(frame: self.view.frame, style: .plain)
        mainFeedTableView.isScrollEnabled = false
        mainFeedTableView.alpha = 1.0
        mainFeedTableView.isScrollEnabled = true
        mainFeedTableView.backgroundColor = .clear//UIColor(red: 244/255, green: 245/255, blue: 274/255, alpha: 1.0)
        mainFeedTableView.delegate = self
        mainFeedTableView.dataSource = self
        mainFeedTableView.register(NoSignalsTableViewCell.self, forCellReuseIdentifier: noSignalsTableViewCell)
        mainFeedTableView.register(SignalsTableViewCell.self, forCellReuseIdentifier: signalsTableViewCell)
        
        mainFeedTableView.register(OpenOrdersTableViewCell.self, forCellReuseIdentifier: openOrdersTableViewCell)
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
        messagesEmptyState.isHidden = true
        //messagesEmptyState.delegate = self
        messagesEmptyState.lockLabel.text = "😭"
        messagesEmptyState.lockTitleLabel.text = "No Forex Signals"//"Chat with Addison"
        messagesEmptyState.lockDetailLabel.setupLineHeight(myText: "We will send you a notificaiton when\na new signal is posted!", myLineSpacing: 4)
        messagesEmptyState.lockDetailLabel.textAlignment = .center
        messagesEmptyState.squadUpButton.setTitle("Browse Darrell's Program", for: .normal)
        messagesEmptyState.squadUpButton.isHidden = true
        messagesEmptyState.backgroundColor = .clear
        messagesEmptyState.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(messagesEmptyState)
        messagesEmptyState.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        messagesEmptyState.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        messagesEmptyState.heightAnchor.constraint(equalToConstant: 245).isActive = true
        messagesEmptyState.widthAnchor.constraint(equalToConstant: 305).isActive = true
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
