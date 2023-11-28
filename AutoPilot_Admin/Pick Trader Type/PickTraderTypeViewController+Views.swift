//
//  PickTraderTypeViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 11/27/23.
//

import Foundation
import UIKit
import Lottie

extension PickTraderTypeViewController {
    
    func setupColors() {
        if isDarkMode.bool(forKey: "isDarkMode") {
            mainContainer.backgroundColor = .darkModeBackground
            keyLine.backgroundColor = .darkModeBackground
            textColor = .white
            navTitleLabel.textColor = .white
            dateLabel.textColor = .white.withAlphaComponent(0.5)
            
            recentSignalsOption.optionTitleLabel.textColor = .white
            recentSignalsOption.optionDetailLabel.textColor = .white.withAlphaComponent(0.5)
            
            longTermSignalsOption.optionTitleLabel.textColor = .white
            longTermSignalsOption.optionDetailLabel.textColor = .white.withAlphaComponent(0.5)
            
        } else {
            mainContainer.backgroundColor = .white
            keyLine.backgroundColor = .white
            textColor = .black
            navTitleLabel.textColor = .black
            dateLabel.textColor = .black.withAlphaComponent(0.5)
            
            recentSignalsOption.optionTitleLabel.textColor = .newBlack
            recentSignalsOption.optionDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
            
            longTermSignalsOption.optionTitleLabel.textColor = .newBlack
            longTermSignalsOption.optionDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
                        
        }
    }
    
    func setupViews() {
        
        recentSignalsOption.optionDetailLabel.textColor = UIColor.black.withAlphaComponent(0.6)
            
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
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 307)).isActive = true //376 //445
        mainContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        keyLine.layer.cornerRadius = .createAspectRatio(value: 4)/2
        keyLine.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(keyLine)
        keyLine.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        keyLine.bottomAnchor.constraint(equalTo: mainContainer.topAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        keyLine.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 34)).isActive = true
        keyLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        keyLine.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
    
        
        navTitleLabel.text = "New Team Member"
        navTitleLabel.textAlignment = .center
        navTitleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 19))
        navTitleLabel.numberOfLines = 0
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(navTitleLabel)
        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 18).isActive = true
        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
                
        dateLabel.text = "Choose an option below"
        dateLabel.textAlignment = .center
        dateLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 13))
        dateLabel.numberOfLines = 0
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 5)).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        
        recentSignalsOption.iconImageView.image = UIImage(named: "clockGrad")
        recentSignalsOption.optionTitleLabel.text = "New Trader"
        recentSignalsOption.optionButton.addTarget(self, action: #selector(newFollowupReminderTapped), for: .touchUpInside)
        recentSignalsOption.optionDetailLabel.text = "Add a trader to the team"
        recentSignalsOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(recentSignalsOption)
        recentSignalsOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        recentSignalsOption.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 70)).isActive = true
        recentSignalsOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        recentSignalsOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
        
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "arrowRight")?.imageFlippedForRightToLeftLayoutDirection()
        arrowImageView.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.5) : .newBlack.withAlphaComponent(0.5))
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        recentSignalsOption.addSubview(arrowImageView)
        arrowImageView.trailingAnchor.constraint(equalTo: recentSignalsOption.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: recentSignalsOption.centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        
        longTermSignalsOption.optionButton.addTarget(self, action: #selector(didTapMarketingCenter), for: .touchUpInside)
        longTermSignalsOption.iconImageView.image = UIImage(named: "calGrad")
        longTermSignalsOption.optionTitleLabel.text = "New Admin"
        longTermSignalsOption.optionDetailLabel.text = "Add a admin to the team"
        longTermSignalsOption.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(longTermSignalsOption)
        longTermSignalsOption.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        longTermSignalsOption.topAnchor.constraint(equalTo: recentSignalsOption.bottomAnchor).isActive = true
        longTermSignalsOption.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        longTermSignalsOption.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 74)).isActive = true
        
        let arrowImageViewTwo = UIImageView()
        arrowImageViewTwo.image = UIImage(named: "arrowRight")?.imageFlippedForRightToLeftLayoutDirection()
        arrowImageViewTwo.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white.withAlphaComponent(0.5) : .newBlack.withAlphaComponent(0.5))
        arrowImageViewTwo.contentMode = .scaleAspectFill
        arrowImageViewTwo.translatesAutoresizingMaskIntoConstraints = false
        longTermSignalsOption.addSubview(arrowImageViewTwo)
        arrowImageViewTwo.trailingAnchor.constraint(equalTo: longTermSignalsOption.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        arrowImageViewTwo.centerYAnchor.constraint(equalTo: longTermSignalsOption.centerYAnchor).isActive = true
        arrowImageViewTwo.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        arrowImageViewTwo.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
                
    }
    
}


