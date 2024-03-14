//
//  ClosedOrderTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/6/23.
//

import UIKit

class ClosedOrderTableViewCell: UITableViewCell {

    var isDarkMode = UserDefaults()
    var assetImageView = UIImageView()
    var shadowlayer = UIView()
    var signalTimeLabel = UILabel()
    var currencyPairLabel = UILabel()
    var tickerLabel = UILabel()
    var coinGraph = UIImageView()
    var orderTypeLabel = UILabel()
    let dividerLabel = UILabel()
    var arrowImageView = UIImageView()
    
    var entryLabel = UILabel()
    var entryPriceLabel = UILabel()
    var tpOneLabel = UILabel()
    var currentPriceLabel = UILabel()
    
    var unrealizedProfitLabel = UILabel()
    
    var containerView = UIView()
        
    var textColor: UIColor = UIColor.white
                                
    //
    
    var currentPricePipTimeLabel = UILabel()
    var currentPricePipTimeContainer = UIView()
    
    var currentPrice: String?
    var pipDifference: Double?
    
    //
    
    var backgroundGradientImageView = UIImageView()
    var entryTitleLabel = UILabel()
    var closeTitleLabel = UILabel()
    var profitTitleLabel = UILabel()
    var dividerLine = UIView()
    var circleZeroImageView = UIImageView()
    var circleOneImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        //setupViews()
        setupNewViews()
        //setupColors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//MARK: VIEWS

extension ClosedOrderTableViewCell {
    
    func setupColors() {
        arrowImageView.image = UIImage(named: "sigArrow")
        
        if isDarkMode.bool(forKey: "isDarkMode") {
            currencyPairLabel.textColor = .white
            tickerLabel.textColor = .white
            signalTimeLabel.textColor = .white.withAlphaComponent(0.5)
            orderTypeLabel.textColor = .white.withAlphaComponent(0.75)
            containerView.backgroundColor = .darkModeCardBackground
            entryPriceLabel.textColor = .white.withAlphaComponent(0.75)
            currentPriceLabel.textColor = .white.withAlphaComponent(0.75)
            arrowImageView.setImageColor(color: .white)
        } else {
            currencyPairLabel.textColor = .newBlack
            tickerLabel.textColor = .newBlack
            signalTimeLabel.textColor = .newBlack.withAlphaComponent(0.5)
            orderTypeLabel.textColor = .newBlack.withAlphaComponent(0.75)
            containerView.backgroundColor = .white
            entryPriceLabel.textColor = UIColor.black.withAlphaComponent(0.75)
            currentPriceLabel.textColor = UIColor.black.withAlphaComponent(0.75)
        }
    }
    
    func setupViews() {
        
        assetImageView.image = UIImage(named: "forexBotIcon")
        assetImageView.layer.cornerRadius = .createAspectRatio(value: 4)
        assetImageView.layer.masksToBounds = true
        assetImageView.contentMode = .scaleAspectFill
        assetImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(assetImageView)
        assetImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 33)).isActive = true
        assetImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        assetImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 27)).isActive = true
        assetImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 27)).isActive = true
        
        currencyPairLabel.textAlignment = .left
        currencyPairLabel.font = .poppinsSemiBold(ofSize: .createAspectRatio(value: 16))
        currencyPairLabel.numberOfLines = 0
        currencyPairLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currencyPairLabel)
        currencyPairLabel.leadingAnchor.constraint(equalTo: assetImageView.trailingAnchor, constant: .createAspectRatio(value: 6)).isActive = true
        //currencyPairLabel.centerYAnchor.constraint(equalTo: assetImageView.centerYAnchor).isActive = true
        currencyPairLabel.centerYAnchor.constraint(equalTo: assetImageView.centerYAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        
        tickerLabel.text = "-"
        tickerLabel.alpha = 0.5
        tickerLabel.textAlignment = .left
        tickerLabel.font = .poppinsRegular(ofSize: .createAspectRatio(value: 12))
        tickerLabel.numberOfLines = 0
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tickerLabel)
        //        tickerLabel.leadingAnchor.constraint(equalTo: currencyPairLabel.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        //        tickerLabel.centerYAnchor.constraint(equalTo: currencyPairLabel.centerYAnchor).isActive = true
        tickerLabel.leadingAnchor.constraint(equalTo: assetImageView.trailingAnchor, constant: .createAspectRatio(value: 6)).isActive = true
        //signalTypeLabel.centerYAnchor.constraint(equalTo: assetImageView.centerYAnchor).isActive = true
        tickerLabel.centerYAnchor.constraint(equalTo: assetImageView.centerYAnchor, constant: .createAspectRatio(value: 9)).isActive = true
        
        signalTimeLabel.textAlignment = .left
        signalTimeLabel.font = .poppinsRegular(ofSize: .createAspectRatio(value: 14))
        signalTimeLabel.numberOfLines = 0
        signalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(signalTimeLabel)
        signalTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 33)).isActive = true
        signalTimeLabel.bottomAnchor.constraint(equalTo: assetImageView.bottomAnchor, constant: .createAspectRatio(value: 1)).isActive = true
        
        orderTypeLabel.textAlignment = .left
        orderTypeLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 14))
        orderTypeLabel.numberOfLines = 0
        orderTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(orderTypeLabel)
        orderTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 33)).isActive = true
        orderTypeLabel.topAnchor.constraint(equalTo: assetImageView.topAnchor, constant: -.createAspectRatio(value: 1)).isActive = true
        
        //
        
        shadowlayer.isUserInteractionEnabled = false
        shadowlayer.layer.zPosition = -1
        shadowlayer.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 2, height: 2), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        shadowlayer.backgroundColor = .clear
        shadowlayer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shadowlayer)
        shadowlayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 22)).isActive = true
        shadowlayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 22)).isActive = true
        shadowlayer.topAnchor.constraint(equalTo: assetImageView.bottomAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        shadowlayer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 63)).isActive = true
        
        containerView.layer.cornerRadius = .createAspectRatio(value: 8)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        shadowlayer.addSubview(containerView)
        containerView.fillSuperview()
        
        entryPriceLabel.textAlignment = .left
        entryPriceLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 16))
        entryPriceLabel.numberOfLines = 0
        entryPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(entryPriceLabel)
        entryPriceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        entryPriceLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
                
        arrowImageView.image = UIImage(named: "sigArrow")
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(arrowImageView)
        arrowImageView.leadingAnchor.constraint(equalTo: entryPriceLabel.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 10)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 18)).isActive = true
                
        currentPriceLabel.textAlignment = .left
        currentPriceLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 16))
        currentPriceLabel.numberOfLines = 0
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(currentPriceLabel)
        currentPriceLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        currentPriceLabel.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor).isActive = true
        
        unrealizedProfitLabel.textAlignment = .right
        unrealizedProfitLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 16))
        unrealizedProfitLabel.numberOfLines = 0
        unrealizedProfitLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(unrealizedProfitLabel)
        unrealizedProfitLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        unrealizedProfitLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    func setupNewViews() {
        //self.contentView.backgroundColor = .red
        
        backgroundGradientImageView.image = UIImage(named: "greenTradeGrad")
        //backgroundGradientImageView.backgroundColor = .purple
        backgroundGradientImageView.layer.masksToBounds = true
        backgroundGradientImageView.layer.cornerRadius = 10
        backgroundGradientImageView.contentMode = .scaleAspectFill
        backgroundGradientImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(backgroundGradientImageView)
        backgroundGradientImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        backgroundGradientImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        backgroundGradientImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        backgroundGradientImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.createAspectRatio(value: 12)).isActive = true
        
        assetImageView.backgroundColor = .clear
        //assetImageView.layer.masksToBounds = true
        //assetImageView.contentMode = .scaleAspectFill
        assetImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundGradientImageView.addSubview(assetImageView)
        //assetImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .createAspectRatio(value: 0)).isActive = true //10
        assetImageView.leadingAnchor.constraint(equalTo: backgroundGradientImageView.leadingAnchor, constant: .createAspectRatio(value: 10)).isActive = true //10
        assetImageView.topAnchor.constraint(equalTo: backgroundGradientImageView.topAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        assetImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 35)).isActive = true
        assetImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        
        
        circleOneImageView.backgroundColor = .lightGray
        circleOneImageView.layer.masksToBounds = true
        circleOneImageView.contentMode = .scaleAspectFill
        circleOneImageView.layer.cornerRadius = .createAspectRatio(value: 23)/2
        circleOneImageView.layer.borderColor = UIColor.darkModeBackground.cgColor
        circleOneImageView.layer.borderWidth = 2
        circleOneImageView.translatesAutoresizingMaskIntoConstraints = false
        assetImageView.addSubview(circleOneImageView)
        circleOneImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 23)).isActive = true
        circleOneImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 23)).isActive = true
        circleOneImageView.trailingAnchor.constraint(equalTo: assetImageView.trailingAnchor).isActive = true
        circleOneImageView.topAnchor.constraint(equalTo: assetImageView.topAnchor).isActive = true
        
        circleZeroImageView.backgroundColor = .darkGray
        circleZeroImageView.layer.cornerRadius = .createAspectRatio(value: 23)/2
        circleZeroImageView.layer.masksToBounds = true
        circleZeroImageView.contentMode = .scaleAspectFill
        circleZeroImageView.layer.borderColor = UIColor.darkModeBackground.cgColor
        circleZeroImageView.layer.borderWidth = 2
        circleZeroImageView.translatesAutoresizingMaskIntoConstraints = false
        assetImageView.addSubview(circleZeroImageView)
        circleZeroImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 23)).isActive = true
        circleZeroImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 23)).isActive = true
        circleZeroImageView.leadingAnchor.constraint(equalTo: assetImageView.leadingAnchor).isActive = true
        circleZeroImageView.bottomAnchor.constraint(equalTo: assetImageView.bottomAnchor).isActive = true
        
        currencyPairLabel.setupLabel(text: "", txtColor: .white, font: .poppinsMedium(ofSize: .createAspectRatio(value: 16)), txtAlignment: .left)
        backgroundGradientImageView.addSubview(currencyPairLabel)
        currencyPairLabel.leadingAnchor.constraint(equalTo: assetImageView.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        currencyPairLabel.topAnchor.constraint(equalTo: backgroundGradientImageView.topAnchor, constant: .createAspectRatio(value: 14)).isActive = true
        
        signalTimeLabel.setupLabel(text: "", txtColor: .white.withAlphaComponent(0.5), font: .poppinsRegular(ofSize: .createAspectRatio(value: 10)), txtAlignment: .left)
        backgroundGradientImageView.addSubview(signalTimeLabel)
        signalTimeLabel.leadingAnchor.constraint(equalTo: currencyPairLabel.leadingAnchor, constant: .createAspectRatio(value: 0)).isActive = true
        signalTimeLabel.topAnchor.constraint(equalTo: currencyPairLabel.bottomAnchor, constant: .createAspectRatio(value: 0)).isActive = true
        
        entryPriceLabel.setupLabel(text: "", txtColor: .white.withAlphaComponent(0.5), font: .poppinsMedium(ofSize: .createAspectRatio(value: 18)), txtAlignment: .left)
        backgroundGradientImageView.addSubview(entryPriceLabel)
        entryPriceLabel.leadingAnchor.constraint(equalTo: assetImageView.leadingAnchor, constant: .createAspectRatio(value: 0)).isActive = true
        entryPriceLabel.bottomAnchor.constraint(equalTo: backgroundGradientImageView.bottomAnchor, constant: -.createAspectRatio(value: 8)).isActive = true
        
        entryTitleLabel.setupLabel(text: "ENTRY PRICE", txtColor: .white.withAlphaComponent(0.5), font: .poppinsRegular(ofSize: .createAspectRatio(value: 8)), txtAlignment: .left)
        backgroundGradientImageView.addSubview(entryTitleLabel)
        entryTitleLabel.leadingAnchor.constraint(equalTo: entryPriceLabel.leadingAnchor).isActive = true
        entryTitleLabel.bottomAnchor.constraint(equalTo: entryPriceLabel.topAnchor, constant: -.createAspectRatio(value: 0)).isActive = true
        
        arrowImageView.image = UIImage(named: "littleArrow")
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundGradientImageView.addSubview(arrowImageView)
        arrowImageView.leadingAnchor.constraint(equalTo: entryPriceLabel.trailingAnchor, constant: .createAspectRatio(value: 11)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor, constant: .createAspectRatio(value: 0)).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 14)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 14)).isActive = true
        
        currentPriceLabel.setupLabel(text: "", txtColor: .red, font: .poppinsMedium(ofSize: .createAspectRatio(value: 18)), txtAlignment: .left)
        backgroundGradientImageView.addSubview(currentPriceLabel)
        //currentPriceLabel.leadingAnchor.constraint(equalTo: entryPriceLabel.trailingAnchor, constant: .createAspectRatio(value: 36)).isActive = true
        currentPriceLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: .createAspectRatio(value: 11)).isActive = true
        currentPriceLabel.bottomAnchor.constraint(equalTo: entryPriceLabel.bottomAnchor).isActive = true
        
        closeTitleLabel.setupLabel(text: "CLOSE PRICE", txtColor: .white.withAlphaComponent(0.5), font: .poppinsRegular(ofSize: .createAspectRatio(value: 8)), txtAlignment: .left)
        backgroundGradientImageView.addSubview(closeTitleLabel)
        closeTitleLabel.leadingAnchor.constraint(equalTo: currentPriceLabel.leadingAnchor).isActive = true
        closeTitleLabel.bottomAnchor.constraint(equalTo: currentPriceLabel.topAnchor, constant: -.createAspectRatio(value: 0)).isActive = true
        
        unrealizedProfitLabel.setupLabel(text: "0.0", txtColor: .white, font: .poppinsMedium(ofSize: .createAspectRatio(value: 18)), txtAlignment: .right)
        backgroundGradientImageView.addSubview(unrealizedProfitLabel)
        unrealizedProfitLabel.trailingAnchor.constraint(equalTo: backgroundGradientImageView.trailingAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        unrealizedProfitLabel.bottomAnchor.constraint(equalTo: entryPriceLabel.bottomAnchor).isActive = true
        
        profitTitleLabel.setupLabel(text: "PROFIT", txtColor: .white.withAlphaComponent(0.5), font: .poppinsRegular(ofSize: .createAspectRatio(value: 8)), txtAlignment: .right)
        backgroundGradientImageView.addSubview(profitTitleLabel)
        profitTitleLabel.trailingAnchor.constraint(equalTo: unrealizedProfitLabel.trailingAnchor).isActive = true
        profitTitleLabel.bottomAnchor.constraint(equalTo: unrealizedProfitLabel.topAnchor, constant: -.createAspectRatio(value: 0)).isActive = true
        
        tickerLabel.setupLabel(text: "0 pips", txtColor: UIColor(red: 44/255, green: 221/255, blue: 127/255, alpha: 1.0), font: .poppinsMedium(ofSize: .createAspectRatio(value: 16)), txtAlignment: .right)
        backgroundGradientImageView.addSubview(tickerLabel)
        tickerLabel.trailingAnchor.constraint(equalTo: unrealizedProfitLabel.trailingAnchor).isActive = true
        tickerLabel.centerYAnchor.constraint(equalTo: currencyPairLabel.centerYAnchor).isActive = true
        
        dividerLine.backgroundColor = UIColor(red: 44/255, green: 221/255, blue: 127/255, alpha: 0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        backgroundGradientImageView.addSubview(dividerLine)
        dividerLine.centerYAnchor.constraint(equalTo: tickerLabel.centerYAnchor).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: tickerLabel.leadingAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        dividerLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        orderTypeLabel.setupLabel(text: "", txtColor: UIColor(red: 44/255, green: 221/255, blue: 127/255, alpha: 1.0), font: .poppinsMedium(ofSize: .createAspectRatio(value: 16)), txtAlignment: .right)
        backgroundGradientImageView.addSubview(orderTypeLabel)
        orderTypeLabel.trailingAnchor.constraint(equalTo: tickerLabel.leadingAnchor, constant: -.createAspectRatio(value: 21)).isActive = true
        orderTypeLabel.centerYAnchor.constraint(equalTo: tickerLabel.centerYAnchor).isActive = true
    }
}

