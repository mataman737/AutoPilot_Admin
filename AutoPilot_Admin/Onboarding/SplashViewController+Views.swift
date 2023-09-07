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
                            
        joinWaitingListButton.setTitle("Log in", for: .normal)
        joinWaitingListButton.alpha = 1.0
        joinWaitingListButton.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        joinWaitingListButton.titleLabel?.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 18))
        joinWaitingListButton.setTitleColor(.white, for: .normal)
        joinWaitingListButton.backgroundColor = UIColor(red: 95/255, green: 201/255, blue: 207/255, alpha: 1.0)
        joinWaitingListButton.layer.cornerRadius = .createAspectRatio(value: 56)/2
        joinWaitingListButton.layer.masksToBounds = true
        joinWaitingListButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(joinWaitingListButton)
        joinWaitingListButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        joinWaitingListButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.createAspectRatio(value: 20)).isActive = true
        joinWaitingListButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -.createAspectRatio(value: 50)).isActive = true //40
        joinWaitingListButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        let detailsLabelText = "Manage\nyour trades,\nteam, and\nmore"
        detailsLabel.setupLineHeight(myText: detailsLabelText, myLineSpacing: .createAspectRatio(value: 12))
        detailsLabel.alpha = 1.0
        detailsLabel.textAlignment = .left
        detailsLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 40))
        detailsLabel.textColor = .white.withAlphaComponent(0.5)
        detailsLabel.numberOfLines = 0
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailsLabel)
        detailsLabel.leadingAnchor.constraint(equalTo: joinWaitingListButton.leadingAnchor, constant: 0).isActive = true
        detailsLabel.bottomAnchor.constraint(equalTo: joinWaitingListButton.topAnchor, constant: -.createAspectRatio(value: 163)).isActive = true
        
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



