//
//  SignalsTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit

class SignalsTableViewCell: UITableViewCell {
    
    var assetImageView = UIImageView()
    
    var shadowlayer = UIView()
    var signalTimeLabel = UILabel()
    var currencyPairLabel = UILabel()
    var tickerLabel = UILabel()
    var coinGraph = UIImageView()
    var orderTypeLabel = UILabel()
    let dividerLabel = UILabel()
    
    var entryLabel = UILabel()
    var entryPriceLabel = UILabel()
    var tpOneLabel = UILabel()
    var tpOnePriceLabel = UILabel()
    var tpTwoLabel = UILabel()
    var tpTwoPriceLabel = UILabel()
    var tpThreeLabel = UILabel()
    var tpThreePriceLabel = UILabel()
    
    var stopLabel = UILabel()
    var stopPriceLabel = UILabel()
    
    var botImageView = UIImageView()
    var containerView = UIView()
    var dividerLine = UIView()
    var botTitleLabel = UILabel()
    var upDownImageView = UIImageView()
    var tradesLabel = UILabel()
    var botLvlLabel = UILabel()
    
    var addLabel = UILabel()
    
    var isDarkMode = false
    var textColor: UIColor = UIColor.white
    
    let noteDivider = UIView()
    let noteLabel = UILabel()
    
    //LOCKS
    var entryPriceLock = UIImageView()
    var stopLossLock = UIImageView()
    var takeProfitOneLock = UIImageView()
    var takeProfitTwoLock = UIImageView()
    var takeProfitThreeLock = UIImageView()
    
    var viewImageButton = UIButton()
    var imageGradient = UIImageView()
    var imageIcon = UIImageView()
    var viewImageLabel = UILabel()
        
    var signal: Signal?
    
    var unreadBubble = UIView()
    var unreadLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//MARK: VIEWS

extension SignalsTableViewCell {
    
    
    func setupViews() {
        
        assetImageView.layer.cornerRadius = 4
        assetImageView.layer.masksToBounds = true
        assetImageView.contentMode = .scaleAspectFill
        assetImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(assetImageView)
        assetImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33).isActive = true
        assetImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        assetImageView.heightAnchor.constraint(equalToConstant: 27).isActive = true
        assetImageView.widthAnchor.constraint(equalToConstant: 27).isActive = true
                
        currencyPairLabel.textColor = .newBlack
        currencyPairLabel.textAlignment = .left
        currencyPairLabel.font = .sofiaProSemiBold(ofSize: 16)
        currencyPairLabel.numberOfLines = 0
        currencyPairLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currencyPairLabel)
        currencyPairLabel.leadingAnchor.constraint(equalTo: assetImageView.trailingAnchor, constant: 6).isActive = true
        currencyPairLabel.centerYAnchor.constraint(equalTo: assetImageView.centerYAnchor, constant: 0).isActive = true
                
        dividerLabel.text = "|"
        dividerLabel.textColor = .newBlack.withAlphaComponent(0.5)
        dividerLabel.textAlignment = .left
        dividerLabel.font = .sofiaProRegular(ofSize: 14)
        dividerLabel.numberOfLines = 0
        dividerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dividerLabel)
        dividerLabel.leadingAnchor.constraint(equalTo: currencyPairLabel.trailingAnchor, constant: 3).isActive = true
        dividerLabel.centerYAnchor.constraint(equalTo: currencyPairLabel.centerYAnchor, constant: 0).isActive = true
                
        tickerLabel.textColor = .newBlack
        tickerLabel.textAlignment = .left
        tickerLabel.font = .sofiaProSemiBold(ofSize: 16)
        tickerLabel.numberOfLines = 0
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tickerLabel)
        tickerLabel.leadingAnchor.constraint(equalTo: currencyPairLabel.trailingAnchor, constant: 10).isActive = true
        tickerLabel.centerYAnchor.constraint(equalTo: currencyPairLabel.centerYAnchor, constant: 0).isActive = true
        
        signalTimeLabel.textColor = .newBlack.withAlphaComponent(0.5)
        signalTimeLabel.textAlignment = .left
        signalTimeLabel.font = .sofiaProRegular(ofSize: 14)
        signalTimeLabel.numberOfLines = 0
        signalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(signalTimeLabel)
        signalTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33).isActive = true
        signalTimeLabel.bottomAnchor.constraint(equalTo: assetImageView.bottomAnchor, constant: 0).isActive = true
                
        orderTypeLabel.textColor = .newBlack.withAlphaComponent(0.75)
        orderTypeLabel.textAlignment = .left
        orderTypeLabel.font = .sofiaProMedium(ofSize: 14)
        orderTypeLabel.numberOfLines = 0
        orderTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(orderTypeLabel)
        orderTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33).isActive = true
        orderTypeLabel.topAnchor.constraint(equalTo: assetImageView.topAnchor, constant: 0).isActive = true
        
        //
        
        entryLabel.text = "Entry Price"
        entryLabel.textColor = .newBlack.withAlphaComponent(0.5)
        entryLabel.textAlignment = .left
        entryLabel.font = .sofiaProMedium(ofSize: 16)
        entryLabel.numberOfLines = 0
        entryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(entryLabel)
        entryLabel.leadingAnchor.constraint(equalTo: assetImageView.leadingAnchor, constant: 0).isActive = true
        entryLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        //entryLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14).isActive = true
        entryLabel.topAnchor.constraint(equalTo: assetImageView.bottomAnchor, constant: 24).isActive = true
                
        entryPriceLabel.textColor = UIColor(red: 106/255, green: 191/255, blue: 150/255, alpha: 1.0)
        entryPriceLabel.textAlignment = .right
        entryPriceLabel.font = .sofiaProBold(ofSize: 16)
        entryPriceLabel.numberOfLines = 0
        entryPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(entryPriceLabel)
        entryPriceLabel.leadingAnchor.constraint(equalTo: assetImageView.leadingAnchor, constant: 0).isActive = true
        entryPriceLabel.topAnchor.constraint(equalTo: entryLabel.bottomAnchor, constant: 6).isActive = true
        
        tpOneLabel.text = "Take Profit 1"
        tpOneLabel.textColor = .newBlack.withAlphaComponent(0.5)
        tpOneLabel.textAlignment = .right
        tpOneLabel.font = .sofiaProMedium(ofSize: 16)
        tpOneLabel.numberOfLines = 0
        tpOneLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tpOneLabel)
        tpOneLabel.trailingAnchor.constraint(equalTo: orderTypeLabel.trailingAnchor, constant: 0).isActive = true
        tpOneLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        //tpOneLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14).isActive = true
        tpOneLabel.topAnchor.constraint(equalTo: entryLabel.topAnchor, constant: 0).isActive = true
                        
        tpOnePriceLabel.textColor = UIColor(red: 106/255, green: 191/255, blue: 150/255, alpha: 1.0)
        tpOnePriceLabel.textAlignment = .right
        tpOnePriceLabel.font = .sofiaProBold(ofSize: 16)
        tpOnePriceLabel.numberOfLines = 0
        tpOnePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tpOnePriceLabel)
        tpOnePriceLabel.trailingAnchor.constraint(equalTo: orderTypeLabel.trailingAnchor, constant: 0).isActive = true
        tpOnePriceLabel.topAnchor.constraint(equalTo: tpOneLabel.bottomAnchor, constant: 6).isActive = true
        
        tpTwoLabel.text = "Take Profit 2"
        tpTwoLabel.textColor = .newBlack.withAlphaComponent(0.5)
        tpTwoLabel.textAlignment = .right
        tpTwoLabel.font = .sofiaProMedium(ofSize: 16)
        tpTwoLabel.numberOfLines = 0
        tpTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tpTwoLabel)
        tpTwoLabel.trailingAnchor.constraint(equalTo: orderTypeLabel.trailingAnchor, constant: 0).isActive = true
        tpTwoLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        tpTwoLabel.topAnchor.constraint(equalTo: tpOnePriceLabel.bottomAnchor, constant: 18).isActive = true
                        
        tpTwoPriceLabel.textColor = UIColor(red: 106/255, green: 191/255, blue: 150/255, alpha: 1.0)
        tpTwoPriceLabel.textAlignment = .right
        tpTwoPriceLabel.font = .sofiaProBold(ofSize: 16)
        tpTwoPriceLabel.numberOfLines = 0
        tpTwoPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tpTwoPriceLabel)
        tpTwoPriceLabel.trailingAnchor.constraint(equalTo: orderTypeLabel.trailingAnchor, constant: 0).isActive = true
        tpTwoPriceLabel.topAnchor.constraint(equalTo: tpTwoLabel.bottomAnchor, constant: 6).isActive = true
        
        tpThreeLabel.text = "Take Profit 3"
        tpThreeLabel.textColor = .newBlack.withAlphaComponent(0.5)
        tpThreeLabel.textAlignment = .right
        tpThreeLabel.font = .sofiaProMedium(ofSize: 16)
        tpThreeLabel.numberOfLines = 0
        tpThreeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tpThreeLabel)
        tpThreeLabel.trailingAnchor.constraint(equalTo: orderTypeLabel.trailingAnchor, constant: 0).isActive = true
        tpThreeLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        tpThreeLabel.topAnchor.constraint(equalTo: tpTwoPriceLabel.bottomAnchor, constant: 18).isActive = true
                        
        tpThreePriceLabel.textColor = UIColor(red: 106/255, green: 191/255, blue: 150/255, alpha: 1.0)
        tpThreePriceLabel.textAlignment = .right
        tpThreePriceLabel.font = .sofiaProBold(ofSize: 16)
        tpThreePriceLabel.numberOfLines = 0
        tpThreePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tpThreePriceLabel)
        tpThreePriceLabel.trailingAnchor.constraint(equalTo: orderTypeLabel.trailingAnchor, constant: 0).isActive = true
        tpThreePriceLabel.topAnchor.constraint(equalTo: tpThreeLabel.bottomAnchor, constant: 6).isActive = true
        
        //
        
        stopLabel.text = "Stop Loss"
        stopLabel.textColor = .newBlack.withAlphaComponent(0.5)
        stopLabel.textAlignment = .left
        stopLabel.font = .sofiaProMedium(ofSize: 16)
        stopLabel.numberOfLines = 0
        stopLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stopLabel)
        stopLabel.leadingAnchor.constraint(equalTo: assetImageView.leadingAnchor, constant: 0).isActive = true
        stopLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        stopLabel.topAnchor.constraint(equalTo: tpThreeLabel.topAnchor, constant: 0).isActive = true
                        
        stopPriceLabel.textColor = UIColor(red: 191/255, green: 106/255, blue: 106/255, alpha: 1.0)
        stopPriceLabel.textAlignment = .left
        stopPriceLabel.font = .sofiaProBold(ofSize: 16)
        stopPriceLabel.numberOfLines = 0
        stopPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stopPriceLabel)
        stopPriceLabel.leadingAnchor.constraint(equalTo: stopLabel.leadingAnchor, constant: 0).isActive = true
        stopPriceLabel.topAnchor.constraint(equalTo: stopLabel.bottomAnchor, constant: 6).isActive = true
        stopPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -77).isActive = true
        
        //
        
        noteDivider.alpha = 0
        noteDivider.backgroundColor = .black.withAlphaComponent(0.1)
        noteDivider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noteDivider)
        noteDivider.leadingAnchor.constraint(equalTo: assetImageView.leadingAnchor, constant: 0).isActive = true
        noteDivider.trailingAnchor.constraint(equalTo: orderTypeLabel.trailingAnchor, constant: 0).isActive = true
        noteDivider.topAnchor.constraint(equalTo: stopPriceLabel.bottomAnchor, constant: 16).isActive = true
        noteDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
                
        noteLabel.isHidden = true
        noteLabel.textColor = .newBlack.withAlphaComponent(0.5)
        noteLabel.textAlignment = .left
        noteLabel.font = .sofiaProRegular(ofSize: 13)
        noteLabel.numberOfLines = 0
        noteLabel.text = " "
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noteLabel)
        noteLabel.leadingAnchor.constraint(equalTo: assetImageView.leadingAnchor, constant: 0).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: orderTypeLabel.trailingAnchor, constant: 0).isActive = true
        noteLabel.topAnchor.constraint(equalTo: noteDivider.bottomAnchor, constant: 16).isActive = true
        noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -77).isActive = true
        //noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true //-18
        
        shadowlayer.isUserInteractionEnabled = false
        shadowlayer.layer.zPosition = -1
        shadowlayer.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 2, height: 2), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        shadowlayer.backgroundColor = .clear
        shadowlayer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shadowlayer)
        shadowlayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        shadowlayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
        shadowlayer.topAnchor.constraint(equalTo: assetImageView.bottomAnchor, constant: 12).isActive = true
        shadowlayer.bottomAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 12).isActive = true
        
        //contentView.backgroundColor = .white//UIColor(red: 249/255, green: 250/255, blue: 251/255, alpha: 1.0)
        containerView.backgroundColor = .white
        textColor = .black
        
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        shadowlayer.addSubview(containerView)
        containerView.fillSuperview()
        
        //LOCKS
        
        createLock(lockIV: entryPriceLock)
        entryPriceLock.leadingAnchor.constraint(equalTo: entryPriceLabel.leadingAnchor, constant: 0).isActive = true
        entryPriceLock.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor, constant: 0).isActive = true
        
        createLock(lockIV: stopLossLock)
        stopLossLock.leadingAnchor.constraint(equalTo: stopPriceLabel.leadingAnchor, constant: 0).isActive = true
        stopLossLock.centerYAnchor.constraint(equalTo: stopPriceLabel.centerYAnchor, constant: 0).isActive = true
        
        createLock(lockIV: takeProfitOneLock)
        takeProfitOneLock.trailingAnchor.constraint(equalTo: tpOnePriceLabel.trailingAnchor, constant: 0).isActive = true
        takeProfitOneLock.centerYAnchor.constraint(equalTo: tpOnePriceLabel.centerYAnchor, constant: 0).isActive = true
        
        createLock(lockIV: takeProfitTwoLock)
        takeProfitTwoLock.trailingAnchor.constraint(equalTo: tpTwoPriceLabel.trailingAnchor, constant: 0).isActive = true
        takeProfitTwoLock.centerYAnchor.constraint(equalTo: tpTwoPriceLabel.centerYAnchor, constant: 0).isActive = true
        
        createLock(lockIV: takeProfitThreeLock)
        takeProfitThreeLock.trailingAnchor.constraint(equalTo: tpThreePriceLabel.trailingAnchor, constant: 0).isActive = true
        takeProfitThreeLock.centerYAnchor.constraint(equalTo: tpThreePriceLabel.centerYAnchor, constant: 0).isActive = true
        
        //View Image
        
        viewImageButton.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 2, height: 2), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        viewImageButton.layer.zPosition = -2
        viewImageButton.backgroundColor = .clear
        viewImageButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(viewImageButton)
        viewImageButton.leadingAnchor.constraint(equalTo: self.shadowlayer.leadingAnchor, constant: 5).isActive = true
        viewImageButton.trailingAnchor.constraint(equalTo: self.shadowlayer.trailingAnchor, constant: -5).isActive = true
        viewImageButton.topAnchor.constraint(equalTo: self.shadowlayer.bottomAnchor, constant: -1).isActive = true
        viewImageButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        imageGradient.isUserInteractionEnabled = false
        imageGradient.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageGradient.layer.cornerRadius = 15
        imageGradient.layer.masksToBounds = true
        imageGradient.image = UIImage(named: "buttonGradientNVU")
        imageGradient.contentMode = .scaleAspectFill
        imageGradient.translatesAutoresizingMaskIntoConstraints = false
        viewImageButton.addSubview(imageGradient)
        imageGradient.fillSuperview()
        
        viewImageLabel.isUserInteractionEnabled = false
        viewImageLabel.text = "View Thread"
        viewImageLabel.textAlignment = .left
        viewImageLabel.textColor = .white
        viewImageLabel.font = .sofiaProMedium(ofSize: 15)
        viewImageLabel.numberOfLines = 0
        viewImageLabel.translatesAutoresizingMaskIntoConstraints = false
        viewImageButton.addSubview(viewImageLabel)
        viewImageLabel.centerXAnchor.constraint(equalTo: viewImageButton.centerXAnchor, constant: 14).isActive = true
        viewImageLabel.centerYAnchor.constraint(equalTo: viewImageButton.centerYAnchor, constant: 2).isActive = true
        
        imageIcon.isUserInteractionEnabled = false
        imageIcon.image = UIImage(named: "message-circle-1")
        imageIcon.contentMode = .scaleAspectFill
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        viewImageButton.addSubview(imageIcon)
        imageIcon.trailingAnchor.constraint(equalTo: viewImageLabel.leadingAnchor, constant: -5).isActive = true
        imageIcon.centerYAnchor.constraint(equalTo: viewImageLabel.centerYAnchor, constant: -1).isActive = true
        imageIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        //createUnreadIndicator()
        
    }
    
    func createLock(lockIV: UIImageView) {
        lockIV.image = UIImage(named: "signalLock")
        lockIV.contentMode = .scaleAspectFill
        lockIV.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lockIV)
        lockIV.widthAnchor.constraint(equalToConstant: 24).isActive = true
        lockIV.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    func createUnreadIndicator() {
        unreadBubble.backgroundColor = .red
        unreadBubble.layer.cornerRadius = 24/2
        unreadBubble.layer.masksToBounds = true
        unreadBubble.translatesAutoresizingMaskIntoConstraints = false
        viewImageButton.addSubview(unreadBubble)
        unreadBubble.heightAnchor.constraint(equalToConstant: 24).isActive = true
        unreadBubble.widthAnchor.constraint(equalToConstant: 24).isActive = true
        unreadBubble.trailingAnchor.constraint(equalTo: viewImageButton.trailingAnchor, constant: 5).isActive = true
        unreadBubble.bottomAnchor.constraint(equalTo: viewImageButton.bottomAnchor, constant: 9).isActive = true
        
        unreadLabel.text = "3"
        unreadLabel.font = .sofiaProSemiBold(ofSize: 18)
        unreadLabel.textColor = .white
        unreadLabel.numberOfLines = 0
        unreadLabel.translatesAutoresizingMaskIntoConstraints = false
        unreadBubble.addSubview(unreadLabel)
        unreadLabel.centerXAnchor.constraint(equalTo: unreadBubble.centerXAnchor).isActive = true
        unreadLabel.centerYAnchor.constraint(equalTo: unreadBubble.centerYAnchor, constant: 1).isActive = true
    }
    
}


