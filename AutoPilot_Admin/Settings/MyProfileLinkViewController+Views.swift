//
//  MyProfileLinkViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import Foundation
import UIKit
import EFQRCode
import PWSwitch

extension MyProfileLinkViewController {
    
    func setupViews() {
        
        if isDarkMode {
            cardContainer.backgroundColor = .themeGray
            textColor = .white
        } else {
            cardContainer.backgroundColor = .white
            textColor = .newBlack
        }
        
        let opacityTapped = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        opacityLayer.addGestureRecognizer(opacityTapped)
        opacityLayer.isUserInteractionEnabled = true
        opacityLayer.backgroundColor = .newBlack
        opacityLayer.alpha = 0
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
                
        cardContainer.layer.cornerRadius = .createAspectRatio(value: 24)
        cardContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardContainer.layer.masksToBounds = true
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardContainer)
        cardContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cardContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cardContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        cardHeight = cardContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 385))
        cardHeight.isActive = true
        cardContainer.transform = CGAffineTransform(translationX: 0, y: .createAspectRatio(value: 385))
                
        titleLabel.text = "Share Your Site"
        titleLabel.textAlignment = .center
        titleLabel.textColor = textColor
        titleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true
        
        detailLabel.alpha = 0
        detailLabel.text = "Please enter tracking text\n(no spaces)"
        detailLabel.textAlignment = .center
        detailLabel.textColor = textColor.withAlphaComponent(0.5)
        detailLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 12))
        detailLabel.numberOfLines = 0
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(detailLabel)
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        detailLabel.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true
        
        downArrow.image = UIImage(named: "newDownArrow") //downArrow
        downArrow.setImageColor(color: textColor)
        downArrow.contentMode = .scaleAspectFill
        downArrow.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(downArrow)
        downArrow.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: .createAspectRatio(value: 22)).isActive = true
        downArrow.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: .createAspectRatio(value: 14)).isActive = true
        downArrow.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        downArrow.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        
        downButton.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
        downButton.backgroundColor = .clear
        downButton.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(downButton)
        self.view.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 0).isActive = true
        downButton.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 0).isActive = true
        downButton.trailingAnchor.constraint(equalTo: downArrow.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        downButton.bottomAnchor.constraint(equalTo: downArrow.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        
//        settingsImageView.image = UIImage(named: "more-horizontal") //downArrow
//        settingsImageView.setImageColor(color: textColor)
//        settingsImageView.contentMode = .scaleAspectFill
//        settingsImageView.translatesAutoresizingMaskIntoConstraints = false
//        cardContainer.addSubview(settingsImageView)
//        settingsImageView.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -22).isActive = true
//        settingsImageView.centerYAnchor.constraint(equalTo: downArrow.centerYAnchor, constant: 0).isActive = true
//        settingsImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        settingsImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
//
//        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
//        settingsButton.backgroundColor = .clear//.red.withAlphaComponent(0.5)
//        settingsButton.translatesAutoresizingMaskIntoConstraints = false
//        cardContainer.addSubview(settingsButton)
//        settingsButton.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: 0).isActive = true
//        settingsButton.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 0).isActive = true
//        settingsButton.leadingAnchor.constraint(equalTo: settingsImageView.leadingAnchor, constant: -10).isActive = true
//        settingsButton.bottomAnchor.constraint(equalTo: settingsImageView.bottomAnchor, constant: 10).isActive = true
        
        
        if isNVUDemo.bool(forKey: "isNVUDemo") {
            pwSubSwitchContainer.isHidden = true
        }
        
        pwSubSwitchContainer.backgroundColor = .clear
        pwSubSwitchContainer.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(pwSubSwitchContainer)
        pwSubSwitchContainer.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -.createAspectRatio(value: 21)).isActive = true
        pwSubSwitchContainer.centerYAnchor.constraint(equalTo: downArrow.centerYAnchor, constant: 0).isActive = true
        pwSubSwitchContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 26)).isActive = true
        pwSubSwitchContainer.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 50)).isActive = true
                
        pwSubSwitch = PWSwitch(frame: CGRect(x: 0, y: 0, width: 50, height: 26))
        pwSubSwitch.trackOnFillColor = isNVUDemo.bool(forKey: "isNVUDemo") ? .nvuBlueOne : UIColor(red: 227/255, green: 78/255, blue: 177/255, alpha: 1.0)
        pwSubSwitch.trackOffFillColor = .white
        pwSubSwitch.trackOnBorderColor = isNVUDemo.bool(forKey: "isNVUDemo") ? .nvuBlueOne : UIColor(red: 227/255, green: 78/255, blue: 177/255, alpha: 1.0)
        pwSubSwitch.thumbOffFillColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1.0)
        pwSubSwitch.thumbOnFillColor = .white
        pwSubSwitch.thumbOffBorderColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1.0)
        pwSubSwitch.thumbOnBorderColor = .white
        //self.view.addSubview(pwSubSwitch)
        pwSubSwitch.setOn(false, animated: true)
        pwSubSwitch.addTarget(self, action: #selector(self.subOnSwitchChanged), for: .valueChanged)
        if pwSubSwitch.on {
            //do something is switch is on
        }
        pwSubSwitchContainer.addSubview(pwSubSwitch)
        
        /*
        copyButton.backgroundColor = .clear
        copyButton.adjustsImageWhenHighlighted = false
        copyButton.setBackgroundImage(UIImage(named: "linkInactive"), for: .normal)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(copyButton)
        copyButton.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true
        copyButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21).isActive = true
        copyButton.heightAnchor.constraint(equalToConstant: 53).isActive = true
        copyButton.widthAnchor.constraint(equalToConstant: 53).isActive = true
        
        if let userName = User.current.name {
            //linkLabel.text = "lynkapp.co/\(userName)"
            let str = userName
            let replaced = str.replacingOccurrences(of: " ", with: "_")
            linkLabel.text = "user.lynkapp.co/\(replaced.lowercased())"
        } else {
            linkLabel.text = "link unaivalable"
        }
        linkLabel.textAlignment = .center
        linkLabel.font = .sofiaMedium(ofSize: 19)
        linkLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        linkLabel.numberOfLines = 0
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(linkLabel)
        linkLabel.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true
        linkLabel.topAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 20).isActive = true
         */
        
        //qrImageView.image = UIImage(named: "phQR")
        qrImageView.setImageColor(color: textColor)
        qrImageView.contentMode = .scaleAspectFill
        qrImageView.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(qrImageView)
        qrImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        qrImageView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor, constant: 0).isActive = true
        qrImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 182)).isActive = true
        qrImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 182)).isActive = true
        
        qrLinkTrackingImageView.alpha = 0
        qrLinkTrackingImageView.image = UIImage(named: "phQR")
        qrLinkTrackingImageView.setImageColor(color: textColor)
        qrLinkTrackingImageView.contentMode = .scaleAspectFill
        qrLinkTrackingImageView.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(qrLinkTrackingImageView)
        qrLinkTrackingImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        qrLinkTrackingImageView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor, constant: 0).isActive = true
        qrLinkTrackingImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 182)).isActive = true
        qrLinkTrackingImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 182)).isActive = true
                
        copyURLButton.addTarget(self, action: #selector(linkCopied), for: .touchUpInside)
        copyURLButton.continueLabel.text = "Copy URL"
        copyURLButton.continueLabel.centerXAnchor.constraint(equalTo: copyURLButton.gradientBG.centerXAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        copyURLButton.crownImageView.image = UIImage(named: "copyImg")
        copyURLButton.layer.zPosition = 2
        copyURLButton.layer.cornerRadius = .createAspectRatio(value: 56)/2
        copyURLButton.layer.masksToBounds = true
        copyURLButton.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(copyURLButton)
        copyURLButton.leadingAnchor.constraint(equalTo: cardContainer.centerXAnchor, constant: .createAspectRatio(value: 9.5)).isActive = true
        //copyURLButton.leadingAnchor.constraint(equalTo: shareURLButton.trailingAnchor, constant: 21).isActive = true
        copyURLButton.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -.createAspectRatio(value: 22)).isActive = true
        //copyURLButton.topAnchor.constraint(equalTo: qrImageView.bottomAnchor, constant: 36).isActive = true
        copyURLButton.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: -.createAspectRatio(value: 46)).isActive = true
        copyURLButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        shareURLButton.addTarget(self, action: #selector(didTapShareURL), for: .touchUpInside)
        shareURLButton.continueLabel.text = "Share URL"
        shareURLButton.continueLabel.centerXAnchor.constraint(equalTo: shareURLButton.gradientBG.centerXAnchor, constant: .createAspectRatio(value: 13)).isActive = true
        shareURLButton.crownImageView.image = UIImage(named: "shareImg")
        shareURLButton.layer.zPosition = 2
        shareURLButton.layer.cornerRadius = .createAspectRatio(value: 56)/2
        shareURLButton.layer.masksToBounds = true
        shareURLButton.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(shareURLButton)
        shareTrailing = shareURLButton.trailingAnchor.constraint(equalTo: cardContainer.centerXAnchor, constant: -.createAspectRatio(value: 9.5))
        shareTrailing.isActive = true
        shareURLButton.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: .createAspectRatio(value: 22)).isActive = true
        shareURLButton.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: -.createAspectRatio(value: 46)).isActive = true
        shareURLButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        //
        
        nameContainer.alpha = 0
        createEntryContainer(containerView: nameContainer)
        createTextField(tfField: nameTextField, viewToPin: nameContainer, ph: "Tracking Text")
        nameTextField.returnKeyType = .next
        nameTextField.autocapitalizationType = .none
        nameTextField.tag = 1
        nameTextField.delegate = self
        
        let accessoryContainer = UIView()
        accessoryContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: .createAspectRatio(value: 66))
        accessoryContainer.backgroundColor = .clear
        
        nameTextField.inputAccessoryView = accessoryContainer
        
        //continueButton.delegate = self
        continueButton.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 4, height: 4), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        continueButton.addTarget(self, action: #selector(didTapSetTracking), for: .touchUpInside)
        continueButton.continueLabel.text = "Set Tracking"
        continueButton.continueLabel.textColor = .white
        continueButton.confirmLabel.text = "Request Reset"
        continueButton.confirmLabel.textColor = .white
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        accessoryContainer.addSubview(continueButton)
        continueButton.leadingAnchor.constraint(equalTo: accessoryContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: accessoryContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        continueButton.topAnchor.constraint(equalTo: accessoryContainer.topAnchor, constant: 0).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
    }
    
    func setupSettings() {
        teamSettingsContainer.isUserInteractionEnabled = false
        teamSettingsContainer.alpha = 0
        teamSettingsContainer.backgroundColor = .red.withAlphaComponent(0.5)
        teamSettingsContainer.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(teamSettingsContainer)
        teamSettingsContainer.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 0).isActive = true
        teamSettingsContainer.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: 0).isActive = true
        teamSettingsContainer.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: -100).isActive = true
        teamSettingsContainer.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 0).isActive = true
                
        teamSettingsTitleLabel.text = "Team Settings"
        teamSettingsTitleLabel.textAlignment = .center
        teamSettingsTitleLabel.textColor = .newBlack
        teamSettingsTitleLabel.font = .sofiaProMedium(ofSize: 16)
        teamSettingsTitleLabel.numberOfLines = 0
        teamSettingsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(teamSettingsTitleLabel)
        teamSettingsTitleLabel.topAnchor.constraint(equalTo: teamSettingsContainer.topAnchor, constant: 20).isActive = true
        teamSettingsTitleLabel.centerXAnchor.constraint(equalTo: teamSettingsContainer.centerXAnchor).isActive = true
        
        //holdingTankTitleLabel.alpha = 0
        //holdingTankTitleLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        holdingTankTitleLabel.text = "Holding Tank"
        holdingTankTitleLabel.textAlignment = .left
        holdingTankTitleLabel.textColor = .newBlack
        holdingTankTitleLabel.font = .sofiaProBold(ofSize: 16)
        holdingTankTitleLabel.numberOfLines = 0
        holdingTankTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(holdingTankTitleLabel)
        holdingTankTitleLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        holdingTankTitleLabel.topAnchor.constraint(equalTo: teamSettingsTitleLabel.bottomAnchor, constant: 46).isActive = true
        
        //holdingTankDetailLabel.alpha = 0
        //holdingTankDetailLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        let holdingTankDetailLabelText = "New enrollments who are not placed\nwithin 48 hours will be automatically\nplaced in the next open team position."
        holdingTankDetailLabel.setupLineHeight(myText: holdingTankDetailLabelText, myLineSpacing: 6)
        holdingTankDetailLabel.textAlignment = .left
        holdingTankDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
        holdingTankDetailLabel.font = .sofiaProRegular(ofSize: 12)
        holdingTankDetailLabel.numberOfLines = 0
        holdingTankDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(holdingTankDetailLabel)
        holdingTankDetailLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        holdingTankDetailLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        holdingTankDetailLabel.topAnchor.constraint(equalTo: holdingTankTitleLabel.bottomAnchor, constant: 8).isActive = true
        
        //pwSubSwitchContainer.alpha = 0
        //pwSubSwitchContainer.transform = CGAffineTransform(translationX: 0, y: 30)
        pwSubSwitchContainer.backgroundColor = .clear
        pwSubSwitchContainer.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(pwSubSwitchContainer)
        pwSubSwitchContainer.trailingAnchor.constraint(equalTo: teamSettingsContainer.trailingAnchor, constant: -21).isActive = true
        pwSubSwitchContainer.centerYAnchor.constraint(equalTo: holdingTankTitleLabel.centerYAnchor, constant: 0).isActive = true
        pwSubSwitchContainer.heightAnchor.constraint(equalToConstant: 26).isActive = true
        pwSubSwitchContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        pwSubSwitch = PWSwitch(frame: CGRect(x: 0, y: 0, width: 50, height: 26))
        pwSubSwitch.trackOnFillColor = isNVUDemo.bool(forKey: "isNVUDemo") ? .nvuBlueOne : UIColor(red: 227/255, green: 78/255, blue: 177/255, alpha: 1.0)
        pwSubSwitch.trackOffFillColor = .white
        pwSubSwitch.trackOnBorderColor = isNVUDemo.bool(forKey: "isNVUDemo") ? .nvuBlueOne : UIColor(red: 227/255, green: 78/255, blue: 177/255, alpha: 1.0)
        pwSubSwitch.thumbOffFillColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1.0)
        pwSubSwitch.thumbOnFillColor = .white
        pwSubSwitch.thumbOffBorderColor = UIColor(red: 171/255, green: 171/255, blue: 171/255, alpha: 1.0)
        pwSubSwitch.thumbOnBorderColor = .white
        //self.view.addSubview(pwSubSwitch)
        pwSubSwitch.setOn(false, animated: true)
        pwSubSwitch.addTarget(self, action: #selector(self.subOnSwitchChanged), for: .valueChanged)
        if pwSubSwitch.on {
            //do something is switch is on
        }
        pwSubSwitchContainer.addSubview(pwSubSwitch)
        
        
        //dividerLine.alpha = 0
        //dividerLine.transform = CGAffineTransform(translationX: 0, y: 30)
        dividerLine.backgroundColor = UIColor.newBlack.withAlphaComponent(0.2)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 21).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -21).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: holdingTankDetailLabel.bottomAnchor, constant: 30).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //holdingTankTitleLabel.alpha = 0
        //holdingTankTitleLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        alternatingLabel.text = "Alternating"
        alternatingLabel.textAlignment = .left
        alternatingLabel.textColor = .newBlack
        alternatingLabel.font = .sofiaProBold(ofSize: 16)
        alternatingLabel.numberOfLines = 0
        alternatingLabel.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(alternatingLabel)
        alternatingLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        alternatingLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 30).isActive = true
        
        //holdingTankDetailLabel.alpha = 0
        //holdingTankDetailLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        let alternatingDetailLabelText = "This setting will place enrollments first to\nTeam 1, then Team 2, then Team 3 - and\nthen it will repeat this progression."
        alternatingDetailLabel.setupLineHeight(myText: alternatingDetailLabelText, myLineSpacing: 6)
        alternatingDetailLabel.textAlignment = .left
        alternatingDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
        alternatingDetailLabel.font = .sofiaProRegular(ofSize: 12)
        alternatingDetailLabel.numberOfLines = 0
        alternatingDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(alternatingDetailLabel)
        alternatingDetailLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        alternatingDetailLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        alternatingDetailLabel.topAnchor.constraint(equalTo: alternatingLabel.bottomAnchor, constant: 8).isActive = true
        
        alternatingBoxImageView.image = UIImage(named: "checkBoxFillNVU")
        alternatingBoxImageView.contentMode = .scaleAspectFill
        alternatingBoxImageView.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(alternatingBoxImageView)
        alternatingBoxImageView.trailingAnchor.constraint(equalTo: teamSettingsContainer.trailingAnchor, constant: -21).isActive = true
        alternatingBoxImageView.centerYAnchor.constraint(equalTo: alternatingLabel.centerYAnchor, constant: 0).isActive = true
        alternatingBoxImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        alternatingBoxImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        alternatingButton.tag = 1
        alternatingButton.addTarget(self, action: #selector(tappedSettingsOption), for: .touchUpInside)
        alternatingButton.backgroundColor = .clear
        alternatingButton.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(alternatingButton)
        alternatingButton.leadingAnchor.constraint(equalTo: alternatingLabel.leadingAnchor).isActive = true
        alternatingButton.topAnchor.constraint(equalTo: alternatingLabel.topAnchor).isActive = true
        alternatingButton.trailingAnchor.constraint(equalTo: alternatingBoxImageView.trailingAnchor).isActive = true
        alternatingButton.bottomAnchor.constraint(equalTo: alternatingDetailLabel.bottomAnchor).isActive = true
        
        //holdingTankTitleLabel.alpha = 0
        //holdingTankTitleLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        smartLabel.text = "Smart"
        smartLabel.textAlignment = .left
        smartLabel.textColor = .newBlack
        smartLabel.font = .sofiaProBold(ofSize: 16)
        smartLabel.numberOfLines = 0
        smartLabel.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(smartLabel)
        smartLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        smartLabel.topAnchor.constraint(equalTo: alternatingDetailLabel.bottomAnchor, constant: 24).isActive = true
        
        //holdingTankDetailLabel.alpha = 0
        //holdingTankDetailLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        let smartDetailLabelText = "This setting will automatically determine\nthe best placement for each new\nenrollment that will benefit you the most."
        smartDetailLabel.setupLineHeight(myText: smartDetailLabelText, myLineSpacing: 6)
        smartDetailLabel.textAlignment = .left
        smartDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
        smartDetailLabel.font = .sofiaProRegular(ofSize: 12)
        smartDetailLabel.numberOfLines = 0
        smartDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(smartDetailLabel)
        smartDetailLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        smartDetailLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        smartDetailLabel.topAnchor.constraint(equalTo: smartLabel.bottomAnchor, constant: 8).isActive = true
        
        smartBoxImageView.image = UIImage(named: "checkBoxEmpty")
        smartBoxImageView.contentMode = .scaleAspectFill
        smartBoxImageView.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(smartBoxImageView)
        smartBoxImageView.trailingAnchor.constraint(equalTo: teamSettingsContainer.trailingAnchor, constant: -21).isActive = true
        smartBoxImageView.topAnchor.constraint(equalTo: smartLabel.topAnchor, constant: 0).isActive = true
        smartBoxImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        smartBoxImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        smartButton.tag = 2
        smartButton.addTarget(self, action: #selector(tappedSettingsOption), for: .touchUpInside)
        smartButton.backgroundColor = .clear
        smartButton.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(smartButton)
        smartButton.leadingAnchor.constraint(equalTo: smartLabel.leadingAnchor).isActive = true
        smartButton.topAnchor.constraint(equalTo: smartLabel.topAnchor).isActive = true
        smartButton.trailingAnchor.constraint(equalTo: smartBoxImageView.trailingAnchor).isActive = true
        smartButton.bottomAnchor.constraint(equalTo: smartDetailLabel.bottomAnchor).isActive = true
        
        //holdingTankTitleLabel.alpha = 0
        //holdingTankTitleLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        teamLabel.text = "Team"
        teamLabel.textAlignment = .left
        teamLabel.textColor = .newBlack
        teamLabel.font = .sofiaProBold(ofSize: 16)
        teamLabel.numberOfLines = 0
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(teamLabel)
        teamLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        teamLabel.topAnchor.constraint(equalTo: smartDetailLabel.bottomAnchor, constant: 24).isActive = true
        
        //holdingTankDetailLabel.alpha = 0
        //holdingTankDetailLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        let teamDetailLabelText = "This setting will allow you to choose to\nbuild in the one team you specify ONLY.\nPlease choose either Team 1, 2, or 3 from\nthe menu below."
        teamDetailLabel.setupLineHeight(myText: teamDetailLabelText, myLineSpacing: 6)
        teamDetailLabel.textAlignment = .left
        teamDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
        teamDetailLabel.font = .sofiaProRegular(ofSize: 12)
        teamDetailLabel.numberOfLines = 0
        teamDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(teamDetailLabel)
        teamDetailLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        teamDetailLabel.leadingAnchor.constraint(equalTo: teamSettingsContainer.leadingAnchor, constant: 21).isActive = true
        teamDetailLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 8).isActive = true
         
        teamBoxImageView.image = UIImage(named: "checkBoxEmpty")
        teamBoxImageView.contentMode = .scaleAspectFill
        teamBoxImageView.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(teamBoxImageView)
        teamBoxImageView.trailingAnchor.constraint(equalTo: teamSettingsContainer.trailingAnchor, constant: -21).isActive = true
        teamBoxImageView.topAnchor.constraint(equalTo: teamLabel.topAnchor, constant: 0).isActive = true
        teamBoxImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        teamBoxImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        teamButton.tag = 3
        teamButton.addTarget(self, action: #selector(tappedSettingsOption), for: .touchUpInside)
        teamButton.backgroundColor = .clear
        teamButton.translatesAutoresizingMaskIntoConstraints = false
        teamSettingsContainer.addSubview(teamButton)
        teamButton.leadingAnchor.constraint(equalTo: teamLabel.leadingAnchor).isActive = true
        teamButton.topAnchor.constraint(equalTo: teamLabel.topAnchor).isActive = true
        teamButton.trailingAnchor.constraint(equalTo: teamBoxImageView.trailingAnchor).isActive = true
        teamButton.bottomAnchor.constraint(equalTo: teamDetailLabel.bottomAnchor).isActive = true
    }
    
    func createEntryContainer(containerView: UIView) {
        containerView.layer.cornerRadius = 52/2
        containerView.backgroundColor = .newBlack.withAlphaComponent(0.06)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(containerView)
        //containerView.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 24).isActive = true
        //containerView.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -24).isActive = true
        containerView.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor, constant: 0).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.55).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        containerView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 24).isActive = true
    }
    
    func createTextField(tfField: UITextField, viewToPin: UIView, ph: String) {
        tfField.alpha = 1.0
        tfField.returnKeyType = .done
        tfField.textColor = .black
        tfField.textAlignment = .center
        tfField.font = .sofiaProRegular(ofSize: 16)
        tfField.autocorrectionType = .no
        tfField.tintColor = .newBlack
        tfField.attributedPlaceholder = NSAttributedString(string: ph, attributes: [
            .foregroundColor: UIColor.newBlack.withAlphaComponent(0.4),
            .font: UIFont.sofiaProRegular(ofSize: 16)
        ])
        //tfField.delegate = self
        tfField.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.addSubview(tfField)
        tfField.leadingAnchor.constraint(equalTo: viewToPin.leadingAnchor, constant: 18).isActive = true
        tfField.centerYAnchor.constraint(equalTo: viewToPin.centerYAnchor, constant: 0).isActive = true
        tfField.trailingAnchor.constraint(equalTo: viewToPin.trailingAnchor, constant: -18).isActive = true
        tfField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}

