//
//  ModifyPendingOrderViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/4/23.
//

import Foundation
import UIKit
import Lottie

extension ModifyPendingOrderViewController {
    
    func setupColors() {
        if isDarkMode.bool(forKey: "isDarkMode") {
            self.view.backgroundColor = .darkModeBackground
            varBlackColor = .white
            variableWhiteColor = .darkModeBackground
        } else {
            self.view.backgroundColor = .white
            varBlackColor = .newBlack
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
        contentContainer.heightAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
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
        
        downArrowImageView.isHidden = true
        downArrowImageView.image = UIImage(named: "downGradientNVU")
        downArrowImageView.contentMode = .scaleAspectFill
        downArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(downArrowImageView)
        downArrowImageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        downArrowImageView.centerYAnchor.constraint(equalTo: dismissImageView.centerYAnchor, constant: 0).isActive = true
        downArrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        downArrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 17)).isActive = true
        
        if let orderT = forexSignal.order?.type {
            if let volume = forexSignal.order?.ex?.volume {
                if orderT.contains("SELL") {
                    orderTypeLabel.text = "Sell \(volume)"
                    orderTypeLabel.textColor = UIColor(red: 191/255, green: 103/255, blue: 103/255, alpha: 1.0)
                } else {
                    orderTypeLabel.text = "Buy \(volume)"
                    orderTypeLabel.textColor = UIColor(red: 103/255, green: 191/255, blue: 151/255, alpha: 1.0)
                }
            }
        }
        
        orderTypeLabel.textColor = varBlackColor
        orderTypeLabel.textAlignment = .right
        orderTypeLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 12))
        orderTypeLabel.numberOfLines = 0
        orderTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(orderTypeLabel)
        orderTypeLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        orderTypeLabel.centerYAnchor.constraint(equalTo: downArrowImageView.centerYAnchor).isActive = true
        
        //assetTitleLabel.text = forexSignal.order?.symbol
        assetTitleLabel.textColor = varBlackColor
        assetTitleLabel.textAlignment = .left
        assetTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 20))
        assetTitleLabel.numberOfLines = 0
        assetTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(assetTitleLabel)
        assetTitleLabel.leadingAnchor.constraint(equalTo: dismissImageView.leadingAnchor, constant: 0).isActive = true
        assetTitleLabel.topAnchor.constraint(equalTo: dismissImageView.bottomAnchor, constant: .createAspectRatio(value: 34)).isActive = true
                
        //ENTRY PRICE
        
        entryPriceContainer.isHidden = false
        createContainer(containerView: entryPriceContainer, sectionTitleLabel: entryPriceTitleLabel, isFirst: true)
        entryPriceTitleLabel.text = "Entry Price"
        entryPriceContainer.topAnchor.constraint(equalTo: assetTitleLabel.bottomAnchor, constant: 26).isActive = true
        
        setupDetailLabel(detailLabel: entryPriceDetailLabel, viewToPin: entryPriceContainer, usdLabel: entryPriceUSDLabel)
        entryPriceUSDLabel.isHidden = true
        
        entryPriceTextField.placeholder = "0.0"
        
        if let entryPrice = forexSignal.order?.openPrice { //forexSignal.instantTrade?.entryPrice
            //entryPriceTextField.text = String(entryPrice)
            //print("\(forexSignal.order?.openPrice) 🧟‍♂️🧟‍♂️🧟‍♂️ \(String(entryPrice))")
            setupTextField(txtField: entryPriceTextField, pinView: entryPriceContainer, theText: String(entryPrice))
        } else {
            setupTextField(txtField: entryPriceTextField, pinView: entryPriceContainer, theText: "0.0")
        }
        
        //TAKE PROFIT
        
        createContainer(containerView: takeProfitContainer, sectionTitleLabel: takeProfitTitleLabel, isFirst: false)
        takeProfitTitleLabel.text = "Take Profit"
        takeProfitContainer.topAnchor.constraint(equalTo: entryPriceContainer.bottomAnchor, constant: 0).isActive = true
        takeProfitTextField.placeholder = "0.0"
        
        
        if let takeProfit = forexSignal.order?.takeProfit {
            setupTextField(txtField: takeProfitTextField, pinView: takeProfitContainer, theText: String(takeProfit))
        } else {
            setupTextField(txtField: takeProfitTextField, pinView: takeProfitContainer, theText: "0.0")
        }
        
        takeProfitUSDLabel.isHidden = true
        
        takeProfitArrowImageView.image = UIImage(named: "downGradient")
        takeProfitArrowImageView.contentMode = .scaleAspectFill
        takeProfitArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        takeProfitContainer.addSubview(takeProfitArrowImageView)
        takeProfitArrowImageView.leadingAnchor.constraint(equalTo: takeProfitTitleLabel.trailingAnchor, constant: .createAspectRatio(value: 1)).isActive = true
        takeProfitArrowImageView.centerYAnchor.constraint(equalTo: takeProfitTitleLabel.centerYAnchor, constant: 0).isActive = true
        takeProfitArrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        takeProfitArrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 17)).isActive = true
        
        takeProfitButton.addTarget(self, action: #selector(didTapTakeProfit), for: .touchUpInside)
        takeProfitButton.translatesAutoresizingMaskIntoConstraints = false
        takeProfitContainer.addSubview(takeProfitButton)
        takeProfitButton.leadingAnchor.constraint(equalTo: takeProfitContainer.leadingAnchor).isActive = true
        takeProfitButton.topAnchor.constraint(equalTo: takeProfitContainer.topAnchor).isActive = true
        takeProfitButton.bottomAnchor.constraint(equalTo: takeProfitContainer.bottomAnchor).isActive = true
        takeProfitButton.trailingAnchor.constraint(equalTo: takeProfitContainer.centerXAnchor).isActive = true
        
        //STOP LOSS
        
        createContainer(containerView: stopLossContainer, sectionTitleLabel: stopLossTitleLabel, isFirst: false)
        stopLossTitleLabel.text = "Stop Loss"
        stopLossContainer.topAnchor.constraint(equalTo: takeProfitContainer.bottomAnchor, constant: 0).isActive = true

        if let stopLossString = forexSignal?.order?.stopLoss {
            setupTextField(txtField: stopLossTextField, pinView: stopLossContainer, theText: String(stopLossString))
        } else {
            if let stopLossStringTwo = forexSignal?.instantTrade?.stopLoss {
                setupTextField(txtField: stopLossTextField, pinView: stopLossContainer, theText: stopLossStringTwo)
            } else {
                setupTextField(txtField: stopLossTextField, pinView: stopLossContainer, theText: "0.0")
            }
        }
        
        if let stopString = forexSignal.order?.stopLoss {
            setupTextField(txtField: stopLossTextField, pinView: stopLossContainer, theText: String(stopString))
        } else {
            setupTextField(txtField: stopLossTextField, pinView: stopLossContainer, theText: "0.0")
        }
        //print("\(forexSignal) 🧠🧠🧠")
        
        stopLossTextField.placeholder = "0.0"
        stopLossUSDLabel.isHidden = true
        
        //
        
        let accessoryContainer = UIView()
        accessoryContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 66)
        accessoryContainer.backgroundColor = .clear
        
        entryPriceTextField.inputAccessoryView = accessoryContainer
        takeProfitTextField.inputAccessoryView = accessoryContainer
        stopLossTextField.inputAccessoryView = accessoryContainer
        
        //continueButton.delegate = self
        continueButton.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 4, height: 4), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        continueButton.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)
        continueButton.continueLabel.text = "Confirm"
        continueButton.continueLabel.textColor = .white
        continueButton.confirmLabel.textColor = .white
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        accessoryContainer.addSubview(continueButton)
        continueButton.leadingAnchor.constraint(equalTo: accessoryContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: accessoryContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        continueButton.topAnchor.constraint(equalTo: accessoryContainer.topAnchor, constant: 0).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        //
        
        bulletZero.backgroundColor = varBlackColor.withAlphaComponent(0.75)
        bulletZero.layer.cornerRadius = .createAspectRatio(value: 4)/2
        bulletZero.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(bulletZero)
        bulletZero.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        bulletZero.topAnchor.constraint(equalTo: stopLossContainer.bottomAnchor, constant: .createAspectRatio(value: 34)).isActive = true
        bulletZero.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        bulletZero.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        
        let legalLabelZeroText = disclaimerZero//"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        legalLabelZero.setupLineHeight(myText: legalLabelZeroText, myLineSpacing: .createAspectRatio(value: 6))
        legalLabelZero.textColor = varBlackColor.withAlphaComponent(0.75)
        legalLabelZero.numberOfLines = 0
        legalLabelZero.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 12))
        legalLabelZero.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(legalLabelZero)
        legalLabelZero.leadingAnchor.constraint(equalTo: bulletZero.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        legalLabelZero.topAnchor.constraint(equalTo: bulletZero.topAnchor, constant: -.createAspectRatio(value: 4)).isActive = true
        legalLabelZero.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -view.frame.width * 0.1).isActive = true
        
        bulletOne.backgroundColor = varBlackColor.withAlphaComponent(0.75)
        bulletOne.layer.cornerRadius = .createAspectRatio(value: 4)/2
        bulletOne.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(bulletOne)
        bulletOne.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        bulletOne.topAnchor.constraint(equalTo: legalLabelZero.bottomAnchor, constant: .createAspectRatio(value: 25)).isActive = true
        bulletOne.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        bulletOne.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        
        let legalLabelOneText = disclaimerOne//"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        legalLabelOne.setupLineHeight(myText: legalLabelOneText, myLineSpacing: .createAspectRatio(value: 6))
        legalLabelOne.textColor = varBlackColor.withAlphaComponent(0.75)
        legalLabelOne.numberOfLines = 0
        legalLabelOne.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 12))
        legalLabelOne.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(legalLabelOne)
        legalLabelOne.leadingAnchor.constraint(equalTo: bulletOne.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        legalLabelOne.topAnchor.constraint(equalTo: bulletOne.topAnchor, constant: -.createAspectRatio(value: 4)).isActive = true
        legalLabelOne.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -view.frame.width * 0.1).isActive = true
        
        gradientImageView.image = UIImage(named: "whiteGradientE")
        gradientImageView.setImageColor(color: variableWhiteColor)
        gradientImageView.contentMode = .scaleAspectFill
        gradientImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gradientImageView)
        gradientImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        gradientImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        gradientImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        gradientImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 289)).isActive = true
        
        //
        
        swipeView.delegate = self
        swipeView.swipeLabel.text = "Modify Pending Order"
        //swipeView.alpha = 0
        swipeView.backgroundColor = .clear
        swipeView.layer.cornerRadius = .createAspectRatio(value: 56)/2
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(swipeView)
        swipeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        swipeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.createAspectRatio(value: 32)).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -.createAspectRatio(value: swipeViewBottom)).isActive = true
        swipeView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        //
        
        let checkAnimation = LottieAnimation.named(isNVUDemo.bool(forKey: "isNVUDemo") ? "gradientCheckNVU" : "gradientCheck")
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
        orderPlaced.text = "Order Placed!"
        orderPlaced.textColor = varBlackColor
        orderPlaced.textAlignment = .center
        orderPlaced.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 25))
        orderPlaced.numberOfLines = 0
        orderPlaced.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(orderPlaced)
        orderPlaced.topAnchor.constraint(equalTo: checkmarkOneLottie.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        orderPlaced.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        checkBackOfficeLabel.alpha = 0
        let checkBackOfficeLabelText = "Check your active\n orders to manage trade"
        checkBackOfficeLabel.setupLineHeight(myText: checkBackOfficeLabelText, myLineSpacing: 4)
        checkBackOfficeLabel.textColor = varBlackColor.withAlphaComponent(0.75)
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
        dividerLine.backgroundColor = varBlackColor.withAlphaComponent(0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 1)).isActive = true
                
        sectionTitleLabel.textColor = varBlackColor.withAlphaComponent(0.5)
        sectionTitleLabel.textAlignment = .left
        sectionTitleLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 16))
        sectionTitleLabel.numberOfLines = 0
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sectionTitleLabel)
        sectionTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        if isFirst {
            sectionTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        } else {
            sectionTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        }
    }
    
    func setupDetailLabel(detailLabel: UILabel, viewToPin: UIView, usdLabel: UILabel) {
        detailLabel.textColor = varBlackColor
        detailLabel.textAlignment = .right
        detailLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        detailLabel.numberOfLines = 0
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.addSubview(detailLabel)
        detailLabel.trailingAnchor.constraint(equalTo: viewToPin.trailingAnchor, constant: 0).isActive = true
        //detailLabel.topAnchor.constraint(equalTo: viewToPin.topAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        detailLabel.centerYAnchor.constraint(equalTo: viewToPin.centerYAnchor, constant: 0).isActive = true
        
        usdLabel.textColor = varBlackColor.withAlphaComponent(0.3)
        usdLabel.textAlignment = .right
        usdLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 13))
        usdLabel.numberOfLines = 0
        usdLabel.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.addSubview(usdLabel)
        usdLabel.trailingAnchor.constraint(equalTo: viewToPin.trailingAnchor, constant: 0).isActive = true
        usdLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
    }
    
    func setupDetailLabelZero(detailLabel: UILabel, viewToPin: UIView, usdLabel: UILabel) {
        detailLabel.textColor = varBlackColor
        detailLabel.textAlignment = .right
        detailLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        detailLabel.numberOfLines = 0
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.addSubview(detailLabel)
        detailLabel.trailingAnchor.constraint(equalTo: viewToPin.trailingAnchor, constant: 0).isActive = true
        detailLabel.topAnchor.constraint(equalTo: viewToPin.topAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        
        usdLabel.textColor = varBlackColor.withAlphaComponent(0.3)
        usdLabel.textAlignment = .right
        usdLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 13))
        usdLabel.numberOfLines = 0
        usdLabel.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.addSubview(usdLabel)
        usdLabel.trailingAnchor.constraint(equalTo: viewToPin.trailingAnchor, constant: 0).isActive = true
        usdLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
    }
    
    func convertToUSD(myString: String) -> String {
        let valueZero = Float("\(myString)")
        let multiplier = (valueZero ?? 0) * 10.0
        return "$\(multiplier)"
        //self.lotSizeUSDLabel.text = "$\(multiplier)"
    }
    
    func setupTextField(txtField: UITextField, pinView: UIView, theText: String) {
        txtField.text = theText//forexSignal?.takeProfit1
        txtField.delegate = self
        txtField.keyboardType = .decimalPad
        txtField.tintColor = UIColor(red: 225/255, green: 67/255, blue: 206/255, alpha: 1.0)
        txtField.textAlignment = .right
        txtField.textColor = varBlackColor
        txtField.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        txtField.translatesAutoresizingMaskIntoConstraints = false
        pinView.addSubview(txtField)
        txtField.trailingAnchor.constraint(equalTo: pinView.trailingAnchor, constant: 0).isActive = true
        txtField.centerYAnchor.constraint(equalTo: pinView.centerYAnchor, constant: 0).isActive = true
        txtField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        txtField.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 120)).isActive = true
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
}


