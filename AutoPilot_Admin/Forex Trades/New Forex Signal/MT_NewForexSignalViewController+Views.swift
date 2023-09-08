//
//  MT_NewForexSignalViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import Foundation
import UIKit
import Lottie

extension MT_NewForexSignalViewController {
    
    func setupColors() {
        if isDarkMode.bool(forKey: "isDarkMode") {
            self.view.backgroundColor = .darkModeBackground
            variableColor = .white
            variableWhiteColor = .darkModeBackground
        } else {
            self.view.backgroundColor = .white
            variableColor = .newBlack
            variableWhiteColor = .white
        }
    }
    
    func modifyConstraints() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        switch screenHeight {
        case .iphone5() :
            dismissTop = 32
            swipeViewBottom = 24
            contentSize = 1.5
            print("111 😇")
        case .iphone78() :
            dismissTop = 32
            swipeViewBottom = 24
            contentSize = 1.5
            print("222 😇")
        case .iphone78Plus() :
            dismissTop = 32
            swipeViewBottom = 24
            print("333 😇")
            /*
        case .iphone11() :
            print("444 😇")
        case .iphone12AndPro() :
            print("555 😇")
        case .iphone12ProMax() :
            print("666 😇")
            */
        default:
            print("777 😇")
        }
    }
    
    func setupViews() {
        
        mainScrollView.contentInsetAdjustmentBehavior = .never
        mainScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * contentSize)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainScrollView)
        mainScrollView.fillSuperview()
        
        contentContainer.backgroundColor = variableWhiteColor
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(contentContainer)
        //contentContainer.fillSuperview()
        contentContainer.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true
        contentContainer.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        contentContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        contentContainer.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        dismissImageView.image = UIImage(named: "gradXNVU")
        dismissImageView.contentMode = .scaleAspectFill
        dismissImageView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(dismissImageView)
        dismissImageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        dismissImageView.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: dismissTop).isActive = true
        dismissImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        dismissImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(dismissButton)
        dismissButton.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: contentContainer.topAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: dismissImageView.trailingAnchor, constant: 15).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: dismissImageView.bottomAnchor, constant: 15).isActive = true
        
        downArrowImageView.image = UIImage(named: "downGradientNVU")
        downArrowImageView.contentMode = .scaleAspectFill
        downArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(downArrowImageView)
        downArrowImageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        downArrowImageView.centerYAnchor.constraint(equalTo: dismissImageView.centerYAnchor, constant: 0).isActive = true
        downArrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        downArrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 17)).isActive = true
        
        //orderTypeLabel.text = forexSignal.orderType.modifyOrderString(sigEntryPrice: signal.entryPrice ?? "", sigTakeProfitOne: signal.takeProfit1 ?? "")
        
        orderTypeLabel.text = "Pick Order Type"
        orderTypeLabel.textColor = variableColor
        orderTypeLabel.textAlignment = .right
        orderTypeLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 12))
        orderTypeLabel.numberOfLines = 0
        orderTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(orderTypeLabel)
        orderTypeLabel.trailingAnchor.constraint(equalTo: downArrowImageView.leadingAnchor, constant: -.createAspectRatio(value: 1)).isActive = true
        orderTypeLabel.centerYAnchor.constraint(equalTo: downArrowImageView.centerYAnchor).isActive = true
        
        orderTypeButton.addTarget(self, action: #selector(didTapOrderType), for: .touchUpInside)
        orderTypeButton.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(orderTypeButton)
        orderTypeButton.topAnchor.constraint(equalTo: contentContainer.topAnchor).isActive = true
        orderTypeButton.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        orderTypeButton.leadingAnchor.constraint(equalTo: orderTypeLabel.leadingAnchor, constant: -10).isActive = true
        orderTypeButton.bottomAnchor.constraint(equalTo: orderTypeLabel.bottomAnchor, constant: 15).isActive = true
        
        //assetTitleLabel.text = forexSignal?.asset
        assetTitleLabel.textColor = variableColor
        assetTitleLabel.textAlignment = .left
        assetTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 20))
        assetTitleLabel.numberOfLines = 0
        assetTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(assetTitleLabel)
        assetTitleLabel.leadingAnchor.constraint(equalTo: dismissImageView.leadingAnchor, constant: 0).isActive = true
        assetTitleLabel.topAnchor.constraint(equalTo: dismissImageView.bottomAnchor, constant: .createAspectRatio(value: 34)).isActive = true
                
        let accessoryContainer = UIView()
        accessoryContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 66)
        accessoryContainer.backgroundColor = .clear
                
        entryPriceTextField.inputAccessoryView = accessoryContainer
        takeProfitTextField.inputAccessoryView = accessoryContainer
        takeProfitTwoTextField.inputAccessoryView = accessoryContainer
        takeProfitThreeTextField.inputAccessoryView = accessoryContainer
        stopLossTextField.inputAccessoryView = accessoryContainer
        tradeTypeTextField.inputAccessoryView = accessoryContainer
        
        //continueButton.delegate = self
        continueButton.addShadow(shadowColor: variableColor, shadowOffset: CGSize(width: 4, height: 4), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        continueButton.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)
        continueButton.continueLabel.text = "Confirm"
        continueButton.continueLabel.textColor = .white
        continueButton.confirmLabel.textColor = .white
        continueButton.purpleBG.image = UIImage(named: "buttonGradientNVU")
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        accessoryContainer.addSubview(continueButton)
        continueButton.leadingAnchor.constraint(equalTo: accessoryContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: accessoryContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        continueButton.topAnchor.constraint(equalTo: accessoryContainer.topAnchor, constant: 0).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        //LIVE PRICE
        /*
        createContainer(containerView: livePriceContainer, sectionTitleLabel: livePriceTitleLabel, isFirst: true)
        livePriceTitleLabel.text = "Live Price"
        //entryPriceContainer.topAnchor.constraint(equalTo: lotSizeContainer.bottomAnchor, constant: 0).isActive = true
        livePriceContainer.topAnchor.constraint(equalTo: assetTitleLabel.bottomAnchor, constant: 26).isActive = true
        
        setupLiveLabel(liveLabel: livePriceLabel, pinView: livePriceContainer, theText: "0.0 | 0 pips")
        */
        //ENTRY PRICE
        
        createContainer(containerView: entryPriceContainer, sectionTitleLabel: entryPriceTitleLabel, isFirst: false)
        entryPriceTitleLabel.text = "Entry Price"
        //entryPriceContainer.topAnchor.constraint(equalTo: lotSizeContainer.bottomAnchor, constant: 0).isActive = true
        //entryPriceContainer.topAnchor.constraint(equalTo: assetTitleLabel.bottomAnchor, constant: 26).isActive = true
        entryPriceContainer.topAnchor.constraint(equalTo: assetTitleLabel.bottomAnchor, constant: 26).isActive = true
        //entryPriceContainer.topAnchor.constraint(equalTo: livePriceContainer.bottomAnchor, constant: 0).isActive = true
        
        
        //entryPriceTextField
        setupTextField(txtField: entryPriceTextField, pinView: entryPriceContainer, theText: "")
        entryPriceTextField.placeholder = "0.0"
        entryPriceTextField.tag = 2
        entryPriceUSDLabel.isHidden = true
        
        //TAKE PROFIT ONE
        
        createContainer(containerView: takeProfitContainer, sectionTitleLabel: takeProfitTitleLabel, isFirst: false)
        takeProfitTitleLabel.text = "Take Profit 1"
        takeProfitContainer.topAnchor.constraint(equalTo: entryPriceContainer.bottomAnchor, constant: 0).isActive = true
        takeProfitTextField.placeholder = "0.0"
        setupTextField(txtField: takeProfitTextField, pinView: takeProfitContainer, theText: "")
        setupDetailLabel(detailLabel: takeProfitDetailLabel, viewToPin: takeProfitContainer)
        
        //TAKE PROFIT TWO
        
        createContainer(containerView: takeProfitTwoContainer, sectionTitleLabel: takeProfitTwoTitleLabel, isFirst: false)
        takeProfitTwoTitleLabel.text = "Take Profit 2 (Optional)"
        takeProfitTwoContainer.topAnchor.constraint(equalTo: takeProfitContainer.bottomAnchor, constant: 0).isActive = true
        takeProfitTwoTextField.placeholder = "0.0"
        setupTextField(txtField: takeProfitTwoTextField, pinView: takeProfitTwoContainer, theText: "")
        setupDetailLabel(detailLabel: takeProfitTwoDetailLabel, viewToPin: takeProfitTwoContainer)
        
        //TAKE PROFIT THREE
        
        createContainer(containerView: takeProfitThreeContainer, sectionTitleLabel: takeProfitThreeTitleLabel, isFirst: false)
        takeProfitThreeTitleLabel.text = "Take Profit 3 (Optional)"
        takeProfitThreeContainer.topAnchor.constraint(equalTo: takeProfitTwoContainer.bottomAnchor, constant: 0).isActive = true
        takeProfitThreeTextField.placeholder = "0.0"
        setupTextField(txtField: takeProfitThreeTextField, pinView: takeProfitThreeContainer, theText: "")
        setupDetailLabel(detailLabel: takeProfitThreeDetailLabel, viewToPin: takeProfitThreeContainer)
        
        //STOP LOSS
        
        createContainer(containerView: stopLossContainer, sectionTitleLabel: stopLossTitleLabel, isFirst: false)
        stopLossTitleLabel.text = "Stop Loss"
        stopLossTitleLabel.isUserInteractionEnabled = false
        stopLossContainer.topAnchor.constraint(equalTo: takeProfitThreeContainer.bottomAnchor, constant: 0).isActive = true
        setupTextField(txtField: stopLossTextField, pinView: stopLossContainer, theText: "")
        stopLossTextField.placeholder = "0.0"
        stopLossUSDLabel.isHidden = true
        
        //TRADE TYPE
        /*
        createContainer(containerView: tradeTypeContainer, sectionTitleLabel: tradetypeTitleLabel, isFirst: false)
        tradetypeTitleLabel.text = "Signal Type"
        tradetypeTitleLabel.isUserInteractionEnabled = false
        tradeTypeContainer.topAnchor.constraint(equalTo: stopLossContainer.bottomAnchor, constant: 0).isActive = true
        setupTextField(txtField: tradeTypeTextField, pinView: tradeTypeContainer, theText: signalTypeSelected)
        //tradeTypeTextField.placeholder = "Pick Type"//"Coming Soon"
        tradeTypeTextField.isUserInteractionEnabled = false
        
        signalTypeButton.isHidden = true
        signalTypeButton.addTarget(self, action: #selector(didTapSignalOptions), for: .touchUpInside)
        signalTypeButton.translatesAutoresizingMaskIntoConstraints = false
        tradeTypeContainer.addSubview(signalTypeButton)
        signalTypeButton.fillSuperview()
        */
        
        //DEMO SIGNAL
                
        /*
        createDemoContainer(containerView: demoSignalContainer, sectionTitleLabel: demoSignalTitleLabel)
        demoSignalTitleLabel.text = "Send Demo Signal"
        demoSignalContainer.topAnchor.constraint(equalTo: tradeTypeContainer.bottomAnchor, constant: 0).isActive = true
        
        demoSignalCheckBoxImageView.image = UIImage(named: "emptyCheckBoxBlack")
        demoSignalCheckBoxImageView.contentMode = .scaleAspectFill
        demoSignalCheckBoxImageView.translatesAutoresizingMaskIntoConstraints = false
        demoSignalContainer.addSubview(demoSignalCheckBoxImageView)
        demoSignalCheckBoxImageView.trailingAnchor.constraint(equalTo: demoSignalContainer.trailingAnchor, constant: 0).isActive = true
        demoSignalCheckBoxImageView.centerYAnchor.constraint(equalTo: demoSignalContainer.centerYAnchor, constant: 0).isActive = true
        demoSignalCheckBoxImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        demoSignalCheckBoxImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
                                
        demoSignalButton.addTarget(self, action: #selector(demoSignalTapped), for: .touchUpInside)
        demoSignalButton.translatesAutoresizingMaskIntoConstraints = false
        demoSignalContainer.addSubview(demoSignalButton)
        demoSignalButton.trailingAnchor.constraint(equalTo: demoSignalContainer.trailingAnchor).isActive = true
        demoSignalButton.topAnchor.constraint(equalTo: demoSignalContainer.topAnchor).isActive = true
        demoSignalButton.bottomAnchor.constraint(equalTo: demoSignalContainer.bottomAnchor).isActive = true
        demoSignalButton.leadingAnchor.constraint(equalTo: demoSignalContainer.centerXAnchor).isActive = true
        */
        
        bulletZero.backgroundColor = variableColor.withAlphaComponent(0.75)
        bulletZero.layer.cornerRadius = .createAspectRatio(value: 4)/2
        bulletZero.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(bulletZero)
        bulletZero.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        bulletZero.topAnchor.constraint(equalTo: stopLossContainer.bottomAnchor, constant: .createAspectRatio(value: 34)).isActive = true
        bulletZero.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        bulletZero.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        
        let legalLabelZeroText = disclaimerZero//"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        legalLabelZero.setupLineHeight(myText: legalLabelZeroText, myLineSpacing: .createAspectRatio(value: 6))
        legalLabelZero.textColor = variableColor.withAlphaComponent(0.75)
        legalLabelZero.numberOfLines = 0
        legalLabelZero.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 12))
        legalLabelZero.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(legalLabelZero)
        legalLabelZero.leadingAnchor.constraint(equalTo: bulletZero.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        legalLabelZero.topAnchor.constraint(equalTo: bulletZero.topAnchor, constant: -.createAspectRatio(value: 4)).isActive = true
        legalLabelZero.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -view.frame.width * 0.1).isActive = true
        
        bulletOne.backgroundColor = variableColor.withAlphaComponent(0.75)
        bulletOne.layer.cornerRadius = .createAspectRatio(value: 4)/2
        bulletOne.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(bulletOne)
        bulletOne.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        bulletOne.topAnchor.constraint(equalTo: legalLabelZero.bottomAnchor, constant: .createAspectRatio(value: 25)).isActive = true
        bulletOne.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        bulletOne.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        
        let legalLabelOneText = disclaimerOne//"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        legalLabelOne.setupLineHeight(myText: legalLabelOneText, myLineSpacing: .createAspectRatio(value: 6))
        legalLabelOne.textColor = variableColor.withAlphaComponent(0.75)
        legalLabelOne.numberOfLines = 0
        legalLabelOne.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 12))
        legalLabelOne.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(legalLabelOne)
        legalLabelOne.leadingAnchor.constraint(equalTo: bulletOne.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        legalLabelOne.topAnchor.constraint(equalTo: bulletOne.topAnchor, constant: -.createAspectRatio(value: 4)).isActive = true
        legalLabelOne.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -view.frame.width * 0.1).isActive = true
        
        gradientImageView.image = UIImage(named: "whiteGradientE")
        if isDarkMode.bool(forKey: "isDarkMode") {
            gradientImageView.setImageColor(color: .darkModeBackground)
        }
        gradientImageView.contentMode = .scaleAspectFill
        gradientImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gradientImageView)
        gradientImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        gradientImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        gradientImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        gradientImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 289)).isActive = true
        
        //
        
        swipeView.delegate = self
        swipeView.swipeLabel.text = "Post Trade"
        swipeView.backgroundColor = .clear
        swipeView.layer.cornerRadius = .createAspectRatio(value: 56)/2
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(swipeView)
        swipeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        swipeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.createAspectRatio(value: 32)).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -.createAspectRatio(value: swipeViewBottom)).isActive = true
        swipeView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        //
        
        let checkAnimation = LottieAnimation.named("gradientCheck")
        checkmarkOneLottie.isUserInteractionEnabled = false
        checkmarkOneLottie.alpha = 0
        checkmarkOneLottie.animation = checkAnimation
        checkmarkOneLottie.contentMode = .scaleAspectFill
        checkmarkOneLottie.loopMode = .playOnce
        checkmarkOneLottie.animationSpeed = 0.75
        //checkmarkOneLottie.backgroundColor = .red
        checkmarkOneLottie.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(checkmarkOneLottie)
        checkmarkOneLottie.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        checkmarkOneLottie.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        checkmarkOneLottie.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 100)).isActive = true
        checkmarkOneLottie.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 100)).isActive = true
        //checkmarkOneLottie.play()
        
        orderPlaced.alpha = 0
        orderPlaced.text = "Signal Posted!"
        orderPlaced.textColor = variableColor
        orderPlaced.textAlignment = .center
        orderPlaced.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 25))
        orderPlaced.numberOfLines = 0
        orderPlaced.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(orderPlaced)
        orderPlaced.topAnchor.constraint(equalTo: checkmarkOneLottie.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        orderPlaced.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        checkBackOfficeLabel.alpha = 0
        let checkBackOfficeLabelText = "A notification will\nbe sent out to all users!"
        checkBackOfficeLabel.setupLineHeight(myText: checkBackOfficeLabelText, myLineSpacing: 4)
        checkBackOfficeLabel.textColor = variableColor.withAlphaComponent(0.75)
        checkBackOfficeLabel.textAlignment = .center
        checkBackOfficeLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 12))
        checkBackOfficeLabel.numberOfLines = 0
        checkBackOfficeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(checkBackOfficeLabel)
        checkBackOfficeLabel.topAnchor.constraint(equalTo: orderPlaced.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        checkBackOfficeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    func createContainer(containerView: UIView, sectionTitleLabel: UILabel, isFirst: Bool) {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 87)).isActive = true
        
        let dividerLine = UIView()
        dividerLine.backgroundColor = variableColor.withAlphaComponent(0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 1)).isActive = true
                
        sectionTitleLabel.textColor = variableColor.withAlphaComponent(0.5)
        sectionTitleLabel.textAlignment = .left
        sectionTitleLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 16))
        sectionTitleLabel.numberOfLines = 0
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sectionTitleLabel)
        sectionTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
//        if isFirst {
//            sectionTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .createAspectRatio(value: 24)).isActive = true
//        } else {
//            sectionTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
//        }
        
        sectionTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupDetailLabel(detailLabel: UILabel, viewToPin: UIView) {
        detailLabel.textColor = variableColor
        detailLabel.textAlignment = .right
        detailLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        detailLabel.numberOfLines = 0
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.addSubview(detailLabel)
        detailLabel.trailingAnchor.constraint(equalTo: viewToPin.trailingAnchor, constant: 0).isActive = true
        //detailLabel.topAnchor.constraint(equalTo: viewToPin.topAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        detailLabel.centerYAnchor.constraint(equalTo: viewToPin.centerYAnchor, constant: 0).isActive = true
                
    }
    
    func setupDetailLabelZero(detailLabel: UILabel, viewToPin: UIView, usdLabel: UILabel) {
        detailLabel.textColor = variableColor
        detailLabel.textAlignment = .right
        detailLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        detailLabel.numberOfLines = 0
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.addSubview(detailLabel)
        detailLabel.trailingAnchor.constraint(equalTo: viewToPin.trailingAnchor, constant: 0).isActive = true
        detailLabel.topAnchor.constraint(equalTo: viewToPin.topAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        
        usdLabel.textColor = variableColor.withAlphaComponent(0.3)
        usdLabel.textAlignment = .right
        usdLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 13))
        usdLabel.numberOfLines = 0
        usdLabel.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.addSubview(usdLabel)
        usdLabel.trailingAnchor.constraint(equalTo: viewToPin.trailingAnchor, constant: 0).isActive = true
        usdLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
    }
    
    func setupTextField(txtField: UITextField, pinView: UIView, theText: String) {
        txtField.text = theText//forexSignal?.takeProfit1
        txtField.delegate = self
        txtField.keyboardType = .decimalPad
        txtField.tintColor = UIColor(red: 225/255, green: 67/255, blue: 206/255, alpha: 1.0)
        txtField.textAlignment = .right
        txtField.textColor = variableColor
        txtField.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        txtField.translatesAutoresizingMaskIntoConstraints = false
        pinView.addSubview(txtField)
        txtField.trailingAnchor.constraint(equalTo: pinView.trailingAnchor, constant: 0).isActive = true
        txtField.centerYAnchor.constraint(equalTo: pinView.centerYAnchor, constant: 0).isActive = true
        txtField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 40)).isActive = true
        txtField.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 120)).isActive = true
    }
    
    func setupLiveLabel(liveLabel: UILabel, pinView: UIView, theText: String) {
        liveLabel.text = theText//forexSignal?.takeProfit1
        liveLabel.tintColor = UIColor(red: 225/255, green: 67/255, blue: 206/255, alpha: 1.0)
        liveLabel.textAlignment = .right
        liveLabel.textColor = variableColor
        liveLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        liveLabel.translatesAutoresizingMaskIntoConstraints = false
        pinView.addSubview(liveLabel)
        liveLabel.trailingAnchor.constraint(equalTo: pinView.trailingAnchor, constant: 0).isActive = true
        liveLabel.centerYAnchor.constraint(equalTo: pinView.centerYAnchor, constant: 0).isActive = true
    }
    
    func convertToUSD(myString: String) -> String {
        let valueZero = Float("\(myString)")
        let multiplier = (valueZero ?? 0) * 10.0
        return "$\(multiplier)"
        //self.lotSizeUSDLabel.text = "$\(multiplier)"
    }
    
    func setupLoadingView() {
        opacityLayer.alpha = 0
        opacityLayer.isHidden = true
        opacityLayer.backgroundColor = .black.withAlphaComponent(0.75)
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        opacityLayer.addSubview(loadingIndicator)
        loadingIndicator.centerYAnchor.constraint(equalTo: opacityLayer.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: opacityLayer.centerXAnchor).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        loadingIndicator.startAnimating()
        
        let loadingLabel = UILabel()
        loadingLabel.text = "Placing order..."
        loadingLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 14))
        loadingLabel.textColor = .white
        loadingLabel.numberOfLines = 0
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        opacityLayer.addSubview(loadingLabel)
        loadingLabel.centerXAnchor.constraint(equalTo: opacityLayer.centerXAnchor).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
    }
    
    func createDemoContainer(containerView: UIView, sectionTitleLabel: UILabel) {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 87)).isActive = true
        
        let dividerLine = UIView()
        dividerLine.backgroundColor = .black.withAlphaComponent(0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 1)).isActive = true
                
        sectionTitleLabel.textColor = .black.withAlphaComponent(0.5)
        sectionTitleLabel.textAlignment = .left
        sectionTitleLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 16))
        sectionTitleLabel.numberOfLines = 0
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sectionTitleLabel)
        sectionTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        sectionTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
    }
}
