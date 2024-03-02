//
//  CancelPendingOrderViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/10/23.
//

import Foundation
import UIKit
import Lottie

extension CancelPendingOrderViewController {
    
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
        
        //let opacityTapped = UITapGestureRecognizer(target: self, action: #selector(dimissVC))
        //opacityLayer.addGestureRecognizer(opacityTapped)
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
        mainContainer.layer.cornerRadius = 15
        mainContainer.layer.masksToBounds = true
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(mainContainer)
        mainContainer.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: 0).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 0).isActive = true
        mainContainer.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 380)).isActive = true //366
        mainContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        keyLine.layer.cornerRadius = 4/2
        keyLine.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(keyLine)
        keyLine.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        keyLine.bottomAnchor.constraint(equalTo: mainContainer.topAnchor, constant: -6).isActive = true
        keyLine.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 34)).isActive = true
        keyLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        keyLine.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        navTitleLabel.text = forexSignal.order?.symbol
        navTitleLabel.textAlignment = .center
        navTitleLabel.textColor = varBlackColor
        navTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 19))
        navTitleLabel.numberOfLines = 0
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(navTitleLabel)
        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
                        
        swipeView.delegate = self
        swipeView.swipeLabel.text = "Cancel Pending Order"
        //swipeView.alpha = 0
        swipeView.backgroundColor = .clear
        swipeView.layer.cornerRadius = .createAspectRatio(value: 56)/2
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(swipeView)
        swipeView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        swipeView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 32)).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -.createAspectRatio(value: 75)).isActive = true
        swipeView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
                
        //
        
        bulletZero.backgroundColor = varBlackColor.withAlphaComponent(0.75)
        bulletZero.layer.cornerRadius = .createAspectRatio(value: 4)/2
        bulletZero.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(bulletZero)
        bulletZero.leadingAnchor.constraint(equalTo: swipeView.leadingAnchor, constant: .createAspectRatio(value: 0)).isActive = true
        bulletZero.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 34)).isActive = true
        bulletZero.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        bulletZero.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        
        let legalLabelZeroText = disclaimerZero//"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        legalLabelZero.setupLineHeight(myText: legalLabelZeroText, myLineSpacing: .createAspectRatio(value: 6))
        legalLabelZero.textColor = varBlackColor.withAlphaComponent(0.75)
        legalLabelZero.numberOfLines = 0
        legalLabelZero.font = .poppinsRegular(ofSize: .createAspectRatio(value: 12))
        legalLabelZero.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(legalLabelZero)
        legalLabelZero.leadingAnchor.constraint(equalTo: bulletZero.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        legalLabelZero.topAnchor.constraint(equalTo: bulletZero.topAnchor, constant: -.createAspectRatio(value: 4)).isActive = true
        legalLabelZero.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -view.frame.width * 0.1).isActive = true
        
        bulletOne.backgroundColor = varBlackColor.withAlphaComponent(0.75)
        bulletOne.layer.cornerRadius = .createAspectRatio(value: 4)/2
        bulletOne.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(bulletOne)
        bulletOne.leadingAnchor.constraint(equalTo: swipeView.leadingAnchor, constant: .createAspectRatio(value: 0)).isActive = true
        bulletOne.topAnchor.constraint(equalTo: legalLabelZero.bottomAnchor, constant: .createAspectRatio(value: 25)).isActive = true
        bulletOne.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        bulletOne.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        
        let legalLabelOneText = disclaimerOne
        legalLabelOne.setupLineHeight(myText: legalLabelOneText, myLineSpacing: .createAspectRatio(value: 6))
        legalLabelOne.textColor = varBlackColor.withAlphaComponent(0.75)
        legalLabelOne.numberOfLines = 0
        legalLabelOne.font = .poppinsRegular(ofSize: .createAspectRatio(value: 12))
        legalLabelOne.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(legalLabelOne)
        legalLabelOne.leadingAnchor.constraint(equalTo: bulletOne.trailingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        legalLabelOne.topAnchor.constraint(equalTo: bulletOne.topAnchor, constant: -.createAspectRatio(value: 4)).isActive = true
        legalLabelOne.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -view.frame.width * 0.1).isActive = true
        
        //
        
        let checkAnimation = LottieAnimation.named("gradientCheck")
        checkmarkOneLottie.isUserInteractionEnabled = false
        checkmarkOneLottie.alpha = 0
        checkmarkOneLottie.animation = checkAnimation
        checkmarkOneLottie.contentMode = .scaleAspectFill
        checkmarkOneLottie.loopMode = .playOnce
        checkmarkOneLottie.animationSpeed = 0.75
        checkmarkOneLottie.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(checkmarkOneLottie)
        checkmarkOneLottie.centerYAnchor.constraint(equalTo: mainContainer.centerYAnchor, constant: -50).isActive = true
        checkmarkOneLottie.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: 0).isActive = true
        checkmarkOneLottie.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 100)).isActive = true
        checkmarkOneLottie.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 100)).isActive = true
        //checkmarkOneLottie.play()
        
        orderPlaced.alpha = 0
        orderPlaced.text = "Order Canceled!"
        orderPlaced.textColor = varBlackColor
        orderPlaced.textAlignment = .center
        orderPlaced.font = .poppinsMedium(ofSize: .createAspectRatio(value: 25))
        orderPlaced.numberOfLines = 0
        orderPlaced.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(orderPlaced)
        orderPlaced.topAnchor.constraint(equalTo: checkmarkOneLottie.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        orderPlaced.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        
    }
    
}
