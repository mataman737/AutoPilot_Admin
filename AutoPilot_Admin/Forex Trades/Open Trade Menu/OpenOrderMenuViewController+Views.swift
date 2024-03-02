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
    
    func setupViews() {
            
        mainContainer.backgroundColor = .white
        keyLine.backgroundColor = .white
        modifyTradeOption.optionDetailLabel.textColor = .newBlack.withAlphaComponent(0.6)
        closeTradeOption.optionDetailLabel.textColor = .newBlack.withAlphaComponent(0.6)
        modifyTradeOption.optionTitleLabel.textColor = .newBlack
        closeTradeOption.optionTitleLabel.textColor = .newBlack
                
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
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 450)).isActive = true //520
        mainContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        keyLine.layer.cornerRadius = .createAspectRatio(value: 4)/2
        keyLine.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(keyLine)
        keyLine.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        keyLine.bottomAnchor.constraint(equalTo: mainContainer.topAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        keyLine.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 34)).isActive = true
        keyLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        keyLine.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        tradeDetailsContainer.backgroundColor = .white
        tradeDetailsContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(tradeDetailsContainer)
        tradeDetailsContainer.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        tradeDetailsContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        tradeDetailsContainer.topAnchor.constraint(equalTo: mainContainer.topAnchor).isActive = true
        tradeDetailsContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 192)).isActive = true
        
        detailDivider.backgroundColor = .newBlack.withAlphaComponent(0.1)
        detailDivider.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(detailDivider)
        detailDivider.bottomAnchor.constraint(equalTo: tradeDetailsContainer.bottomAnchor).isActive = true
        detailDivider.centerXAnchor.constraint(equalTo: tradeDetailsContainer.centerXAnchor).isActive = true
        detailDivider.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 1)).isActive = true
        detailDivider.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 75)).isActive = true
        
        //
        
        entryPriceTitleLabel.text = "Entry Price"
        entryPriceTitleLabel.textColor = .newBlack.withAlphaComponent(0.5)
        entryPriceTitleLabel.textAlignment = .left
        entryPriceTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 9))
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
        entryPriceLabel.textColor = .newBlack.withAlphaComponent(0.75)
        entryPriceLabel.textAlignment = .left
        entryPriceLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 16))
        entryPriceLabel.numberOfLines = 0
        entryPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(entryPriceLabel)
        entryPriceLabel.leadingAnchor.constraint(equalTo: entryPriceTitleLabel.leadingAnchor, constant: 0).isActive = true
        entryPriceLabel.topAnchor.constraint(equalTo: entryPriceTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 8)).isActive = true
                
        arrowImageView.image = UIImage(named: "sigArrow")
        arrowImageView.setImageColor(color: .newBlack)
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(arrowImageView)
        arrowImageView.leadingAnchor.constraint(equalTo: entryPriceLabel.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor, constant: 0).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 10)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 18)).isActive = true
        
        currentPriceLabel.textColor = .newBlack.withAlphaComponent(0.75)
        currentPriceLabel.textAlignment = .left
        currentPriceLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 16))
        currentPriceLabel.numberOfLines = 0
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(currentPriceLabel)
        currentPriceLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        currentPriceLabel.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor).isActive = true
        
        currentPriceTitleLabel.text = "Current Price"
        currentPriceTitleLabel.textColor = .newBlack.withAlphaComponent(0.5)
        currentPriceTitleLabel.textAlignment = .left
        currentPriceTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 9))
        currentPriceTitleLabel.numberOfLines = 0
        currentPriceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(currentPriceTitleLabel)
        currentPriceTitleLabel.leadingAnchor.constraint(equalTo: currentPriceLabel.leadingAnchor, constant: 0).isActive = true
        currentPriceTitleLabel.centerYAnchor.constraint(equalTo: entryPriceTitleLabel.centerYAnchor, constant: 0).isActive = true
        
        //unrealizedProfitLabel.textColor = .green//UIColor(red: 191/255, green: 106/255, blue: 106/255, alpha: 1.0)
        unrealizedProfitLabel.textAlignment = .right
        unrealizedProfitLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 16))
        unrealizedProfitLabel.numberOfLines = 0
        unrealizedProfitLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(unrealizedProfitLabel)
        unrealizedProfitLabel.trailingAnchor.constraint(equalTo: tradeDetailsContainer.trailingAnchor, constant: -.createAspectRatio(value: 32)).isActive = true
        unrealizedProfitLabel.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor).isActive = true

        unrealizedProfitTitleLabel.text = "Unrealized Profit"
        unrealizedProfitTitleLabel.textColor = .newBlack.withAlphaComponent(0.5)
        unrealizedProfitTitleLabel.textAlignment = .right
        unrealizedProfitTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 9))
        unrealizedProfitTitleLabel.numberOfLines = 0
        unrealizedProfitTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(unrealizedProfitTitleLabel)
        unrealizedProfitTitleLabel.trailingAnchor.constraint(equalTo: unrealizedProfitLabel.trailingAnchor, constant: 0).isActive = true
        unrealizedProfitTitleLabel.centerYAnchor.constraint(equalTo: entryPriceTitleLabel.centerYAnchor, constant: 0).isActive = true
        
        stopLossTitleLabel.text = "Stop Loss"
        stopLossTitleLabel.textColor = .newBlack.withAlphaComponent(0.5)
        stopLossTitleLabel.textAlignment = .left
        stopLossTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 9))
        stopLossTitleLabel.numberOfLines = 0
        stopLossTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(stopLossTitleLabel)
        stopLossTitleLabel.leadingAnchor.constraint(equalTo: entryPriceTitleLabel.leadingAnchor, constant: 0).isActive = true
        stopLossTitleLabel.topAnchor.constraint(equalTo: entryPriceLabel.bottomAnchor, constant: .createAspectRatio(value: 40)).isActive = true
        
        stopLossLabel.textColor = .newBlack.withAlphaComponent(0.75)
        stopLossLabel.textAlignment = .left
        stopLossLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 16))
        stopLossLabel.numberOfLines = 0
        stopLossLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(stopLossLabel)
        stopLossLabel.leadingAnchor.constraint(equalTo: stopLossTitleLabel.leadingAnchor, constant: 0).isActive = true
        stopLossLabel.topAnchor.constraint(equalTo: stopLossTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        
        takeProfitTitleLabel.text = "Take Profit"
        takeProfitTitleLabel.textColor = .newBlack.withAlphaComponent(0.5)
        takeProfitTitleLabel.textAlignment = .right
        takeProfitTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 9))
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
        
        if let stopLoss = forexSignal.order?.stopLoss {
            stopLossLabel.text = String(stopLoss)
        } else {
            stopLossLabel.text = "nil"
        }
        
        takeProfitLabel.textColor = .newBlack.withAlphaComponent(0.75)
        takeProfitLabel.textAlignment = .right
        takeProfitLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 16))
        takeProfitLabel.numberOfLines = 0
        takeProfitLabel.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(takeProfitLabel)
        takeProfitLabel.trailingAnchor.constraint(equalTo: takeProfitTitleLabel.trailingAnchor, constant: 0).isActive = true
        takeProfitLabel.centerYAnchor.constraint(equalTo: stopLossLabel.centerYAnchor, constant: 0).isActive = true
        
        //
                
        navTitleLabel.textAlignment = .center
        navTitleLabel.textColor = .newBlack
        navTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 19))
        navTitleLabel.numberOfLines = 0
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(navTitleLabel)
        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
                        
        modifyTradeOption.optionButton.addTarget(self, action: #selector(didTapModifyCloseOrder(sender:)), for: .touchUpInside)
        modifyTradeOption.optionButton.tag = 1
        modifyTradeOption.iconImageView.image = UIImage(named: "modifyImgNVU")
        modifyTradeOption.optionTitleLabel.text = "Modify Trade"
        modifyTradeOption.optionDetailLabel.text = "Modify Take Profit and Stop Loss"
        modifyTradeOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(modifyTradeOption)
        modifyTradeOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 0).isActive = true
        modifyTradeOption.topAnchor.constraint(equalTo: tradeDetailsContainer.bottomAnchor, constant: .createAspectRatio(value: 25)).isActive = true
        modifyTradeOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: 0).isActive = true
        modifyTradeOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
                        
        closeTradeOption.optionButton.addTarget(self, action: #selector(didTapModifyCloseOrder(sender:)), for: .touchUpInside)
        closeTradeOption.optionButton.tag = 2
        closeTradeOption.iconImageView.image = UIImage(named: "closeOrderImgNVU")
        closeTradeOption.optionTitleLabel.text = "Close Trade"
        closeTradeOption.optionDetailLabel.text = "Close an order immediately"
        closeTradeOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(closeTradeOption)
        closeTradeOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 0).isActive = true
        closeTradeOption.topAnchor.constraint(equalTo: modifyTradeOption.bottomAnchor, constant: 0).isActive = true
        closeTradeOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: 0).isActive = true
        closeTradeOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
        
        //SET UP LOADERS
        
        setupLoadingIndicator(activityIndicator: loadingIndicator, viewToPin: unrealizedProfitLabel, viewToPinTrailing: unrealizedProfitLabel, isOffset: false)
        setupLoadingIndicator(activityIndicator: cpLoadingIndicator, viewToPin: currentPriceLabel, viewToPinTrailing: currentPriceTitleLabel, isOffset: false)
        
        //SET LABEL VALUES
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            if let order = MyTabBarController.orderProfitUpdate?.data.orders.first(where: {$0.ticket == self?.forexSignal.order?.ticket}),
               let currentOrder = self?.forexSignal.order,
               let profit = currentOrder.profit,
               let commission = currentOrder.commission {
                
                self?.loadingIndicator.stopAnimating()
                self?.cpLoadingIndicator.stopAnimating()
                                
                let unrealizedProfit = (profit + commission).rounded(toPlaces: 2)
                let numberString = String(unrealizedProfit)
                if numberString.contains("-") {
                    self?.unrealizedProfitLabel.textColor = .brightRed
                } else {
                    self?.unrealizedProfitLabel.textColor = .brightGreen
                }
                
                self?.unrealizedProfitLabel.text = "\(unrealizedProfit.withCommas())"
                
                
                if let symbol = order.symbol, let livePrice = MyTabBarController.orderProfitUpdate?.livePrices.priceForSymbol(symbol: symbol.removePeriodsAndDashes()) {
                    if let liveDecCount = self?.countDecimalPlaces(livePrice), let roundToFive = self?.roundToFiveDecimalPlaces(livePrice) {
                        if liveDecCount > 5 {
                            self?.currentPriceLabel.text = "\(roundToFive)"
                        } else {
                            self?.currentPriceLabel.text = String(livePrice)
                        }
                    }
                }
            }
        }
        
    }
    
    func setupLoadingIndicator(activityIndicator: UIActivityIndicatorView, viewToPin: UIView, viewToPinTrailing: UIView, isOffset: Bool) {
        activityIndicator.color = .swBlue
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tradeDetailsContainer.addSubview(activityIndicator)
        if isOffset {
            activityIndicator.centerYAnchor.constraint(equalTo: viewToPin.centerYAnchor, constant: .createAspectRatio(value: 5)).isActive = true
        } else {
            activityIndicator.centerYAnchor.constraint(equalTo: viewToPin.centerYAnchor).isActive = true
        }
        activityIndicator.trailingAnchor.constraint(equalTo: viewToPinTrailing.trailingAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        activityIndicator.startAnimating()
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
