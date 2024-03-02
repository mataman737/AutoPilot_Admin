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
            textColor = .white
        } else {
            textColor = .black
        }

        
        opacityLayer.isUserInteractionEnabled = true
        opacityLayer.backgroundColor = .black
        opacityLayer.alpha = 0
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
        
        mainScrollView.tag = 1
        mainScrollView.delegate = self
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.backgroundColor = .clear
        mainScrollView.contentInsetAdjustmentBehavior = .never
        mainScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.1)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainScrollView)
        mainScrollView.fillSuperview()
        
        let opacityTapped = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        wrapper.addGestureRecognizer(opacityTapped)
        wrapper.isUserInteractionEnabled = true
        wrapper.backgroundColor = .clear
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(wrapper)
        wrapper.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        wrapper.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true
        wrapper.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        wrapper.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
        
        mainContainer.backgroundColor = .white
        mainContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainContainer.layer.cornerRadius = .createAspectRatio(value: 15)
        mainContainer.layer.masksToBounds = true
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubview(mainContainer)
        mainContainer.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor).isActive = true
        mainContainer.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 385)).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: 0).isActive = true
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
                
        //shareURLButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
        //shareURLButton.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 2, height: 2), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        //shareURLButton.continueLabel.text = "Update Language"
        
        shareURLButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
        //shareURLButton.continueLabel.text = "Update Language"
        shareURLButton.continueLabel.textColor = .white//UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
        shareURLButton.continueLabel.font = .poppinsSemiBold(ofSize: .createAspectRatio(value: 13))
        shareURLButton.purpleBG.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)//.white
        shareURLButton.spinner.color = .white//UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
        shareURLButton.purpleBG.image = UIImage(named: "")
        shareURLButton.purpleBG.layer.cornerRadius = .createAspectRatio(value: 44)/2
        shareURLButton.setTitleColor(UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0), for: .normal)
        shareURLButton.layer.cornerRadius = .createAspectRatio(value: 44)/2
        shareURLButton.layer.masksToBounds = true
        shareURLButton.translatesAutoresizingMaskIntoConstraints = false
        
        shareURLButton.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(shareURLButton)
        shareURLButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 21)).isActive = true
        shareURLButton.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 21)).isActive = true
        shareURLButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -.createAspectRatio(value: 33)).isActive = true
        shareURLButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 44)).isActive = true
        
        //
                
        timePickerView.delegate = self
        timePickerView.tintColor = .white
        timePickerView.dataSource = self
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(timePickerView)
        timePickerView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor).isActive = true
        timePickerView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor).isActive = true
        timePickerView.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        timePickerView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 215)).isActive = true
         
                
    }
}
