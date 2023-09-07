//
//  SetupAccountViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import Foundation
import UIKit

extension SetupAccountViewController {
    
    func setupViews() {
        self.view.backgroundColor = .white
        
        navView.backgroundColor = .white
        navView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 90)).isActive = true
        
        xImageView.image = UIImage(named: "xImage")
        xImageView.contentMode = .scaleAspectFill
        xImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(xImageView)
        xImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        xImageView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -.createAspectRatio(value: 12)).isActive = true
        xImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        xImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        dismissButton.backgroundColor = .clear
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(dismissButton)
        dismissButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: xImageView.trailingAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        
        //Progress Views
        setupProgressView(progressView: progressOne)
        progressOne.centerXAnchor.constraint(equalTo: navView.centerXAnchor).isActive = true
        setupProgressView(progressView: progressTwo)
        progressTwo.leadingAnchor.constraint(equalTo: progressOne.trailingAnchor, constant: .createAspectRatio(value: 4)).isActive = true
        setupProgressView(progressView: progressZero)
        progressZero.trailingAnchor.constraint(equalTo: progressOne.leadingAnchor, constant: -.createAspectRatio(value: 4)).isActive = true
        
        mainScrollView.isScrollEnabled = false
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.backgroundColor = .clear
        mainScrollView.contentSize = CGSize(width: view.frame.width * 2, height: .createAspectRatio(value: 137))
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainScrollView)
        mainScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainScrollView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
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
        phoneNumberContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 400)).isActive = true
        phoneNumberContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        codeContainer.backgroundColor = .clear
        codeContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(codeContainer)
        codeContainer.leadingAnchor.constraint(equalTo: phoneNumberContainer.trailingAnchor).isActive = true
        codeContainer.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        codeContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 147)).isActive = true
        codeContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        //
        
        let addPhotoNameLabel = UILabel()
        addPhotoNameLabel.text = "Add photo and display name"
        addPhotoNameLabel.textAlignment = .left
        addPhotoNameLabel.textColor = .black
        addPhotoNameLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 23))
        addPhotoNameLabel.numberOfLines = 0
        addPhotoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userInfoContainer.addSubview(addPhotoNameLabel)
        addPhotoNameLabel.leadingAnchor.constraint(equalTo: userInfoContainer.leadingAnchor, constant: .createAspectRatio(value: 26)).isActive = true
        addPhotoNameLabel.topAnchor.constraint(equalTo: userInfoContainer.topAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        
        let profileImageTapped = UITapGestureRecognizer(target: self, action: #selector(replacePhotoClicked))
        profilePhotoImageView.addGestureRecognizer(profileImageTapped)
        profilePhotoImageView.isUserInteractionEnabled = true
        profilePhotoImageView.image = UIImage(named: "enigmaUserPH")
        profilePhotoImageView.backgroundColor = .clear
        profilePhotoImageView.contentMode = .scaleAspectFill
        profilePhotoImageView.layer.cornerRadius = .createAspectRatio(value: 133)/2
        profilePhotoImageView.layer.masksToBounds = true
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        userInfoContainer.addSubview(profilePhotoImageView)
        profilePhotoImageView.topAnchor.constraint(equalTo: addPhotoNameLabel.bottomAnchor, constant: .createAspectRatio(value: 41)).isActive = true
        profilePhotoImageView.centerXAnchor.constraint(equalTo: userInfoContainer.centerXAnchor).isActive = true
        profilePhotoImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 133)).isActive = true
        profilePhotoImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 133)).isActive = true
        
        userNameContainer.backgroundColor = .clear
        userNameContainer.layer.cornerRadius = 8
        userNameContainer.layer.masksToBounds = true
        userNameContainer.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        userNameContainer.layer.borderWidth = 1
        userNameContainer.translatesAutoresizingMaskIntoConstraints = false
        userInfoContainer.addSubview(userNameContainer)
        userNameContainer.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        userNameContainer.leadingAnchor.constraint(equalTo: userInfoContainer.leadingAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        userNameContainer.trailingAnchor.constraint(equalTo: userInfoContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        userNameContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 48)).isActive = true
        
        usernameTextfield.becomeFirstResponder()
        usernameTextfield.tag = 1
        usernameTextfield.delegate = self
        usernameTextfield.keyboardType = .default
        usernameTextfield.autocorrectionType = .no
        usernameTextfield.textColor = .black
        usernameTextfield.tintColor = .swBlue
        usernameTextfield.returnKeyType = .next
        usernameTextfield.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 18))
        var namePlaceHolder = NSMutableAttributedString()
        let userName  = "Display Name"
        namePlaceHolder = NSMutableAttributedString(string:userName, attributes: [NSAttributedString.Key.font: UIFont.sofiaProMedium(ofSize: 18)])
        namePlaceHolder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black.withAlphaComponent(0.5), range:NSRange(location:0,length:userName.count))
        usernameTextfield.attributedPlaceholder = namePlaceHolder
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        userNameContainer.addSubview(usernameTextfield)
        usernameTextfield.leadingAnchor.constraint(equalTo: userNameContainer.leadingAnchor, constant: .createAspectRatio(value: 13)).isActive = true
        usernameTextfield.trailingAnchor.constraint(equalTo: userNameContainer.trailingAnchor, constant: -.createAspectRatio(value: 13)).isActive = true
        usernameTextfield.centerYAnchor.constraint(equalTo: userNameContainer.centerYAnchor).isActive = true
        
        //PHONE NUMBER
        
        let phoneLabel = UILabel()
        phoneLabel.text = "Enter your phone number"
        phoneLabel.textAlignment = .left
        phoneLabel.textColor = .black
        phoneLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 23))
        phoneLabel.numberOfLines = 0
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberContainer.addSubview(phoneLabel)
        phoneLabel.leadingAnchor.constraint(equalTo: phoneNumberContainer.leadingAnchor, constant: .createAspectRatio(value: 26)).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: phoneNumberContainer.topAnchor, constant: .createAspectRatio(value: 20)).isActive = true
                
        emailContainerView.backgroundColor = .white
        emailContainerView.layer.cornerRadius = 8
        emailContainerView.layer.masksToBounds = true
        emailContainerView.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        emailContainerView.layer.borderWidth = 1
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberContainer.addSubview(emailContainerView)
        emailContainerView.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: .createAspectRatio(value: 41)).isActive = true
        emailContainerView.leadingAnchor.constraint(equalTo: phoneNumberContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        emailContainerView.trailingAnchor.constraint(equalTo: phoneNumberContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        emailContainerView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 48)).isActive = true
                
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
        placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font: UIFont.sofiaProMedium(ofSize: 18)])
        placeHolder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range:NSRange(location:0,length:Name.count))
        phoneNumberTextField.attributedPlaceholder = placeHolder
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.addSubview(phoneNumberTextField)
        phoneNumberTextField.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor, constant: .createAspectRatio(value: 13)).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor, constant: -.createAspectRatio(value: 13)).isActive = true
        phoneNumberTextField.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor).isActive = true
        
        let accessoryContainer = UIView()
        accessoryContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: .createAspectRatio(value: 99))
        accessoryContainer.backgroundColor = .clear
        
        nextButton.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 4, height: 4), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        nextButton.purpleBG.backgroundColor = .swBlue
        nextButton.continueLabel.text = "Next"
        nextButton.continueLabel.textColor = .white
        nextButton.confirmLabel.text = "Confirm"
        nextButton.confirmLabel.textColor = .white
        nextButton.purpleBG.image = UIImage(named: "")
        nextButton.backgroundColor = .white
        nextButton.layer.cornerRadius = .createAspectRatio(value: 55)/2
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        accessoryContainer.addSubview(nextButton)
        nextButton.leadingAnchor.constraint(equalTo: accessoryContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: accessoryContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: accessoryContainer.centerYAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 55)).isActive = true
        
        phoneNumberTextField.inputAccessoryView = accessoryContainer
        usernameTextfield.inputAccessoryView = accessoryContainer
        codeTextField.inputAccessoryView = accessoryContainer
        
        //OTC

        var codeLabel = UILabel()
        codeLabel.text = "What is the access code?"
        codeLabel.textAlignment = .left
        codeLabel.textColor = .black
        codeLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 23))
        codeLabel.numberOfLines = 0
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeContainer.addSubview(codeLabel)
        codeLabel.leadingAnchor.constraint(equalTo: codeContainer.leadingAnchor, constant: .createAspectRatio(value: 26)).isActive = true
        codeLabel.topAnchor.constraint(equalTo: codeContainer.topAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        
        codeTextField.configure()
        codeTextField.didEnterLastDigit = { [weak self] code in
            print(code)
        }
        codeTextField.delegate = self
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        codeContainer.addSubview(codeTextField)
        codeTextField.leadingAnchor.constraint(equalTo: codeContainer.leadingAnchor, constant: .createAspectRatio(value: 27)).isActive = true
        codeTextField.trailingAnchor.constraint(equalTo: codeContainer.trailingAnchor, constant: -.createAspectRatio(value: 27)).isActive = true
        codeTextField.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: .createAspectRatio(value: 41)).isActive = true
        //codeTextField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 87)).isActive = true
        codeTextField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 70)).isActive = true
        
        transitionView.isHidden = true
        transitionView.alpha = 0
        transitionView.backgroundColor = .swBlue
        transitionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(transitionView)
        transitionView.fillSuperview()
        
    }
    
    func setupProgressView(progressView: SignupProgressView) {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(progressView)
        progressView.centerYAnchor.constraint(equalTo: xImageView.centerYAnchor).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 6)).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 50)).isActive = true
    }
}

