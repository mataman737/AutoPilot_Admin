//
//  UpdateTeamNameAndPhotoViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/8/23.
//

import Foundation
import UIKit

extension UpdateTeamNameAndPhotoViewController {
 
    func setupViews() {
        
        //isDarkMode.bool(forKey: "isDarkMode") ? .white : .black
        
        let opacityTapped = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        opacityLayer.addGestureRecognizer(opacityTapped)
        opacityLayer.isUserInteractionEnabled = true
        opacityLayer.backgroundColor = .black
        opacityLayer.alpha = 0
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
        
        cardContainer.backgroundColor = isDarkMode.bool(forKey: "isDarkMode") ? .darkModeCardBackground : .white//.darkModeCardBackground
        cardContainer.layer.cornerRadius = .createAspectRatio(value: 12)
        cardContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardContainer.layer.masksToBounds = true
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardContainer)
        cardContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cardContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cardContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        cardContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 630)).isActive = true
        cardContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        titleLabel.text = "Team Name & Photo"
        titleLabel.textAlignment = .center
        titleLabel.textColor = isDarkMode.bool(forKey: "isDarkMode") ? .white : .black
        titleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 18))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true
        
        downArrow.image = UIImage(named: "newDownArrow")
        downArrow.setImageColor(color: isDarkMode.bool(forKey: "isDarkMode") ? .white : .black)
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
        
        let photoTapped = UITapGestureRecognizer(target: self, action: #selector(replacePhotoClicked))
        teamPhotoImageView.addGestureRecognizer(photoTapped)
        teamPhotoImageView.isUserInteractionEnabled = true
        teamPhotoImageView.image = UIImage(named: "enigmaUserPH")
        teamPhotoImageView.contentMode = .scaleAspectFill
        teamPhotoImageView.layer.cornerRadius = .createAspectRatio(value: 110)/2
        teamPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(teamPhotoImageView)
        teamPhotoImageView.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true
        teamPhotoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        teamPhotoImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 110)).isActive = true
        teamPhotoImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 110)).isActive = true
        
        //
                
        accessCodeTextContainer.backgroundColor = .clear
        accessCodeTextContainer.layer.borderWidth = 1
        accessCodeTextContainer.layer.borderColor = isDarkMode.bool(forKey: "isDarkMode") ? UIColor.white.cgColor : UIColor.black.cgColor//UIColor.white.cgColor
        accessCodeTextContainer.layer.cornerRadius = .createAspectRatio(value: 10)
        accessCodeTextContainer.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(accessCodeTextContainer)
        accessCodeTextContainer.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        accessCodeTextContainer.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        accessCodeTextContainer.topAnchor.constraint(equalTo: teamPhotoImageView.bottomAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        accessCodeTextContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 58)).isActive = true
                
        accessCodeTextField.becomeFirstResponder()
        accessCodeTextField.autocapitalizationType = .none
        accessCodeTextField.alpha = 1.0
        accessCodeTextField.returnKeyType = .done
        accessCodeTextField.textColor = isDarkMode.bool(forKey: "isDarkMode") ? .white : .black//.white
        accessCodeTextField.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 14))
        accessCodeTextField.autocorrectionType = .no
        accessCodeTextField.tintColor = .nvuBlueOne
        accessCodeTextField.attributedPlaceholder = NSAttributedString(string: "Team Name", attributes: [
            .foregroundColor: isDarkMode.bool(forKey: "isDarkMode") ? UIColor.white.withAlphaComponent(0.5) : UIColor.black.withAlphaComponent(0.5),
            .font: UIFont.sofiaProMedium(ofSize: .createAspectRatio(value: 14))
        ])
        accessCodeTextField.delegate = self
        accessCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        accessCodeTextContainer.addSubview(accessCodeTextField)
        accessCodeTextField.leadingAnchor.constraint(equalTo: accessCodeTextContainer.leadingAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        accessCodeTextField.centerYAnchor.constraint(equalTo: accessCodeTextContainer.centerYAnchor, constant: 0).isActive = true
        accessCodeTextField.trailingAnchor.constraint(equalTo: accessCodeTextContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        accessCodeTextField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
    }
}
