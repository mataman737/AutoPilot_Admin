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
        let opacityTapped = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        opacityLayer.addGestureRecognizer(opacityTapped)
        opacityLayer.isUserInteractionEnabled = true
        opacityLayer.backgroundColor = .black
        opacityLayer.alpha = 0
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
        
        cardContainer.backgroundColor = .white
        cardContainer.layer.cornerRadius = .createAspectRatio(value: 12)
        cardContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardContainer.layer.masksToBounds = true
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardContainer)
        cardContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cardContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cardContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        cardContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 530)).isActive = true
        cardContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        titleLabel.text = "Add New Trader"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 18))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true
        
        downArrow.image = UIImage(named: "newDownArrow")
        downArrow.setImageColor(color: .black)
        downArrow.contentMode = .scaleAspectFill
        downArrow.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(downArrow)
        downArrow.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        downArrow.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 0).isActive = true
        downArrow.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        downArrow.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        downButton.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
        downButton.backgroundColor = .clear
        downButton.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(downButton)
        downButton.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 0).isActive = true
        downButton.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 0).isActive = true
        downButton.trailingAnchor.constraint(equalTo: downArrow.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        downButton.bottomAnchor.constraint(equalTo: downArrow.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        
        //
                
        accessCodeTextContainer.backgroundColor = .clear
        accessCodeTextContainer.layer.borderWidth = 1
        accessCodeTextContainer.layer.borderColor = UIColor.black.cgColor
        accessCodeTextContainer.layer.cornerRadius = .createAspectRatio(value: 10)
        accessCodeTextContainer.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(accessCodeTextContainer)
        accessCodeTextContainer.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        accessCodeTextContainer.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        accessCodeTextContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .createAspectRatio(value: 36)).isActive = true
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
        placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font: UIFont.sofiaProMedium(ofSize: 18)])
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
        
//        let accessoryContainer = UIView()
//        accessoryContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: .createAspectRatio(value: 99))
//        accessoryContainer.backgroundColor = .clear
        
        nextButton.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 4, height: 4), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        nextButton.addTarget(self, action: #selector(inviteMemberToTeam), for: .touchUpInside)
        nextButton.purpleBG.backgroundColor = .swBlue
        nextButton.continueLabel.text = "Send Invite"
        nextButton.continueLabel.textColor = .white
        nextButton.confirmLabel.text = "Confirm"
        nextButton.confirmLabel.textColor = .white
        nextButton.purpleBG.image = UIImage(named: "")
        nextButton.backgroundColor = .white
        nextButton.layer.cornerRadius = .createAspectRatio(value: 55)/2
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(nextButton)
        nextButton.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        nextButton.topAnchor.constraint(equalTo: accessCodeTextContainer.bottomAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 55)).isActive = true
        
//        phoneNumberTextField.inputAccessoryView = accessoryContainer
    }
}
