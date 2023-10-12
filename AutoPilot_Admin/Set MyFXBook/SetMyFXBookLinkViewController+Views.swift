//
//  SetMyFXBookLinkViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 10/11/23.
//

import Foundation
import UIKit

extension SetMyFXBookLinkViewController {
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
        
        titleLabel.text = "MyFXBook Link"
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
                
        myFXBookTextContainer.backgroundColor = .clear
        myFXBookTextContainer.layer.borderWidth = 1
        myFXBookTextContainer.layer.borderColor = UIColor.black.cgColor
        myFXBookTextContainer.layer.cornerRadius = .createAspectRatio(value: 10)
        myFXBookTextContainer.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(myFXBookTextContainer)
        myFXBookTextContainer.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        myFXBookTextContainer.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        myFXBookTextContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .createAspectRatio(value: 36)).isActive = true
        myFXBookTextContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 58)).isActive = true
                
        if team?.accessCode != nil {
            myFXBookLinkTextField.text = team?.accessCode
        }
        myFXBookLinkTextField.becomeFirstResponder()
        myFXBookLinkTextField.autocapitalizationType = .none
        myFXBookLinkTextField.alpha = 1.0
        myFXBookLinkTextField.returnKeyType = .done
        myFXBookLinkTextField.textColor = .black
        myFXBookLinkTextField.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 14))
        myFXBookLinkTextField.autocorrectionType = .no
        myFXBookLinkTextField.tintColor = .nvuBlueOne
        myFXBookLinkTextField.attributedPlaceholder = NSAttributedString(string: "MyFXBook Link", attributes: [
            .foregroundColor: UIColor.black.withAlphaComponent(0.5),
            .font: UIFont.sofiaProMedium(ofSize: .createAspectRatio(value: 14))
        ])
        myFXBookLinkTextField.delegate = self
        myFXBookLinkTextField.translatesAutoresizingMaskIntoConstraints = false
        myFXBookTextContainer.addSubview(myFXBookLinkTextField)
        myFXBookLinkTextField.leadingAnchor.constraint(equalTo: myFXBookTextContainer.leadingAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        myFXBookLinkTextField.centerYAnchor.constraint(equalTo: myFXBookTextContainer.centerYAnchor, constant: 0).isActive = true
        myFXBookLinkTextField.trailingAnchor.constraint(equalTo: myFXBookTextContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        myFXBookLinkTextField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        
        spinner.isHidden = true
        spinner.alpha = 0
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        myFXBookTextContainer.addSubview(spinner)
        spinner.trailingAnchor.constraint(equalTo: myFXBookTextContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        spinner.centerYAnchor.constraint(equalTo: myFXBookTextContainer.centerYAnchor).isActive = true
    }
}
