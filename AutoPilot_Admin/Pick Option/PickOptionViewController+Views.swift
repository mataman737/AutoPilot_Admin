//
//  PickOptionViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import Foundation
import UIKit

extension PickOptionViewController {
    
    func setupLaunchTransition() {
        purpGradientBG.alpha = 0
        purpGradientBG.image = UIImage(named: "pinkOrangeGradientBG")
        purpGradientBG.contentMode = .scaleAspectFill
        self.view.addSubview(purpGradientBG)
        purpGradientBG.fillSuperview()
    }
    
    func setupViews() {
        
        if isDarkMode {
            cardContainer.backgroundColor = .themeGray
            textColor = .white
        } else {
            cardContainer.backgroundColor = .white
            textColor = .black
        }
        
        opacityLayer.isUserInteractionEnabled = true
        opacityLayer.backgroundColor = .black
        opacityLayer.alpha = 0
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
        
        //cardContainer.backgroundColor = .themeGray
        cardContainer.layer.cornerRadius = 24
        cardContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardContainer.layer.masksToBounds = true
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardContainer)
        cardContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cardContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cardContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        cardHeight = cardContainer.heightAnchor.constraint(equalToConstant: 385)
        cardHeight.isActive = true
        cardContainer.transform = CGAffineTransform(translationX: 0, y: 385)
        
        //view.frame.height - 57
        
        
        //titleLabel.text = "Preferred Language"
        titleLabel.textAlignment = .center
        titleLabel.textColor = textColor
        titleLabel.font = .sofiaProMedium(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true
                
        downArrow.image = UIImage(named: "newDownArrow") //downArrow
        downArrow.setImageColor(color: textColor)
        downArrow.contentMode = .scaleAspectFill
        downArrow.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(downArrow)
        downArrow.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 22).isActive = true
        downArrow.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 14).isActive = true
        downArrow.heightAnchor.constraint(equalToConstant: 20).isActive = true
        downArrow.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        downButton.backgroundColor = .clear
        downButton.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(downButton)
        downButton.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 0).isActive = true
        downButton.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 0).isActive = true
        downButton.trailingAnchor.constraint(equalTo: downArrow.trailingAnchor, constant: 10).isActive = true
        downButton.bottomAnchor.constraint(equalTo: downArrow.bottomAnchor, constant: 10).isActive = true
                
        shareURLButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
        shareURLButton.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 2, height: 2), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        //shareURLButton.continueLabel.text = "Update Language"
        shareURLButton.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(shareURLButton)
        shareURLButton.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -25).isActive = true
        shareURLButton.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 25).isActive = true
        shareURLButton.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: -35).isActive = true
        shareURLButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        //
                
        timePickerView.delegate = self
        timePickerView.tintColor = .white
        timePickerView.dataSource = self
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(timePickerView)
        timePickerView.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor).isActive = true
        timePickerView.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor).isActive = true
        timePickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        timePickerView.heightAnchor.constraint(equalToConstant: 215).isActive = true
         
                
    }
}
