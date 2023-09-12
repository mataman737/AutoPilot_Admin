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
        
        titleLabel.text = "Access Code"
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
                
        if team?.accessCode != nil {
            accessCodeTextField.text = team?.accessCode
        }
        accessCodeTextField.becomeFirstResponder()
        accessCodeTextField.autocapitalizationType = .none
        accessCodeTextField.alpha = 1.0
        accessCodeTextField.returnKeyType = .done
        accessCodeTextField.textColor = .black
        accessCodeTextField.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 14))
        accessCodeTextField.autocorrectionType = .no
        accessCodeTextField.tintColor = .nvuBlueOne
        accessCodeTextField.attributedPlaceholder = NSAttributedString(string: "Access Code", attributes: [
            .foregroundColor: UIColor.black.withAlphaComponent(0.5),
            .font: UIFont.sofiaProMedium(ofSize: .createAspectRatio(value: 14))
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
