//
//  OpenOrdersTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/6/23.
//

import UIKit

class OpenOrdersTableViewCell: UITableViewCell {
    
    var isNVUDemo = UserDefaults()
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
    
    var stopLabel = UILabel()
    var unrealizedProfitLabel = UILabel()
    
    var botImageView = UIImageView()
    var containerView = UIView()
    var dividerLine = UIView()
    var botTitleLabel = UILabel()
    var upDownImageView = UIImageView()
    var tradesLabel = UILabel()
    var botLvlLabel = UILabel()
    
    var addLabel = UILabel()
    
    var isCrypto = true
    var isNegative = false
    var canPlaceInstantTrade = true
    var textColor: UIColor = UIColor.white
    
    let noteDivider = UIView()
    let noteLabel = UILabel()
    var alertBellImageView = UIImageView()
    var instantTradeDeactivatedLabel = UILabel()
    
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
    
    var unreadBubble = UIView()
    var unreadLabel = UILabel()
    
    //var signal: InstantTradeStatus?//Signal?
    //var mtSignal: MTInstantTradeStatus?//Signal?
    var signalDate: Date?
    var signalTimeFrom: String?
    //var instantTrade: InstantTradeStatus?
    //var activeOrder: MetaPositionStatusResponse?
    
    var timer = Timer()

    var currentPricePipTimeLabel = UILabel()
    var currentPricePipTimeContainer = UIView()
    
    var currentPrice: String?
    var pipDifference: Double?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        setupViews()
        setupColors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//MARK: VIEWS

extension OpenOrdersTableViewCell {
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
        currencyPairLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 16))
        currencyPairLabel.numberOfLines = 0
        currencyPairLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currencyPairLabel)
        currencyPairLabel.leadingAnchor.constraint(equalTo: assetImageView.trailingAnchor, constant: .createAspectRatio(value: 6)).isActive = true
        currencyPairLabel.centerYAnchor.constraint(equalTo: assetImageView.centerYAnchor).isActive = true
                
        tickerLabel.textAlignment = .left
        tickerLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 16))
        tickerLabel.numberOfLines = 0
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tickerLabel)
        tickerLabel.leadingAnchor.constraint(equalTo: currencyPairLabel.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        tickerLabel.centerYAnchor.constraint(equalTo: currencyPairLabel.centerYAnchor).isActive = true
                
        signalTimeLabel.textAlignment = .left
        signalTimeLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 14))
        signalTimeLabel.numberOfLines = 0
        signalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(signalTimeLabel)
        signalTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 33)).isActive = true
        signalTimeLabel.bottomAnchor.constraint(equalTo: assetImageView.bottomAnchor, constant: .createAspectRatio(value: 1)).isActive = true
                
        orderTypeLabel.textAlignment = .left
        orderTypeLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 14))
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
        entryPriceLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 16))
        entryPriceLabel.numberOfLines = 0
        entryPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(entryPriceLabel)
        entryPriceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        entryPriceLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
                        
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(arrowImageView)
        arrowImageView.leadingAnchor.constraint(equalTo: entryPriceLabel.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 10)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 18)).isActive = true
                        
        currentPriceLabel.textAlignment = .left
        currentPriceLabel.font = .sofiaProBold(ofSize: 16)
        currentPriceLabel.numberOfLines = 0
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(currentPriceLabel)
        currentPriceLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        currentPriceLabel.centerYAnchor.constraint(equalTo: entryPriceLabel.centerYAnchor).isActive = true
        
        unrealizedProfitLabel.text = "0.0"
        unrealizedProfitLabel.textColor = UIColor(red: 191/255, green: 106/255, blue: 106/255, alpha: 1.0)
        unrealizedProfitLabel.textAlignment = .right
        unrealizedProfitLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 16))
        unrealizedProfitLabel.numberOfLines = 0
        unrealizedProfitLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(unrealizedProfitLabel)
        unrealizedProfitLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        unrealizedProfitLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
                                                
    }
}

