//
//  AddTraderViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 10/3/23.
//

import Foundation
import UIKit

extension AddTraderViewController {
    func setupViews() {
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
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 530)).isActive = true
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
        
        //
                
        accessCodeTextContainer.backgroundColor = .clear
        accessCodeTextContainer.layer.borderWidth = 1
        accessCodeTextContainer.layer.borderColor = UIColor.black.cgColor
        accessCodeTextContainer.layer.cornerRadius = .createAspectRatio(value: 10)
        accessCodeTextContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(accessCodeTextContainer)
        accessCodeTextContainer.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        accessCodeTextContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        accessCodeTextContainer.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 36)).isActive = true
        accessCodeTextContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 58)).isActive = true
        
        phoneNumberTextField.becomeFirstResponder()
        phoneNumberTextField.tag = 1
        phoneNumberTextField.setFlag(key: .US)
        phoneNumberTextField.delegate = self
        phoneNumberTextField.delegateTwo = self
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.autocorrectionType = .no
        phoneNumberTextField.textColor = .black
        phoneNumberTextField.tintColor = .black
        phoneNumberTextField.returnKeyType = .next
        var placeHolder = NSMutableAttributedString()
        let Name  = "Phone Number"
        placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font: UIFont.poppinsMedium(ofSize: 18)])
        placeHolder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range:NSRange(location:0,length:Name.count))
        phoneNumberTextField.attributedPlaceholder = placeHolder
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        accessCodeTextContainer.addSubview(phoneNumberTextField)
        phoneNumberTextField.leadingAnchor.constraint(equalTo: accessCodeTextContainer.leadingAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        phoneNumberTextField.centerYAnchor.constraint(equalTo: accessCodeTextContainer.centerYAnchor, constant: 0).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: accessCodeTextContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        
        spinner.isHidden = true
        spinner.alpha = 0
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        accessCodeTextContainer.addSubview(spinner)
        spinner.trailingAnchor.constraint(equalTo: accessCodeTextContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        spinner.centerYAnchor.constraint(equalTo: accessCodeTextContainer.centerYAnchor).isActive = true
        
        nextButton.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 4, height: 4), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        nextButton.addTarget(self, action: #selector(inviteMemberToTeam), for: .touchUpInside)
        nextButton.purpleBG.backgroundColor = .black
        nextButton.continueLabel.text = "Send Invite"
        nextButton.continueLabel.textColor = .white
        nextButton.confirmLabel.text = "Confirm"
        nextButton.confirmLabel.textColor = .white
        nextButton.purpleBG.image = UIImage(named: "")
        nextButton.backgroundColor = .white
        //nextButton.layer.cornerRadius = .createAspectRatio(value: 48)/2
        nextButton.purpleBG.layer.masksToBounds = true
        nextButton.layer.masksToBounds = true
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(nextButton)
        nextButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        nextButton.topAnchor.constraint(equalTo: accessCodeTextContainer.bottomAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 48)).isActive = true
        
    }
}
