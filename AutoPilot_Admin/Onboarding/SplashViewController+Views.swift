//
//  SplashViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/3/23.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

extension SplashViewController {
    
    func setupViews() {
                
        loopingVideoContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loopingVideoContainer)
        loopingVideoContainer.fillSuperview()
        
        blurredView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(blurredView)
        blurredView.fillSuperview()
                            
        loginButton.setTitle("Log in", for: .normal)
        loginButton.alpha = 1.0
        loginButton.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        loginButton.titleLabel?.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 18))
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(red: 95/255, green: 201/255, blue: 207/255, alpha: 1.0)
        loginButton.layer.cornerRadius = .createAspectRatio(value: 56)/2
        loginButton.layer.masksToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginButton)
        loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -.createAspectRatio(value: 8)).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -.createAspectRatio(value: 50)).isActive = true //40
        loginButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        joinButton.setTitle("Join", for: .normal)
        joinButton.alpha = 1.0
        joinButton.addTarget(self, action: #selector(goToJoin), for: .touchUpInside)
        joinButton.titleLabel?.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 18))
        joinButton.setTitleColor(.white, for: .normal)
        joinButton.backgroundColor = .clear
        joinButton.layer.borderColor = UIColor.white.cgColor//UIColor(red: 95/255, green: 201/255, blue: 207/255, alpha: 1.0).cgColor
        joinButton.layer.borderWidth = 2
        joinButton.layer.cornerRadius = .createAspectRatio(value: 56)/2
        joinButton.layer.masksToBounds = true
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(joinButton)
        joinButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.createAspectRatio(value: 20)).isActive = true
        joinButton.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        joinButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -.createAspectRatio(value: 50)).isActive = true //40
        joinButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        let detailsLabelText = "Manage\nyour trades,\nteam, and\nmore"
        detailsLabel.setupLineHeight(myText: detailsLabelText, myLineSpacing: .createAspectRatio(value: 12))
        detailsLabel.alpha = 1.0
        detailsLabel.textAlignment = .left
        detailsLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 40))
        detailsLabel.textColor = .white.withAlphaComponent(0.5)
        detailsLabel.numberOfLines = 0
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailsLabel)
        detailsLabel.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor, constant: 0).isActive = true
        detailsLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -.createAspectRatio(value: 163)).isActive = true
        
        logoImageView.alpha = 1.0
        logoImageView.image = UIImage(named: "smartTraderLogoDark")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logoImageView)
        logoImageView.leadingAnchor.constraint(equalTo: detailsLabel.leadingAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: detailsLabel.topAnchor, constant: -.createAspectRatio(value: 21.45)).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 84.26)).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 161)).isActive = true
                
        launchView.layer.zPosition = 100
        launchView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(launchView)
        launchView.fillSuperview()
    }
}



