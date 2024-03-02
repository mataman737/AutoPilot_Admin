//
//  TeamMemberOptionsViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/12/23.
//

import Foundation
import UIKit
import Lottie

extension TeamMemberOptionsViewController {
    
    func setupColors() {
        mainContainer.backgroundColor = .white
        keyLine.backgroundColor = .black.withAlphaComponent(0.25)
        textColor = .black
        navTitleLabel.textColor = .black
        dateLabel.textColor = .black.withAlphaComponent(0.5)
        
        newChannelOption.optionTitleLabel.textColor = .newBlack
        newChannelOption.optionDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
        
        sendContentOption.optionTitleLabel.textColor = .newBlack
        sendContentOption.optionDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)                
    }
    
    func setupViews() {
            
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
        wrapper.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        wrapper.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true
        wrapper.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        wrapper.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
        
        mainContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainContainer.layer.cornerRadius = .createAspectRatio(value: 15)
        mainContainer.layer.masksToBounds = true
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(mainContainer)
        mainContainer.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor).isActive = true
        mainContainer.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 644)).isActive = true //580
        mainContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        keyLine.backgroundColor = .black.withAlphaComponent(0.25)
        keyLine.layer.cornerRadius = .createAspectRatio(value: 4)/2
        keyLine.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(keyLine)
        keyLine.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        keyLine.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        keyLine.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 34)).isActive = true
        keyLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
                        
        navTitleLabel.textColor = .black
        navTitleLabel.isUserInteractionEnabled = false
        navTitleLabel.textAlignment = .center
        navTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 19))
        navTitleLabel.numberOfLines = 0
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(navTitleLabel)
        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
                        
        dateLabel.textAlignment = .center
        dateLabel.font = .poppinsRegular(ofSize: .createAspectRatio(value: 13))
        dateLabel.numberOfLines = 0
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 5)).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        
        totalPercentChangeLabel.text = "+30%"
        totalPercentChangeLabel.textColor = .mainThemeGreen
        totalPercentChangeLabel.textAlignment = .right
        totalPercentChangeLabel.font = .poppinsSemiBold(ofSize: .createAspectRatio(value: 16))
        totalPercentChangeLabel.numberOfLines = 0
        totalPercentChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(totalPercentChangeLabel)
        totalPercentChangeLabel.centerYAnchor.constraint(equalTo: navTitleLabel.centerYAnchor).isActive = true
        totalPercentChangeLabel.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        
        //if 
        lotPercentView.delegate = self
        //lotPercentView.lotSizeContainer.addTarget(self, action: #selector(animateTables(sender:)), for: .touchUpInside)
        //lotPercentView.percentContainer.addTarget(self, action: #selector(animateTables(sender:)), for: .touchUpInside)
        lotPercentView.lotSizeLabel.text = "Paid"
        lotPercentView.percentLabel.text = "Unpaid"
        lotPercentView.lotSizeContainer.tag = 0
        lotPercentView.percentContainer.tag = 1
        lotPercentView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(lotPercentView)
        lotPercentView.centerXAnchor.constraint(equalTo: navTitleLabel.centerXAnchor).isActive = true
        lotPercentView.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        lotPercentView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 29)).isActive = true
        lotPercentView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 178)).isActive = true
                
        lineGraphView.backgroundColor = .clear
        lineGraphView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(lineGraphView)
        lineGraphView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        lineGraphView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        lineGraphView.topAnchor.constraint(equalTo: lotPercentView.bottomAnchor, constant: .createAspectRatio(value: 35)).isActive = true //25
        lineGraphView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 260)).isActive = true
        
        //newChannelOption.backgroundColor = .blue
        newChannelOption.iconImageView.image = UIImage(named: "phonecall")
        newChannelOption.iconImageView.setImageColor(color: .black)
        newChannelOption.optionTitleLabel.text = "Call"
        newChannelOption.optionButton.addTarget(self, action: #selector(makePhoneCall), for: .touchUpInside)
        newChannelOption.optionDetailLabel.text = "Start a phone call"
        newChannelOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(newChannelOption)
        newChannelOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        //newChannelOption.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 70)).isActive = true
        newChannelOption.topAnchor.constraint(equalTo: lineGraphView.bottomAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        newChannelOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        newChannelOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
        
        //sendContentOption.backgroundColor = .red.withAlphaComponent(0.5)
        sendContentOption.optionButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        sendContentOption.iconImageView.image = UIImage(named: "message-circle-grad-thickNVU")
        sendContentOption.iconImageView.setImageColor(color: .black)
        sendContentOption.optionTitleLabel.text = "Send Message"
        sendContentOption.optionDetailLabel.text = "Open up iMessage"
        sendContentOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(sendContentOption)
        sendContentOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        sendContentOption.topAnchor.constraint(equalTo: newChannelOption.bottomAnchor).isActive = true
        sendContentOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        sendContentOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
    }
    
    func setupLineGraph(/*chartData: SignalChartData*/) {
        lineGraphView.setUplineChart()
        
        lineGraphView.lineChart.priceDates = generate90Days()
        lineGraphView.lineChart.usersBrokerHistoricalPrices = generateRandomDoubles()
                                        
                
        let arrayCount = 90.0
        let userBrokerEntry = 61.0
        lineGraphView.lineChart.userBrokerEntryToAppend = Array(repeating: userBrokerEntry, count: Int(arrayCount))
                
        lineGraphView.lineChart.populateData()
        lineGraphView.lineChart.lineChartSetup()
                        
    }
    
    func generateRandomDoubles() -> [Double] {
        var randomDoubles = [Double]()

        for _ in 1...10 {
            let randomValue = Double.random(in: 500...550)
            randomDoubles.append(randomValue.rounded(toPlaces: 2))
        }
        
        for _ in 11...20 {
            let randomValue = Double.random(in: 551...600)
            randomDoubles.append(randomValue.rounded(toPlaces: 2))
        }
        
        for _ in 21...30 {
            let randomValue = Double.random(in: 601...650)
            randomDoubles.append(randomValue.rounded(toPlaces: 2))
        }
        
        for _ in 31...40 {
            let randomValue = Double.random(in: 651...700)
            randomDoubles.append(randomValue.rounded(toPlaces: 2))
        }
        
        for _ in 41...50 {
            let randomValue = Double.random(in: 701...750)
            randomDoubles.append(randomValue.rounded(toPlaces: 2))
        }
        
        for _ in 51...60 {
            let randomValue = Double.random(in: 751...800)
            randomDoubles.append(randomValue.rounded(toPlaces: 2))
        }
        
        for _ in 61...70 {
            let randomValue = Double.random(in: 851...900)
            randomDoubles.append(randomValue.rounded(toPlaces: 2))
        }
        
        for _ in 71...80 {
            let randomValue = Double.random(in: 951...1000)
            randomDoubles.append(randomValue.rounded(toPlaces: 2))
        }
        
        for _ in 81...90 {
            let randomValue = Double.random(in: 1001...1050)
            randomDoubles.append(randomValue.rounded(toPlaces: 2))
        }

        return randomDoubles
    }
    
    func generate90Days() -> [String] {
        var dateArray = [String]()

        for i in 1...90 {
            dateArray.append("\(i)")
        }

        return dateArray
    }
    
}
