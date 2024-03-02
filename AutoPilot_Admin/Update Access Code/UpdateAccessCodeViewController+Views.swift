//
//  UpdateAccessCodeViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/8/23.
//

import Foundation
import UIKit

extension UpdateAccessCodeViewController {
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
        
        navTitleLabel.text = "Access Code"
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
                
        if team?.accessCode != nil {
            accessCodeTextField.text = team?.accessCode
        }
        accessCodeTextField.becomeFirstResponder()
        accessCodeTextField.autocapitalizationType = .none
        accessCodeTextField.alpha = 1.0
        accessCodeTextField.returnKeyType = .done
        accessCodeTextField.textColor = .black
        accessCodeTextField.font = .poppinsMedium(ofSize: .createAspectRatio(value: 14))
        accessCodeTextField.autocorrectionType = .no
        accessCodeTextField.tintColor = .nvuBlueOne
        accessCodeTextField.attributedPlaceholder = NSAttributedString(string: "Access Code", attributes: [
            .foregroundColor: UIColor.black.withAlphaComponent(0.5),
            .font: UIFont.poppinsMedium(ofSize: .createAspectRatio(value: 14))
        ])        
        accessCodeTextField.delegate = self
        accessCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        accessCodeTextContainer.addSubview(accessCodeTextField)
        accessCodeTextField.leadingAnchor.constraint(equalTo: accessCodeTextContainer.leadingAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        accessCodeTextField.centerYAnchor.constraint(equalTo: accessCodeTextContainer.centerYAnchor, constant: 0).isActive = true
        accessCodeTextField.trailingAnchor.constraint(equalTo: accessCodeTextContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        accessCodeTextField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        
        spinner.isHidden = true
        spinner.alpha = 0
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        accessCodeTextContainer.addSubview(spinner)
        spinner.trailingAnchor.constraint(equalTo: accessCodeTextContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        spinner.centerYAnchor.constraint(equalTo: accessCodeTextContainer.centerYAnchor).isActive = true
    }
}
