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
        cardContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 630)).isActive = true
        cardContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        titleLabel.text = "Team Name & Photo"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 18))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: .createAspectRatio(value: 18)).isActive = true
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
                
        teamNameContainer.backgroundColor = .clear
        teamNameContainer.layer.borderWidth = 1
        teamNameContainer.layer.borderColor = UIColor.black.cgColor
        teamNameContainer.layer.cornerRadius = .createAspectRatio(value: 10)
        teamNameContainer.translatesAutoresizingMaskIntoConstraints = false
        cardContainer.addSubview(teamNameContainer)
        teamNameContainer.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        teamNameContainer.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        teamNameContainer.topAnchor.constraint(equalTo: teamPhotoImageView.bottomAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        teamNameContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 58)).isActive = true
                
        if self.team?.name != nil {
            teamNameTextField.text = self.team?.name
        }
        teamNameTextField.becomeFirstResponder()
        teamNameTextField.autocapitalizationType = .sentences
        teamNameTextField.alpha = 1.0
        teamNameTextField.returnKeyType = .done
        teamNameTextField.textColor = .black
        teamNameTextField.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 14))
        teamNameTextField.autocorrectionType = .no
        teamNameTextField.tintColor = .nvuBlueOne
        teamNameTextField.attributedPlaceholder = NSAttributedString(string: "Team Name", attributes: [
            .foregroundColor: UIColor.black.withAlphaComponent(0.5),
            .font: UIFont.sofiaProMedium(ofSize: .createAspectRatio(value: 14))
        ])
        teamNameTextField.delegate = self
        teamNameTextField.translatesAutoresizingMaskIntoConstraints = false
        teamNameContainer.addSubview(teamNameTextField)
        teamNameTextField.leadingAnchor.constraint(equalTo: teamNameContainer.leadingAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        teamNameTextField.centerYAnchor.constraint(equalTo: teamNameContainer.centerYAnchor, constant: 0).isActive = true
        teamNameTextField.trailingAnchor.constraint(equalTo: teamNameContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        teamNameTextField.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 30)).isActive = true
        
        spinner.isHidden = true
        spinner.alpha = 0
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        teamNameContainer.addSubview(spinner)
        spinner.trailingAnchor.constraint(equalTo: teamNameContainer.trailingAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
        spinner.centerYAnchor.constraint(equalTo: teamNameContainer.centerYAnchor).isActive = true
    }
}
