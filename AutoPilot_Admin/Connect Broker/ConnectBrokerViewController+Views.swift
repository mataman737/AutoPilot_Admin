//
//  ConnectBrokerViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/11/23.
//

import Foundation
import UIKit
import Lottie

extension ConnectBrokerViewController {
    
    func setupColors() {
//        if isDarkMode.bool(forKey: "isDarkMode") {
//            varBlackColor = .white
//            varWhiteColor = .darkModeBackground
//        } else {
            varBlackColor = .black
            varWhiteColor = .white
//        }
    }
    
    func setupViews() {
        
        //let opacityTapped = UITapGestureRecognizer(target: self, action: #selector(dimissVC))
        //opacityLayer.addGestureRecognizer(opacityTapped)
        opacityLayer.backgroundColor = .black
        opacityLayer.alpha = 0
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
        
        mainScrollView.tag = 3
        mainScrollView.delegate = self
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.backgroundColor = .clear
        mainScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.1)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainScrollView)
        mainScrollView.fillSuperview()
                
        wrapper.backgroundColor = .clear
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(wrapper)
        wrapper.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        wrapper.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 0).isActive = true
        wrapper.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        wrapper.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
        
        mainContainer.backgroundColor = varWhiteColor
        mainContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainContainer.layer.cornerRadius = .createAspectRatio(value: 15)
        mainContainer.layer.masksToBounds = true
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(mainContainer)
        mainContainer.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: 0).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 0).isActive = true
        mainContainer.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        mainContainerHeight = mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 617)) //366 //446 //526
        mainContainerHeight.isActive = true
        mainContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        keyLine.backgroundColor = varWhiteColor
        keyLine.layer.cornerRadius = .createAspectRatio(value: 4)/2
        keyLine.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(keyLine)
        keyLine.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        keyLine.bottomAnchor.constraint(equalTo: mainContainer.topAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        keyLine.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 34)).isActive = true
        keyLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        keyLine.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        skipLabel.text = "Cancel"
        skipLabel.textAlignment = .center
        skipLabel.textColor = varBlackColor.withAlphaComponent(0.65)
        skipLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        skipLabel.numberOfLines = 0
        skipLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(skipLabel)
        skipLabel.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -.createAspectRatio(value: 80)).isActive = true
        skipLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: 0).isActive = true
        
        nextButton.addTarget(self, action: #selector(goToNextStep), for: .touchUpInside)
        nextButton.isUserInteractionEnabled = true
        nextButton.purpleBG.backgroundColor = .themePurple
        nextButton.continueLabel.text = "Next"//.localiz()
        nextButton.confirmLabel.text = "Confirm"//.localiz()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(nextButton)
        nextButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 26)).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 26)).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -.createAspectRatio(value: 120)).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        skipButton.addTarget(self, action: #selector(dimissVC), for: .touchUpInside)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(skipButton)
        skipButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        skipButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor).isActive = true
        skipButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor).isActive = true
        
        //
        
        navTitleLabel.text = "Connect a broker"
        navTitleLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 18))
        navTitleLabel.textColor = varBlackColor
        navTitleLabel.textAlignment = .center
        navTitleLabel.numberOfLines = 0
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(navTitleLabel)
        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 19)).isActive = true
        
        let detailLabelZeroText = "Please enter an account name. This can be whatever you want!"
        detailLabelZero.setupLineHeight(myText: detailLabelZeroText, myLineSpacing: .createAspectRatio(value: 6))
        detailLabelZero.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 14))
        detailLabelZero.textColor = varBlackColor.withAlphaComponent(0.5)
        detailLabelZero.textAlignment = .center
        detailLabelZero.numberOfLines = 0
        detailLabelZero.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(detailLabelZero)
        detailLabelZero.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 39)).isActive = true
        detailLabelZero.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 39)).isActive = true
        detailLabelZero.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 13)).isActive = true
        
        detailLabelOne.transform = CGAffineTransform(translationX: 50, y: 0)
        detailLabelOne.alpha = 0
        detailLabelOne.isHidden = true
        
        var detailLabelOneText = "Please enter your login & server credentials below to connect your broker to Enigma."
        if isNVUDemo.bool(forKey: "isNVUDemo") {
            detailLabelOneText = "Please enter your login & server credentials below to connect your broker to Smart Wealth."
        }
        detailLabelOne.setupLineHeight(myText: detailLabelOneText, myLineSpacing: .createAspectRatio(value: 6))
        detailLabelOne.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 14))
        detailLabelOne.textColor = varBlackColor.withAlphaComponent(0.5)
        detailLabelOne.textAlignment = .center
        detailLabelOne.numberOfLines = 0
        detailLabelOne.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(detailLabelOne)
        detailLabelOne.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 39)).isActive = true
        detailLabelOne.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 39)).isActive = true
        detailLabelOne.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 13)).isActive = true
        
        //
        
        usernameEmailContainer.transform = CGAffineTransform(translationX: 50, y: 0)
        usernameEmailContainer.alpha = 0
        usernameEmailContainer.isHidden = true
        createEntryContainer(containerView: usernameEmailContainer, viewToPin: detailLabelOne, isFirst: true)
        createTextField(tfField: usernameEmailTextField, viewToPin: usernameEmailContainer, ph: "Account Number / Login"/*.localiz()*/)
        usernameEmailTextField.returnKeyType = .next
        usernameEmailTextField.autocapitalizationType = .none
        usernameEmailTextField.tag = 1
        
        passwordContainer.transform = CGAffineTransform(translationX: 50, y: 0)
        passwordContainer.alpha = 0
        passwordContainer.isHidden = true
        createEntryContainer(containerView: passwordContainer, viewToPin: usernameEmailContainer, isFirst: false)
        createTextField(tfField: passwordTextField, viewToPin: passwordContainer, ph: "Trader Password"/*.localiz()*/)
        passwordTextField.returnKeyType = .next
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tag = 2
        
        /*
        eyeOffImageView.isHidden = false
        eyeOffImageView.image = UIImage(named: "eye-off")
        eyeOffImageView.contentMode = .scaleAspectFill
        eyeOffImageView.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.addSubview(eyeOffImageView)
        eyeOffImageView.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        eyeOffImageView.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor).isActive = true
        eyeOffImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        eyeOffImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        */
        
        let eyAnimation = LottieAnimation.named("eyeOnOff")
        eyeLottie.isUserInteractionEnabled = false
        eyeLottie.alpha = 1.0
        eyeLottie.animation = eyAnimation
        eyeLottie.contentMode = .scaleAspectFill
        eyeLottie.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.addSubview(eyeLottie)
        eyeLottie.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor).isActive = true
        eyeLottie.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        eyeLottie.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 50)).isActive = true
        eyeLottie.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 50)).isActive = true
        eyeLottie.play(fromFrame: 8, toFrame: 8, loopMode: .playOnce, completion: nil)
        
        secureEntryButton.addTarget(self, action: #selector(didTapSecureEntry), for: .touchUpInside)
        secureEntryButton.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.addSubview(secureEntryButton)
        secureEntryButton.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: 0).isActive = true
        secureEntryButton.topAnchor.constraint(equalTo: passwordContainer.topAnchor, constant: 0).isActive = true
        secureEntryButton.bottomAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 0).isActive = true
        secureEntryButton.leadingAnchor.constraint(equalTo: eyeLottie.leadingAnchor, constant: -.createAspectRatio(value: 20)).isActive = true
        
        dividerLine.transform = CGAffineTransform(translationX: 50, y: 0)
        dividerLine.alpha = 0
        dividerLine.isHidden = true
        dividerLine.backgroundColor = varBlackColor.withAlphaComponent(0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(dividerLine)
        dividerLine.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        dividerLine.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 2)).isActive = true
        dividerLine.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 86)).isActive = true
        
        serverContainer.transform = CGAffineTransform(translationX: 50, y: 0)
        serverContainer.alpha = 0
        serverContainer.isHidden = true
        serverContainer.isUserInteractionEnabled = true
        
        let serverContainerTapped = UITapGestureRecognizer(target: self, action: #selector(didTapServer))
        serverContainer.addGestureRecognizer(serverContainerTapped)
        
        serverusernameEmailTextField.isUserInteractionEnabled = false
        createServerContainer(containerView: serverContainer, viewToPin: dividerLine, isFirst: true)
        createTextField(tfField: serverusernameEmailTextField, viewToPin: serverContainer, ph: "Broker / Server"/*.localiz()*/)
        serverusernameEmailTextField.returnKeyType = .done
        serverusernameEmailTextField.autocapitalizationType = .none
        serverusernameEmailTextField.tag = 4
        
        serverOptionsPickerView.tag = 1
        serverOptionsPickerView.alpha = 0
        serverOptionsPickerView.isUserInteractionEnabled = false
        serverOptionsPickerView.delegate = self
        serverOptionsPickerView.dataSource = self
        serverOptionsPickerView.tintColor = varWhiteColor
        serverOptionsPickerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(serverOptionsPickerView)
        serverOptionsPickerView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        serverOptionsPickerView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        serverOptionsPickerView.topAnchor.constraint(equalTo: serverContainer.bottomAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        serverOptionsPickerView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 215)).isActive = true
        
        brokerOptionsPickerView.tag = 2
        brokerOptionsPickerView.alpha = 0
        brokerOptionsPickerView.isUserInteractionEnabled = false
        brokerOptionsPickerView.delegate = self
        brokerOptionsPickerView.dataSource = self
        brokerOptionsPickerView.tintColor = varWhiteColor
        brokerOptionsPickerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(brokerOptionsPickerView)
        brokerOptionsPickerView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        brokerOptionsPickerView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        brokerOptionsPickerView.topAnchor.constraint(equalTo: serverContainer.bottomAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        brokerOptionsPickerView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 215)).isActive = true
        
        //
                
        createEntryContainer(containerView: accountusernameEmailContainer, viewToPin: detailLabelZero, isFirst: true)
        createTextField(tfField: accountusernameEmailTextField, viewToPin: accountusernameEmailContainer, ph: "Account name"/*.localiz()*/)
        accountusernameEmailTextField.returnKeyType = .done
        accountusernameEmailTextField.autocapitalizationType = .none
        accountusernameEmailTextField.tag = 3
        
        accountNameCharacterCountLabel.text = "\(accountNameCharacterCount)/25"
        accountNameCharacterCountLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 12))
        accountNameCharacterCountLabel.textColor = varBlackColor
        accountNameCharacterCountLabel.textAlignment = .right
        accountNameCharacterCountLabel.numberOfLines = 0
        accountNameCharacterCountLabel.translatesAutoresizingMaskIntoConstraints = false
        accountusernameEmailContainer.addSubview(accountNameCharacterCountLabel)
        accountNameCharacterCountLabel.trailingAnchor.constraint(equalTo: accountusernameEmailContainer.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        accountNameCharacterCountLabel.centerYAnchor.constraint(equalTo: accountusernameEmailContainer.centerYAnchor, constant: 0).isActive = true
        
        noBrokerLabel.text = "Don't have a broker? Click here"//"I don't have a broker"
        noBrokerLabel.textAlignment = .center
        noBrokerLabel.textColor = isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.5) : .black.withAlphaComponent(0.5)
        noBrokerLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        noBrokerLabel.numberOfLines = 0
        noBrokerLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(noBrokerLabel)
        noBrokerLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        noBrokerLabel.topAnchor.constraint(equalTo: accountusernameEmailContainer.bottomAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        
        noBrokerButton.addTarget(self, action: #selector(noBrokerClicked), for: .touchUpInside)
        noBrokerButton.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(noBrokerButton)
        noBrokerButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        noBrokerButton.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        noBrokerButton.topAnchor.constraint(equalTo: accountusernameEmailContainer.bottomAnchor).isActive = true
        noBrokerButton.bottomAnchor.constraint(equalTo: noBrokerLabel.bottomAnchor, constant: .createAspectRatio(value: 20)).isActive = true
    }
    
    func setupTableView() {
        
        brokersTableContainer.isUserInteractionEnabled = false
        brokersTableContainer.alpha = 0
        brokersTableContainer.backgroundColor = varWhiteColor
        brokersTableContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(brokersTableContainer)
        brokersTableContainer.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        brokersTableContainer.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor).isActive = true
        brokersTableContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        brokersTableContainer.topAnchor.constraint(equalTo: serverContainer.bottomAnchor).isActive = true
        
        availableBrokersTableView = UITableView(frame: self.view.frame, style: .grouped)
        availableBrokersTableView.tag = 1
        availableBrokersTableView.isUserInteractionEnabled = false
        availableBrokersTableView.isScrollEnabled = true
        availableBrokersTableView.backgroundColor = .clear
        availableBrokersTableView.delegate = self
        availableBrokersTableView.dataSource = self
        availableBrokersTableView.register(ConnectBrokerTableViewCell.self, forCellReuseIdentifier: connectBrokerTableViewCell)
        availableBrokersTableView.allowsSelection = true
        availableBrokersTableView.allowsMultipleSelection = false
        availableBrokersTableView.contentInset = .zero
        availableBrokersTableView.showsVerticalScrollIndicator = false
        availableBrokersTableView.separatorStyle = .none
        availableBrokersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: .createAspectRatio(value: 80), right: 0)
        availableBrokersTableView.translatesAutoresizingMaskIntoConstraints = false
        brokersTableContainer.addSubview(availableBrokersTableView)
        availableBrokersTableView.fillSuperview()
        
        brokerServersTableView = UITableView(frame: self.view.frame, style: .grouped)
        brokerServersTableView.tag = 2
        brokerServersTableView.alpha = 0
        brokerServersTableView.isUserInteractionEnabled = false
        brokerServersTableView.isScrollEnabled = true
        brokerServersTableView.backgroundColor = .clear
        brokerServersTableView.delegate = self
        brokerServersTableView.dataSource = self
        brokerServersTableView.register(ConnectBrokerTableViewCell.self, forCellReuseIdentifier: connectBrokerTableViewCell)
        brokerServersTableView.allowsSelection = true
        brokerServersTableView.allowsMultipleSelection = false
        brokerServersTableView.contentInset = .zero
        brokerServersTableView.showsVerticalScrollIndicator = false
        brokerServersTableView.separatorStyle = .none
        brokerServersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: .createAspectRatio(value: 80), right: 0)
        brokerServersTableView.translatesAutoresizingMaskIntoConstraints = false
        brokersTableContainer.addSubview(brokerServersTableView)
        brokerServersTableView.fillSuperview()
        
        
    }
    
    func setupLoader() {
        connectingLottie.isHidden = true
        connectingLottie.alpha = 0
        connectingLottie.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
        let checkAnimation = LottieAnimation.named("broker_loading")
        connectingLottie.isUserInteractionEnabled = false
        connectingLottie.alpha = 1.0
        connectingLottie.loopMode = .loop
        connectingLottie.animation = checkAnimation
        connectingLottie.contentMode = .scaleAspectFill
        connectingLottie.backgroundColor = .clear
        connectingLottie.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(connectingLottie)
        connectingLottie.centerYAnchor.constraint(equalTo: mainContainer.centerYAnchor, constant: -.createAspectRatio(value: 75)).isActive = true
        connectingLottie.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        connectingLottie.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 150)).isActive = true
        connectingLottie.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 150)).isActive = true
        //connectingLottie.play()
        //print("😀😀😀 - \(connectingLottie.logHierarchyKeypaths()) - 😀😀😀")
    
        let pink = isNVUDemo.bool(forKey: "isNVUDemo") ? UIColor(red: 42/255, green: 47/255, blue: 97/255, alpha: 1.0) : UIColor(red: 225/255, green: 61/255, blue: 226/255, alpha: 1.0)
        let mid = isNVUDemo.bool(forKey: "isNVUDemo") ? UIColor(red: 77/255, green: 110/255, blue: 142/255, alpha: 1.0) : UIColor(red: 229/255, green: 91/255, blue: 136/255, alpha: 1.0)
        let orange = isNVUDemo.bool(forKey: "isNVUDemo") ? UIColor(red: 118/255, green: 181/255, blue: 193/255, alpha: 1.0) : UIColor(red: 232/255, green: 121/255, blue: 48/255, alpha: 1.0)
        
        var i = 0
        let loadingLayers = ["Layer 1 Outlines.Group 1.Stroke 1.Color", "Layer 1 Outlines.Group 2.Stroke 1.Color", "Layer 1 Outlines.Group 3.Stroke 1.Color", "Layer 1 Outlines.Group 4.Stroke 1.Color", "Layer 1 Outlines.Group 5.Stroke 1.Color", "Layer 1 Outlines.Group 6.Stroke 1.Color", "Layer 1 Outlines 2.Group 1.Stroke 1.Color", "Layer 1 Outlines 2.Group 2.Stroke 1.Color", "Layer 1 Outlines 2.Group 3.Stroke 1.Color", "Layer 1 Outlines 2.Group 4.Stroke 1.Color", "Layer 1 Outlines 2.Group 5.Stroke 1.Color", "Layer 1 Outlines 2.Group 6.Stroke 1.Color", "Layer 1 Outlines 3.Group 1.Stroke 1.Color", "Layer 1 Outlines 3.Group 2.Stroke 1.Color", "Layer 1 Outlines 3.Group 3.Stroke 1.Color", "Layer 1 Outlines 3.Group 4.Stroke 1.Color", "Layer 1 Outlines 3.Group 5.Stroke 1.Color", "Layer 1 Outlines 3.Group 6.Stroke 1.Color"]
        
        for layer in 1...loadingLayers.count {
            let keyPath = AnimationKeypath(keypath: "\(loadingLayers[layer - 1])")
            if i == 0 {
                let colorProvider = ColorValueProvider(pink.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 1 {
                let colorProvider = ColorValueProvider(pink.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 2 {
                let colorProvider = ColorValueProvider(pink.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 3 {
                let colorProvider = ColorValueProvider(pink.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 4 {
                let colorProvider = ColorValueProvider(pink.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 5 {
                let colorProvider = ColorValueProvider(pink.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 6 {
                let colorProvider = ColorValueProvider(mid.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 7 {
                let colorProvider = ColorValueProvider(mid.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 8 {
                let colorProvider = ColorValueProvider(mid.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 9 {
                let colorProvider = ColorValueProvider(mid.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 10 {
                let colorProvider = ColorValueProvider(mid.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 11 {
                let colorProvider = ColorValueProvider(mid.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 12 {
                let colorProvider = ColorValueProvider(orange.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 13 {
                let colorProvider = ColorValueProvider(orange.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 14 {
                let colorProvider = ColorValueProvider(orange.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 15 {
                let colorProvider = ColorValueProvider(orange.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 16 {
                let colorProvider = ColorValueProvider(orange.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 17 {
                let colorProvider = ColorValueProvider(orange.lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else {
                let colorProvider = ColorValueProvider(UIColor(red: 232/255, green: 121/255, blue: 47/255, alpha: 1.0).lottieColorValue)
                connectingLottie.setValueProvider(colorProvider, keypath: keyPath)
            }
            i += 1
        }
        
        connectingLabel.isHidden = true
        connectingLabel.alpha = 0
        connectingLabel.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
        connectingLabel.text = "Connecting to broker..."
        connectingLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 20))
        connectingLabel.textColor = varBlackColor
        connectingLabel.textAlignment = .center
        connectingLabel.numberOfLines = 0
        connectingLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(connectingLabel)
        connectingLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: 0).isActive = true
        connectingLabel.topAnchor.constraint(equalTo: connectingLottie.bottomAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        
        //
        
        let checkAnimationGradient = LottieAnimation.named("gradientCheck")
        checkmarkOneLottie.isUserInteractionEnabled = false
        checkmarkOneLottie.alpha = 0
        checkmarkOneLottie.animation = checkAnimationGradient
        checkmarkOneLottie.contentMode = .scaleAspectFill
        checkmarkOneLottie.loopMode = .playOnce
        checkmarkOneLottie.animationSpeed = 0.75
        checkmarkOneLottie.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(checkmarkOneLottie)
        checkmarkOneLottie.centerYAnchor.constraint(equalTo: connectingLottie.centerYAnchor).isActive = true
        checkmarkOneLottie.centerXAnchor.constraint(equalTo: connectingLottie.centerXAnchor, constant: 0).isActive = true
        checkmarkOneLottie.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 130)).isActive = true
        checkmarkOneLottie.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 130)).isActive = true
        //checkmarkOneLottie.play()
        
        orderPlaced.alpha = 0
        orderPlaced.isUserInteractionEnabled = false
        orderPlaced.text = "Success!"
        orderPlaced.textColor = varBlackColor
        orderPlaced.textAlignment = .center
        orderPlaced.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 25))
        orderPlaced.numberOfLines = 0
        orderPlaced.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(orderPlaced)
        orderPlaced.topAnchor.constraint(equalTo: checkmarkOneLottie.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        orderPlaced.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        
        checkBackOfficeLabel.alpha = 0
        orderPlaced.isUserInteractionEnabled = false
        let checkBackOfficeLabelText = "You are connected to your broker and your \(accountName) account has been created!"
        checkBackOfficeLabel.setupLineHeight(myText: checkBackOfficeLabelText, myLineSpacing: .createAspectRatio(value: 4))
        checkBackOfficeLabel.textColor = varBlackColor.withAlphaComponent(0.75)
        checkBackOfficeLabel.textAlignment = .center
        checkBackOfficeLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 12))
        checkBackOfficeLabel.numberOfLines = 0
        checkBackOfficeLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(checkBackOfficeLabel)
        checkBackOfficeLabel.topAnchor.constraint(equalTo: orderPlaced.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        checkBackOfficeLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 70)).isActive = true
        checkBackOfficeLabel.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 70)).isActive = true
        
        doneButton.isUserInteractionEnabled = false
        doneButton.addTarget(self, action: #selector(dimissVC), for: .touchUpInside)
        doneButton.isUserInteractionEnabled = true
        doneButton.purpleBG.backgroundColor = .themePurple
        doneButton.continueLabel.text = "Done"//.localiz()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(doneButton)
        doneButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 26)).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 26)).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -.createAspectRatio(value: 90)).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        doneButton.transform = CGAffineTransform(translationX: 0, y: 200)
        
        //
        
        var dismissButton = UIButton()
        dismissButton.addTarget(self, action: #selector(dimissVC), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dismissButton)
        dismissButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: mainContainer.topAnchor).isActive = true
    }
}

//MARK: HELPERS

extension ConnectBrokerViewController {
    func createEntryContainer(containerView: UIView, viewToPin: UIView, isFirst: Bool) {
        containerView.layer.cornerRadius = .createAspectRatio(value: 52)/2
        containerView.backgroundColor = varBlackColor.withAlphaComponent(0.06)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        containerView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 52)).isActive = true
        if isFirst {
            containerView.topAnchor.constraint(equalTo: viewToPin.bottomAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        } else {
            containerView.topAnchor.constraint(equalTo: viewToPin.bottomAnchor, constant: .createAspectRatio(value: 16)).isActive = true
        }
    }
    
    func createServerContainer(containerView: UIView, viewToPin: UIView, isFirst: Bool) {
        containerView.layer.cornerRadius = .createAspectRatio(value: 52)/2
        containerView.backgroundColor = varBlackColor.withAlphaComponent(0.06)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        containerView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 52)).isActive = true
        serverTop = containerView.topAnchor.constraint(equalTo: viewToPin.bottomAnchor, constant: .createAspectRatio(value: 16))
        serverTop.isActive = true
    }
    
    func createTextField(tfField: UITextField, viewToPin: UIView, ph: String) {
        tfField.alpha = 1.0
        tfField.returnKeyType = .done
        tfField.textColor = varBlackColor
        tfField.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 16))
        tfField.autocorrectionType = .no
        tfField.tintColor = varBlackColor
        tfField.attributedPlaceholder = NSAttributedString(string: ph, attributes: [
            .foregroundColor: varBlackColor.withAlphaComponent(0.4),
            .font: UIFont.sofiaProRegular(ofSize: .createAspectRatio(value: 16))
        ])
        tfField.delegate = self
        tfField.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.addSubview(tfField)
        tfField.leadingAnchor.constraint(equalTo: viewToPin.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        tfField.centerYAnchor.constraint(equalTo: viewToPin.centerYAnchor, constant: 0).isActive = true
        tfField.trailingAnchor.constraint(equalTo: viewToPin.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        tfField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
    }
    
    func createEmailContainer(containerView: UIView, viewToPin: UIView, isFirst: Bool, containerToPin: UIView) {
        containerView.layer.cornerRadius = 52/2
        containerView.backgroundColor = varBlackColor.withAlphaComponent(0.06)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        containerView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 52)).isActive = true
        containerView.topAnchor.constraint(equalTo: viewToPin.bottomAnchor, constant: .createAspectRatio(value: 24)).isActive = true
    }
}


