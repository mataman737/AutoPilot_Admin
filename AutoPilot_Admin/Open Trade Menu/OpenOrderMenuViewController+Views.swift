//
//  OpenOrderMenuViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/6/23.
//

import Foundation
import UIKit
import Lottie

extension OpenOrderMenuViewController {
    
    func setupColors() {
        if isDarkMode.bool(forKey: "isDarkMode") {
            varBlackColor = .white
            variableWhiteColor = .darkModeBackground
        } else {
            varBlackColor = .newBlack
            variableWhiteColor = .white
        }
    }
    
    func setupViews() {
            
        mainContainer.backgroundColor = variableWhiteColor
        keyLine.backgroundColor = variableWhiteColor
        textColor = varBlackColor
        shareOption.optionDetailLabel.textColor = varBlackColor.withAlphaComponent(0.6)
        newGroupOption.optionDetailLabel.textColor = varBlackColor.withAlphaComponent(0.6)
        newChannelOption.optionDetailLabel.textColor = varBlackColor.withAlphaComponent(0.6)
        sendContentOption.optionDetailLabel.textColor = varBlackColor.withAlphaComponent(0.6)
        
        shareOption.optionTitleLabel.textColor = varBlackColor
        newChannelOption.optionTitleLabel.textColor = varBlackColor
        sendContentOption.optionTitleLabel.textColor = varBlackColor
                
        opacityLayer.backgroundColor = .black
        opacityLayer.alpha = 0
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
        
        mainScrollView.tag = 1
        mainScrollView.delegate = self
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.backgroundColor = .clear
        mainScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.1)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainScrollView)
        mainScrollView.fillSuperview()
        
        let opacityTapped = UITapGestureRecognizer(target: self, action: #selector(dimissVC))
        wrapper.addGestureRecognizer(opacityTapped)
        wrapper.isUserInteractionEnabled = true
        wrapper.backgroundColor = .clear
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(wrapper)
        wrapper.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        wrapper.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 0).isActive = true
        wrapper.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        wrapper.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
        
        mainContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainContainer.layer.cornerRadius = .createAspectRatio(value: 15)
        mainContainer.layer.masksToBounds = true
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(mainContainer)
        mainContainer.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: 0).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 0).isActive = true
        mainContainer.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 520)).isActive = true //366 //285
        mainContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        keyLine.layer.cornerRadius = .createAspectRatio(value: 4)/2
        keyLine.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(keyLine)
        keyLine.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        keyLine.bottomAnchor.constraint(equalTo: mainContainer.topAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        keyLine.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 34)).isActive = true
        keyLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        keyLine.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        tradeDetailsContainer.backgroundColor = variableWhiteColor
        tradeDetailsContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(tradeDetailsContainer)
        tradeDetailsContainer.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        tradeDetailsContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        tradeDetailsContainer.topAnchor.constraint(equalTo: mainContainer.topAnchor).isActive = true
        tradeDetailsContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 192)).isActive = true
        
        detailDivider.backgroundColor = varBlackColor.withAlphaComponent(0.1)
        detailDivider.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(detailDivider)
        detailDivider.bottomAnchor.constraint(equalTo: tradeDetailsContainer.bottomAnchor).isActive = true
        detailDivider.centerXAnchor.constraint(equalTo: tradeDetailsContainer.centerXAnchor).isActive = true
        detailDivider.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 1)).isActive = true
        detailDivider.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 75)).isActive = true
        
        //
        
        entryPriceTitleLabel.text = "Entry Price"
        entryPriceTitleLabel.textColor = varBlackColor.withAlphaComponent(0.5)
        entryPriceTitleLabel.textAlignment = .left
        entryPriceTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 9))
        entryPriceTitleLabel.numberOfLines = 0
        entryPriceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(entryPriceTitleLabel)
        entryPriceTitleLabel.leadingAnchor.constraint(equalTo: tradeDetailsContainer.leadingAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        entryPriceTitleLabel.topAnchor.constraint(equalTo: tradeDetailsContainer.topAnchor, constant: .createAspectRatio(value: 59)).isActive = true
        
        if let entryPrice = forexSignal.order?.openPrice {
            entryPriceLabel.text = String(entryPrice)
        } else {
            entryPriceLabel.text = "nil"
        }
        
//        entryPriceLabel.text = "1.12345"
        entryPriceLabel.textColor = varBlackColor.withAlphaComponent(0.75)
        entryPriceLabel.textAlignment = .left
        entryPriceLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 16))
        entryPriceLabel.numberOfLines = 0
        entryPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(entryPriceLabel)
        entryPriceLabel.leadingAnchor.constraint(equalTo: entryPriceTitleLabel.leadingAnchor, constant: 0).isActive = true
        entryPriceLabel.topAnchor.constraint(equalTo: entryPriceTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 8)).isActive = true
                
        arrowImageView.image = UIImage(named: "sigArrow")
        arrowImageView.setImageColor(color: varBlackColor)
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(arrowImageView)
        arrowImageView.leadingAnchor.constraint(equalTo: entryPriceLabel.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor, constant: 0).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 10)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 18)).isActive = true
        
//        currentPriceLabel.text = "1.12345"
        currentPriceLabel.textColor = varBlackColor.withAlphaComponent(0.75)
        currentPriceLabel.textAlignment = .left
        currentPriceLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 16))
        currentPriceLabel.numberOfLines = 0
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(currentPriceLabel)
        currentPriceLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        currentPriceLabel.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor).isActive = true
        
        currentPriceTitleLabel.text = "Current Price"
        currentPriceTitleLabel.textColor = varBlackColor.withAlphaComponent(0.5)
        currentPriceTitleLabel.textAlignment = .left
        currentPriceTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 9))
        currentPriceTitleLabel.numberOfLines = 0
        currentPriceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(currentPriceTitleLabel)
        currentPriceTitleLabel.leadingAnchor.constraint(equalTo: currentPriceLabel.leadingAnchor, constant: 0).isActive = true
        currentPriceTitleLabel.centerYAnchor.constraint(equalTo: entryPriceTitleLabel.centerYAnchor, constant: 0).isActive = true
        
        //unrealizedProfitLabel.textColor = .green//UIColor(red: 191/255, green: 106/255, blue: 106/255, alpha: 1.0)
        unrealizedProfitLabel.textAlignment = .right
        unrealizedProfitLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 16))
        unrealizedProfitLabel.numberOfLines = 0
        unrealizedProfitLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(unrealizedProfitLabel)
        unrealizedProfitLabel.trailingAnchor.constraint(equalTo: tradeDetailsContainer.trailingAnchor, constant: -.createAspectRatio(value: 32)).isActive = true
        unrealizedProfitLabel.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor).isActive = true
                
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(loadingIndicator)
        loadingIndicator.centerYAnchor.constraint(equalTo: unrealizedProfitLabel.centerYAnchor).isActive = true
        loadingIndicator.trailingAnchor.constraint(equalTo: unrealizedProfitLabel.trailingAnchor).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        loadingIndicator.startAnimating()
        
        unrealizedProfitTitleLabel.text = "Unrealized Profit"
        unrealizedProfitTitleLabel.textColor = varBlackColor.withAlphaComponent(0.5)
        unrealizedProfitTitleLabel.textAlignment = .right
        unrealizedProfitTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 9))
        unrealizedProfitTitleLabel.numberOfLines = 0
        unrealizedProfitTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(unrealizedProfitTitleLabel)
        unrealizedProfitTitleLabel.trailingAnchor.constraint(equalTo: unrealizedProfitLabel.trailingAnchor, constant: 0).isActive = true
        unrealizedProfitTitleLabel.centerYAnchor.constraint(equalTo: entryPriceTitleLabel.centerYAnchor, constant: 0).isActive = true
        
        stopLossTitleLabel.text = "Stop Loss"
        stopLossTitleLabel.textColor = varBlackColor.withAlphaComponent(0.5)
        stopLossTitleLabel.textAlignment = .left
        stopLossTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 9))
        stopLossTitleLabel.numberOfLines = 0
        stopLossTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(stopLossTitleLabel)
        stopLossTitleLabel.leadingAnchor.constraint(equalTo: entryPriceTitleLabel.leadingAnchor, constant: 0).isActive = true
        stopLossTitleLabel.topAnchor.constraint(equalTo: entryPriceLabel.bottomAnchor, constant: .createAspectRatio(value: 40)).isActive = true
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            //print(self?.forexSignal.order?.ticket)
            if let order = MyTabBarController.orderProfitUpdate?.data.orders.first(where: {$0.ticket == self?.forexSignal.order?.ticket}), let stopLoss = order.stopLoss {
                print("stop loss: \(stopLoss)")
                self?.stopLossLabel.text = "\(stopLoss)"
                
                if let symbol = order.symbol, let livePrice = MyTabBarController.orderProfitUpdate?.livePrices.priceForSymbol(symbol: symbol.removePeriodsAndDashes()) {
                    if let liveDecCount = self?.countDecimalPlaces(livePrice), let roundToFive = self?.roundToFiveDecimalPlaces(livePrice) {
                        if liveDecCount > 5 {
                            self?.currentPriceLabel.text = "\(roundToFive)"
                        } else {
                            self?.currentPriceLabel.text = String(livePrice)
                        }
                    }
                    //self?.currentPriceLabel.text = String(livePrice)
                }
            } else {
                if let stopLossTwo = self?.forexSignal.order?.stopLoss {
                    self?.stopLossLabel.text = "\(stopLossTwo)"
                } else {
                    self?.stopLossLabel.text = "nil"
                }
            }
        }
        
//        stopLossLabel.text = "1.12345"
        stopLossLabel.textColor = varBlackColor.withAlphaComponent(0.75)
        stopLossLabel.textAlignment = .left
        stopLossLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 16))
        stopLossLabel.numberOfLines = 0
        stopLossLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(stopLossLabel)
        stopLossLabel.leadingAnchor.constraint(equalTo: stopLossTitleLabel.leadingAnchor, constant: 0).isActive = true
        stopLossLabel.topAnchor.constraint(equalTo: stopLossTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        
        takeProfitTitleLabel.text = "Take Profit"
        takeProfitTitleLabel.textColor = varBlackColor.withAlphaComponent(0.5)
        takeProfitTitleLabel.textAlignment = .right
        takeProfitTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 9))
        takeProfitTitleLabel.numberOfLines = 0
        takeProfitTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(takeProfitTitleLabel)
        takeProfitTitleLabel.trailingAnchor.constraint(equalTo: unrealizedProfitTitleLabel.trailingAnchor, constant: 0).isActive = true
        takeProfitTitleLabel.centerYAnchor.constraint(equalTo: stopLossTitleLabel.centerYAnchor, constant: 0).isActive = true
        
        if let takeProfit = forexSignal.order?.takeProfit {
            takeProfitLabel.text = String(takeProfit)
        } else {
            takeProfitLabel.text = "nil"
        }
        
//        takeProfitLabel.text = "1.12345"
        takeProfitLabel.textColor = varBlackColor.withAlphaComponent(0.75)
        takeProfitLabel.textAlignment = .right
        takeProfitLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 16))
        takeProfitLabel.numberOfLines = 0
        takeProfitLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(takeProfitLabel)
        takeProfitLabel.trailingAnchor.constraint(equalTo: takeProfitTitleLabel.trailingAnchor, constant: 0).isActive = true
        takeProfitLabel.centerYAnchor.constraint(equalTo: stopLossLabel.centerYAnchor, constant: 0).isActive = true
        
        //
                
        navTitleLabel.textAlignment = .center
        navTitleLabel.textColor = varBlackColor
        navTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 19))
        navTitleLabel.numberOfLines = 0
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(navTitleLabel)
        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
                        
        newChannelOption.iconImageView.image = UIImage(named: "modifyImgNVU")
        newChannelOption.optionTitleLabel.text = "Modify Trade"
        newChannelOption.optionButton.addTarget(self, action: #selector(newFollowupReminderTapped), for: .touchUpInside)
        newChannelOption.optionDetailLabel.text = "Modify Take Profit and Stop Loss"
        newChannelOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(newChannelOption)
        newChannelOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 0).isActive = true
        newChannelOption.topAnchor.constraint(equalTo: tradeDetailsContainer.bottomAnchor, constant: .createAspectRatio(value: 25)).isActive = true
        newChannelOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: 0).isActive = true
        newChannelOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
        
        if isCrypto {
            createLock(lockIV: entryPriceLock)
            entryPriceLock.leadingAnchor.constraint(equalTo: newChannelOption.optionTitleLabel.trailingAnchor, constant: .createAspectRatio(value: 5)).isActive = true
            entryPriceLock.centerYAnchor.constraint(equalTo: newChannelOption.optionTitleLabel.centerYAnchor, constant: -.createAspectRatio(value: 2)).isActive = true
        }
                        
        sendContentOption.optionButton.addTarget(self, action: #selector(didTapMarketingCenter), for: .touchUpInside)
        sendContentOption.iconImageView.image = UIImage(named: "closeOrderImgNVU")
        sendContentOption.optionTitleLabel.text = "Close Trade"
        sendContentOption.optionDetailLabel.text = "Close an order immediately"
        sendContentOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(sendContentOption)
        sendContentOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 0).isActive = true
        sendContentOption.topAnchor.constraint(equalTo: newChannelOption.bottomAnchor, constant: 0).isActive = true
        sendContentOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: 0).isActive = true
        sendContentOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
        
        shareOption.optionButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        shareOption.iconImageView.image = UIImage(named: "thickBellNVU")//UIImage(named: "thickBell")
        shareOption.optionTitleLabel.text = "Receive Updates"
        shareOption.optionDetailLabel.text = "Be notified when there is an update"
        shareOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(shareOption)
        shareOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 0).isActive = true
        shareOption.topAnchor.constraint(equalTo: sendContentOption.bottomAnchor, constant: 0).isActive = true
        shareOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: 0).isActive = true
        shareOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
        
    }
    
    func createLock(lockIV: UIImageView) {
        lockIV.image = UIImage(named: "signalLock")
        lockIV.contentMode = .scaleAspectFill
        lockIV.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(lockIV)
        lockIV.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        lockIV.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
    }
    
    func roundToFiveDecimalPlaces(_ number: Double) -> Double {
        let decimalNumber = Decimal(number)
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        formatter.roundingMode = .halfUp

        if let roundedNumber = formatter.string(from: decimalNumber as NSDecimalNumber),
           let result = Double(roundedNumber) {
            return result
        } else {
            return number
        }
    }
    
    func countDecimalPlaces(_ number: Double) -> Int {
        let numberString = String(number)
        if let decimalIndex = numberString.firstIndex(of: ".") {
            let decimalPlacesCount = numberString.distance(from: decimalIndex, to: numberString.endIndex) - 1
            return max(0, decimalPlacesCount) // Ensure non-negative count
        }
        return 0 // No decimal point found
    }
    
}
