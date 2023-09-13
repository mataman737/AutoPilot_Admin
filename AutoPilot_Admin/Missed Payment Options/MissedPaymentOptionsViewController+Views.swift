//
//  MissedPaymentOptionsViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/12/23.
//

import Foundation
import UIKit
import Lottie

extension MissedPaymentOptionsViewController {
    
    func setupColors() {
        mainContainer.backgroundColor = .white
        keyLine.backgroundColor = .white
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
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 300)).isActive = true //376 //445
        mainContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        keyLine.layer.cornerRadius = .createAspectRatio(value: 4)/2
        keyLine.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(keyLine)
        keyLine.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        keyLine.bottomAnchor.constraint(equalTo: mainContainer.topAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        keyLine.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 34)).isActive = true
        keyLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        keyLine.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
                        
        navTitleLabel.textAlignment = .center
        navTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 19))
        navTitleLabel.numberOfLines = 0
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(navTitleLabel)
        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 18).isActive = true
        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
                        
        dateLabel.textAlignment = .center
        dateLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 13))
        dateLabel.numberOfLines = 0
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 5)).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        
        newChannelOption.iconImageView.image = UIImage(named: "phonecall")
        newChannelOption.optionTitleLabel.text = "Call"
        newChannelOption.optionButton.addTarget(self, action: #selector(makePhoneCall), for: .touchUpInside)
        newChannelOption.optionDetailLabel.text = "Start a phone call"
        newChannelOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(newChannelOption)
        newChannelOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        newChannelOption.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 70)).isActive = true
        newChannelOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        newChannelOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
        
        sendContentOption.optionButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        sendContentOption.iconImageView.image = UIImage(named: "message-circle-grad-thickNVU")
        sendContentOption.optionTitleLabel.text = "Send Message"
        sendContentOption.optionDetailLabel.text = "Open up iMessage"
        sendContentOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(sendContentOption)
        sendContentOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        sendContentOption.topAnchor.constraint(equalTo: newChannelOption.bottomAnchor).isActive = true
        sendContentOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        sendContentOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
    }
    
}
