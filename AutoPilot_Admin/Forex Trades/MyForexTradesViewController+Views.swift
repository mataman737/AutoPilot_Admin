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
    
    func setupTransition() {
        /*
        fromLogin.setValue(false, forKey: "fromLogin")
        transitionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        transitionView.backgroundColor = .red
        UIApplication.shared.windows.first(where: { $0.isKeyWindow})?.addSubview(transitionView)
        
        self.view.addSubview(.re)
        */
        
        UIApplication.shared.windows.first?.addSubview(transitionView)
        
        transitionView.layer.zPosition = 100
        transitionView.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
        transitionView.translatesAutoresizingMaskIntoConstraints = false
        //let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        //currentWindow?.addSubview(transitionView)
        transitionView.fillSuperview()
        
        appLogoImageView.image = UIImage(named: "smartTraderLogoDark")
        appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        transitionView.addSubview(appLogoImageView)
        appLogoImageView.centerYAnchor.constraint(equalTo: transitionView.centerYAnchor).isActive = true
        appLogoImageView.centerXAnchor.constraint(equalTo: transitionView.centerXAnchor).isActive = true
        appLogoImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 240)).isActive = true
        appLogoImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 128)).isActive = true
        
        
        //let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        //view.backgroundColor = .black
        //let _: Void? = UIApplication.shared.windows.first?.addSubview(view)
        //UIApplication.shared.windows.first?.addSubview(view)
        //window.addSubview(view)
    }
    
    func setupNav() {
                          
        
        view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
                        
        //navView.backgroundColor = .white
        navView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        navView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 90)).isActive = true
                
        //LEFT SIDE OF NAV
        
        bookImageView.image = UIImage(named: "book")
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(bookImageView)
        bookImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: .createAspectRatio(value: 17)).isActive = true
        //bookImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        bookImageView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -8).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        
        bookButton.addTarget(self, action: #selector(showOrderHistoryVC), for: .touchUpInside)
        bookButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(bookButton)
        bookButton.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        bookButton.topAnchor.constraint(equalTo: bookImageView.topAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        bookButton.trailingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        bookButton.bottomAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        
        brokerLinkImageView.image = UIImage(named: "brokerLink")
        brokerLinkImageView.contentMode = .scaleAspectFill
        brokerLinkImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(brokerLinkImageView)
        brokerLinkImageView.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: .createAspectRatio(value: 17)).isActive = true
        brokerLinkImageView.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor).isActive = true
        brokerLinkImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        brokerLinkImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        
        brokerLinkButton.addTarget(self, action: #selector(connectBrokerTapped), for: .touchUpInside)
        brokerLinkButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(brokerLinkButton)
        brokerLinkButton.leadingAnchor.constraint(equalTo: brokerLinkImageView.leadingAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        brokerLinkButton.trailingAnchor.constraint(equalTo: brokerLinkImageView.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        brokerLinkButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        brokerLinkButton.bottomAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        
        // RIGHT SIDE OF NAV
        
        plusImageView.image = UIImage(named: "plusImg")
        plusImageView.contentMode = .scaleAspectFill
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(plusImageView)
        plusImageView.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: -.createAspectRatio(value: 17)).isActive = true
        plusImageView.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor).isActive = true
        plusImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        plusImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(plusButton)
        plusButton.leadingAnchor.constraint(equalTo: plusImageView.leadingAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        plusButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: plusImageView.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        
        // TITLE
        
        titleLabel.text = "My Trades"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .newBlack
        titleLabel.font = .sofiaProMedium(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: navView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: brokerLinkImageView.centerYAnchor).isActive = true
        
        dividerLine.backgroundColor = UIColor.newBlack.withAlphaComponent(0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 0).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: 0).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupTable() {
        mainFeedTableView = UITableView(frame: self.view.frame, style: .plain)
        mainFeedTableView.isScrollEnabled = false
        mainFeedTableView.alpha = 1.0
        mainFeedTableView.isScrollEnabled = true
        mainFeedTableView.backgroundColor = .clear
        mainFeedTableView.delegate = self
        mainFeedTableView.dataSource = self
        mainFeedTableView.register(OpenOrdersTableViewCell.self, forCellReuseIdentifier: openOrdersTableViewCell)
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
        
        adminOnboardingView.addTeamNamePhotoContainer.addTarget(self, action: #selector(presentUpdateTeamNamePhoto), for: .touchUpInside)
        adminOnboardingView.accessCodeContainer.addTarget(self, action: #selector(presentUpdateAccessCode), for: .touchUpInside)
        adminOnboardingView.brokerContainer.addTarget(self, action: #selector(connectBrokerTapped), for: .touchUpInside)
        adminOnboardingView.connectMyFXBookContainer.addTarget(self, action: #selector(didTapMyFXBook), for: .touchUpInside)
        adminOnboardingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(adminOnboardingView)
        adminOnboardingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        adminOnboardingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        adminOnboardingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        adminOnboardingView.topAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        
        //didConnectBroker.set(false, forKey: "didConnectBroker")
    }
    
    func setupEmptyStates() {
        myForexTradesEmptyState.isHidden = true
        //myForexTradesEmptyState.delegate = self
        myForexTradesEmptyState.lockLabel.text = "🚀"
        myForexTradesEmptyState.lockTitleLabel.text = "No Active Orders"
        myForexTradesEmptyState.lockDetailLabel.setupLineHeight(myText: "All of your active & pending orders will be\ndisplayed here once you start trading!\nTap the '+' to get started.", myLineSpacing: 4)
        myForexTradesEmptyState.lockDetailLabel.textAlignment = .center
        myForexTradesEmptyState.squadUpButton.setTitle("Browse Darrell's Program", for: .normal)
        myForexTradesEmptyState.squadUpButton.isHidden = true
        myForexTradesEmptyState.backgroundColor = .clear
        myForexTradesEmptyState.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myForexTradesEmptyState)
        myForexTradesEmptyState.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myForexTradesEmptyState.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        myForexTradesEmptyState.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 245)).isActive = true
        myForexTradesEmptyState.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 305)).isActive = true
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
