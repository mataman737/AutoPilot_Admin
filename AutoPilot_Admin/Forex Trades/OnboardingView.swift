//
//  OnboardingView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/11/23.
//

import Foundation
import UIKit

class OnboardingView: UIView {
    
    var animationView = UIView()
    var welcomeLabel = UILabel()
    var setupAccLabel = UILabel()
    var addTeamNamePhotoContainer = UIButton()
    var accessCodeContainer = UIButton()
    var brokerContainer = UIButton()
    var namePhotoImageView = UIImageView()
    var accessCodeImageView = UIImageView()
    var connectBrokerImageView = UIImageView()
    
    var connectMyFXBookContainer = UIButton()
    var connectMyFXBookImageView = UIImageView()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        self.backgroundColor = .white
       setupViews()
       
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}

// MARK: Helpers

extension OnboardingView {
    func setupViews() {
        
        animationView.backgroundColor = .clear
        animationView.layer.cornerRadius = 8
        animationView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(animationView)
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: self.topAnchor, constant: .createAspectRatio(value: 26)).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 175)).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 175)).isActive = true
        
        welcomeLabel.setupLabel(text: "Welcome to Omni!", txtColor: .black.withAlphaComponent(0.5), font: .sofiaProSemiBold(ofSize: .createAspectRatio(value: 15)), txtAlignment: .center)
        self.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: .createAspectRatio(value: 34)).isActive = true
        
        setupAccLabel.setupLabel(text: "Setup your account", txtColor: .black, font: .sofiaProMedium(ofSize: .createAspectRatio(value: 26)), txtAlignment: .center)
        self.addSubview(setupAccLabel)
        setupAccLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        setupAccLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        
        createContainer(container: addTeamNamePhotoContainer, containerImageView: namePhotoImageView, containerString: "Add team name & photo", isFirst: true, viewToPin: setupAccLabel)
        createContainer(container: accessCodeContainer, containerImageView: accessCodeImageView, containerString: "Set access code", isFirst: false, viewToPin: addTeamNamePhotoContainer)
        createContainer(container: brokerContainer, containerImageView: connectBrokerImageView, containerString: "Connect a broker", isFirst: false, viewToPin: accessCodeContainer)
        createContainer(container: connectMyFXBookContainer, containerImageView: connectMyFXBookImageView, containerString: "Add MyFXBook Link", isFirst: false, viewToPin: brokerContainer)
        
        namePhotoImageView.image = UIImage(named: "namePhotoBubble")
        accessCodeImageView.image = UIImage(named: "codeBubble")
        connectBrokerImageView.image = UIImage(named: "brokerBubble")
        connectMyFXBookImageView.image = UIImage(named: "myFXBookBubble")
    }
    
    func createContainer(container: UIButton, containerImageView: UIImageView, containerString: String, isFirst: Bool, viewToPin: UIView) {
        container.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        container.layer.cornerRadius = 19
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .createAspectRatio(value: 16)).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        container.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 66)).isActive = true
        if isFirst {
            container.topAnchor.constraint(equalTo: viewToPin.bottomAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        } else {
            container.topAnchor.constraint(equalTo: viewToPin.bottomAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        }
        
        containerImageView.isUserInteractionEnabled = false
        containerImageView.contentMode = .scaleAspectFill
        containerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerImageView)
        containerImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: .createAspectRatio(value: 17)).isActive = true
        containerImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        containerImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 32)).isActive = true
        containerImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 32)).isActive = true
        
        let containerLabel = UILabel()
        containerLabel.isUserInteractionEnabled = false
        containerLabel.setupLabel(text: containerString, txtColor: .black, font: .sofiaProMedium(ofSize: .createAspectRatio(value: 16)), txtAlignment: .left)
        container.addSubview(containerLabel)
        containerLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: .createAspectRatio(value: 65)).isActive = true
        containerLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
    }
}
