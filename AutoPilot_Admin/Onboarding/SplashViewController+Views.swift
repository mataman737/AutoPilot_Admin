//
//  SplashViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import Foundation
import UIKit

extension SplashViewController {
    
    func setupViews() {
        self.view.backgroundColor = .white
                
        joinLabel.text = "Login"
        joinLabel.textAlignment = .left
        joinLabel.font = .sofiaProMedium(ofSize: 35)
        joinLabel.textColor = .black
        joinLabel.numberOfLines = 0
        joinLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(joinLabel)
        joinLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18).isActive = true
        joinLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        
        joinDescriptionLabel.alpha = 1.0
        let joinDescriptionLabelText = "Please enter a username\nand add a profile photo"//"Enter your phone number and we’ll\nsend you a verification code"
        joinDescriptionLabel.setupLineHeight(myText: joinDescriptionLabelText, myLineSpacing: .createAspectRatio(value: 4))
        joinDescriptionLabel.textAlignment = .left
        joinDescriptionLabel.font = .sofiaProRegular(ofSize: 15)
        joinDescriptionLabel.textColor = .black
        joinDescriptionLabel.numberOfLines = 0
        joinDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(joinDescriptionLabel)
        joinDescriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        joinDescriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        joinDescriptionLabel.topAnchor.constraint(equalTo: joinLabel.bottomAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        
        mainScrollView.isScrollEnabled = false
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.backgroundColor = .clear
        mainScrollView.contentSize = CGSize(width: view.frame.width * 2, height: .createAspectRatio(value: 137))
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainScrollView)
        mainScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainScrollView.topAnchor.constraint(equalTo: joinDescriptionLabel.bottomAnchor, constant: .createAspectRatio(value: 47)).isActive = true
        mainScrollView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 400)).isActive = true
        
        userInfoContainer.backgroundColor = .clear
        userInfoContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(userInfoContainer)
        userInfoContainer.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true
        userInfoContainer.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        userInfoContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 500)).isActive = true
        userInfoContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        phoneNumberContainer.backgroundColor = .clear
        phoneNumberContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(phoneNumberContainer)
        phoneNumberContainer.leadingAnchor.constraint(equalTo: userInfoContainer.trailingAnchor).isActive = true
        phoneNumberContainer.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        phoneNumberContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 147)).isActive = true
        phoneNumberContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        codeContainer.backgroundColor = .clear
        codeContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(codeContainer)
        codeContainer.leadingAnchor.constraint(equalTo: phoneNumberContainer.trailingAnchor).isActive = true
        codeContainer.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        codeContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 147)).isActive = true
        codeContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        //
        
        let profileImageTapped = UITapGestureRecognizer(target: self, action: #selector(replacePhotoClicked))
        profilePhotoImageView.addGestureRecognizer(profileImageTapped)
        profilePhotoImageView.isUserInteractionEnabled = true
        profilePhotoImageView.image = UIImage(named: "avatarph")
        profilePhotoImageView.backgroundColor = .clear
        profilePhotoImageView.contentMode = .scaleAspectFill
        profilePhotoImageView.layer.cornerRadius = .createAspectRatio(value: 150)/2
        profilePhotoImageView.layer.masksToBounds = true
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userInfoContainer.addSubview(profilePhotoImageView)
        profilePhotoImageView.topAnchor.constraint(equalTo: userInfoContainer.topAnchor, constant: 0).isActive = true
        profilePhotoImageView.centerXAnchor.constraint(equalTo: userInfoContainer.centerXAnchor).isActive = true
        profilePhotoImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 150)).isActive = true
        profilePhotoImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 150)).isActive = true
        
        userNameContainer.backgroundColor = UIColor.black.withAlphaComponent(0.31)
        userNameContainer.layer.cornerRadius = 8
        userNameContainer.layer.masksToBounds = true
        userNameContainer.layer.borderColor = UIColor.black.withAlphaComponent(0.7).cgColor
        userNameContainer.layer.borderWidth = 1
        userNameContainer.translatesAutoresizingMaskIntoConstraints = false
        userInfoContainer.addSubview(userNameContainer)
        userNameContainer.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        userNameContainer.leadingAnchor.constraint(equalTo: userInfoContainer.leadingAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        userNameContainer.trailingAnchor.constraint(equalTo: userInfoContainer.trailingAnchor, constant: -15).isActive = true
        userNameContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 53)).isActive = true
        
        usernameTextfield.becomeFirstResponder()
        usernameTextfield.tag = 1
        usernameTextfield.delegate = self
        usernameTextfield.keyboardType = .default
        usernameTextfield.autocorrectionType = .no
        usernameTextfield.textColor = .black
        usernameTextfield.tintColor = .black
        usernameTextfield.returnKeyType = .next
        var namePlaceHolder = NSMutableAttributedString()
        let userName  = "Display Name"
        namePlaceHolder = NSMutableAttributedString(string:userName, attributes: [NSAttributedString.Key.font: UIFont.sofiaProMedium(ofSize: 16)])
        namePlaceHolder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range:NSRange(location:0,length:userName.count))
        usernameTextfield.attributedPlaceholder = namePlaceHolder
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        userNameContainer.addSubview(usernameTextfield)
        usernameTextfield.leadingAnchor.constraint(equalTo: userNameContainer.leadingAnchor, constant: 13).isActive = true
        usernameTextfield.trailingAnchor.constraint(equalTo: userNameContainer.trailingAnchor, constant: -13).isActive = true
        usernameTextfield.centerYAnchor.constraint(equalTo: userNameContainer.centerYAnchor).isActive = true
        
        //EMAIL
                
        emailContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.31)
        emailContainerView.layer.cornerRadius = 8
        emailContainerView.layer.masksToBounds = true
        emailContainerView.layer.borderColor = UIColor.black.withAlphaComponent(0.7).cgColor
        emailContainerView.layer.borderWidth = 1
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberContainer.addSubview(emailContainerView)
        emailContainerView.centerYAnchor.constraint(equalTo: phoneNumberContainer.centerYAnchor, constant: 0).isActive = true
        emailContainerView.leadingAnchor.constraint(equalTo: phoneNumberContainer.leadingAnchor, constant: 15).isActive = true
        emailContainerView.trailingAnchor.constraint(equalTo: phoneNumberContainer.trailingAnchor, constant: -15).isActive = true
        emailContainerView.heightAnchor.constraint(equalToConstant: 53).isActive = true
                
        phoneNumberTextField.tag = 1
        phoneNumberTextField.setFlag(key: .US)
        phoneNumberTextField.delegate = self
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.autocorrectionType = .no
        phoneNumberTextField.textColor = .black
        phoneNumberTextField.tintColor = .black
        phoneNumberTextField.returnKeyType = .next
        var placeHolder = NSMutableAttributedString()
        let Name  = "Phone Number"
        placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font: UIFont.sofiaProMedium(ofSize: 16)])
        placeHolder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range:NSRange(location:0,length:Name.count))
        phoneNumberTextField.attributedPlaceholder = placeHolder
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.addSubview(phoneNumberTextField)
        phoneNumberTextField.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor, constant: 13).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor, constant: -13).isActive = true
        phoneNumberTextField.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor).isActive = true
        
        let accessoryView = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        accessoryView.backgroundColor = .clear
        accessoryView.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        phoneNumberTextField.inputAccessoryView = accessoryView
        usernameTextfield.inputAccessoryView = accessoryView
        codeTextField.inputAccessoryView = accessoryView
        
        let nextArrowImageView = UIImageView()
        nextArrowImageView.image = UIImage(named: "signUpArrow_White")
        nextArrowImageView.setImageColor(color: .black)
        nextArrowImageView.contentMode = .scaleAspectFill
        nextArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        accessoryView.addSubview(nextArrowImageView)
        nextArrowImageView.trailingAnchor.constraint(equalTo: accessoryView.trailingAnchor, constant: -19).isActive = true
        nextArrowImageView.bottomAnchor.constraint(equalTo: accessoryView.bottomAnchor, constant: -19).isActive = true
        nextArrowImageView.heightAnchor.constraint(equalToConstant: 15.26).isActive = true
        nextArrowImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        
        let nextLabel = UILabel()
        nextLabel.text = "Next"
        nextLabel.textColor = .black
        nextLabel.font = .sofiaProMedium(ofSize: 17)
        nextLabel.textAlignment = .right
        nextLabel.numberOfLines = 0
        nextLabel.translatesAutoresizingMaskIntoConstraints = false
        accessoryView.addSubview(nextLabel)
        nextLabel.bottomAnchor.constraint(equalTo: accessoryView.bottomAnchor, constant: -16).isActive = true
        nextLabel.trailingAnchor.constraint(equalTo: nextArrowImageView.leadingAnchor, constant: -6).isActive = true
        
        //PASSWORD
        
        passwordContainer.isUserInteractionEnabled = true
        passwordContainer.backgroundColor = .clear//UIColor.black.withAlphaComponent(0.31)
        passwordContainer.layer.cornerRadius = 8
        passwordContainer.layer.masksToBounds = true
        //passwordContainer.layer.borderColor = UIColor.black.withAlphaComponent(0.7).cgColor
        //passwordContainer.layer.borderWidth = 1
        passwordContainer.translatesAutoresizingMaskIntoConstraints = false
        codeContainer.addSubview(passwordContainer)
        passwordContainer.centerYAnchor.constraint(equalTo: codeContainer.centerYAnchor, constant: 0).isActive = true
        passwordContainer.leadingAnchor.constraint(equalTo: codeContainer.leadingAnchor, constant: 15).isActive = true
        passwordContainer.trailingAnchor.constraint(equalTo: codeContainer.trailingAnchor, constant: -15).isActive = true
        passwordContainer.heightAnchor.constraint(equalToConstant: 87).isActive = true
        
        codeTextField.configure()
        codeTextField.didEnterLastDigit = { [weak self] code in
            print(code)
        }
        codeTextField.delegate = self
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.addSubview(codeTextField)
        codeTextField.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 27).isActive = true
        codeTextField.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -27).isActive = true
        codeTextField.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor, constant: 0).isActive = true
        codeTextField.heightAnchor.constraint(equalToConstant: 87).isActive = true
        
        //Dismiss
                   
        dismissImageView.isHidden = true
        dismissImageView.image = UIImage(named: "xImage")
        dismissImageView.contentMode = .scaleAspectFill
        dismissImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dismissImageView)
        dismissImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18).isActive = true
        dismissImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        dismissImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dismissImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
                        
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        dismissButton.backgroundColor = .clear
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dismissButton)
        dismissButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: joinLabel.topAnchor).isActive = true
        
        transitionView.isHidden = true
        transitionView.backgroundColor = .black
        transitionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(transitionView)
        transitionView.fillSuperview()
        transitionView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
    }
}

