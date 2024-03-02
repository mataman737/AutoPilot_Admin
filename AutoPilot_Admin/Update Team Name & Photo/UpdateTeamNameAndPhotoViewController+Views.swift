//
//  UpdateTeamNameAndPhotoViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/8/23.
//

import Foundation
import UIKit
import Kingfisher

extension UpdateTeamNameAndPhotoViewController {
 
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
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 630)).isActive = true
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
        
        navTitleLabel.text = "Team Name & Photo"
        navTitleLabel.textColor = .black
        navTitleLabel.isUserInteractionEnabled = false
        navTitleLabel.textAlignment = .center
        navTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 19))
        navTitleLabel.numberOfLines = 0
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(navTitleLabel)
        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        
//        navTitleLabel.text = "Team Name & Photo"
//        navTitleLabel.textAlignment = .center
//        navTitleLabel.textColor = .black
//        navTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 18))
//        navTitleLabel.numberOfLines = 0
//        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        mainContainer.addSubview(navTitleLabel)
//        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 18)).isActive = true
//        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
//        
//        downArrow.image = UIImage(named: "newDownArrow")
//        downArrow.setImageColor(color: .black)
//        downArrow.contentMode = .scaleAspectFill
//        downArrow.translatesAutoresizingMaskIntoConstraints = false
//        mainContainer.addSubview(downArrow)
//        downArrow.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
//        downArrow.centerYAnchor.constraint(equalTo: navTitleLabel.centerYAnchor, constant: 0).isActive = true
//        downArrow.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
//        downArrow.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
//        
//        downButton.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
//        downButton.backgroundColor = .clear
//        downButton.translatesAutoresizingMaskIntoConstraints = false
//        mainContainer.addSubview(downButton)
//        downButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 0).isActive = true
//        downButton.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 0).isActive = true
//        downButton.trailingAnchor.constraint(equalTo: downArrow.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
//        downButton.bottomAnchor.constraint(equalTo: downArrow.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        
        teamPhotoImageView.image = UIImage(named: "enigmaUserPH")
        if let teamPhoto = team?.photo {
            if let url = URL(string: teamPhoto) {
                teamPhotoImageView.kf.setImage(with: url)
                teamPhotoImageView.contentMode = .scaleAspectFill
            } else {
                teamPhotoImageView.image = UIImage(named: "enigmaUserPH")
            }
        }
        let photoTapped = UITapGestureRecognizer(target: self, action: #selector(replacePhotoClicked))
        teamPhotoImageView.addGestureRecognizer(photoTapped)
        teamPhotoImageView.backgroundColor = .lightGray
        teamPhotoImageView.isUserInteractionEnabled = true
        teamPhotoImageView.contentMode = .scaleAspectFill
        teamPhotoImageView.layer.cornerRadius = .createAspectRatio(value: 110)/2
        teamPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(teamPhotoImageView)
        teamPhotoImageView.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        teamPhotoImageView.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        teamPhotoImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 110)).isActive = true
        teamPhotoImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 110)).isActive = true
        
        //
                
        teamNameContainer.backgroundColor = .clear
        teamNameContainer.layer.borderWidth = 1
        teamNameContainer.layer.borderColor = UIColor.black.cgColor
        teamNameContainer.layer.cornerRadius = .createAspectRatio(value: 10)
        teamNameContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(teamNameContainer)
        teamNameContainer.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        teamNameContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
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
        teamNameTextField.font = .poppinsMedium(ofSize: .createAspectRatio(value: 14))
        teamNameTextField.autocorrectionType = .no
        teamNameTextField.tintColor = .nvuBlueOne
        teamNameTextField.attributedPlaceholder = NSAttributedString(string: "Team Name", attributes: [
            .foregroundColor: UIColor.black.withAlphaComponent(0.5),
            .font: UIFont.poppinsMedium(ofSize: .createAspectRatio(value: 14))
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
