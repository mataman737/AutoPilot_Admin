//
//  MyTradersViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 10/3/23.
//

import Foundation
import UIKit
import Lottie
import Lottie

extension MyTradersViewController {
    func setupNav() {
        
        view.backgroundColor = .white//UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
        
        navView.backgroundColor = .white
        navView.backgroundColor = UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
        navView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 90)).isActive = true
        
        backImageView.image = UIImage(named: "plusImg")
        backImageView.setImageColor(color: .black)
        backImageView.contentMode = .scaleAspectFill
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backImageView)
        backImageView.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: -.createAspectRatio(value: 13)).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -.createAspectRatio(value: 8)).isActive = true
        backImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        backImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        plusButton.addTarget(self, action: #selector(goToAddTrader), for: .touchUpInside)
        plusButton.backgroundColor = .clear
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(plusButton)
        plusButton.trailingAnchor.constraint(equalTo: navView.trailingAnchor).isActive = true
        plusButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: -.createAspectRatio(value: 20)).isActive = true
        
        titleLabel.text = "My Traders"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .newBlack
        titleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: navView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor).isActive = true
        
        dividerLine.backgroundColor = UIColor.newBlack.withAlphaComponent(0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: navView.leadingAnchor).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: navView.trailingAnchor).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
                
        bellImageView.image = UIImage(named: "xImage")
        bellImageView.setImageColor(color: .black)
        bellImageView.contentMode = .scaleAspectFill
        bellImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(bellImageView)
        bellImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: .createAspectRatio(value: 17)).isActive = true
        bellImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        bellImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        bellImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        bellButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        bellButton.backgroundColor = .clear
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(bellButton)
        bellButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor).isActive = true
        bellButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        bellButton.bottomAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        bellButton.trailingAnchor.constraint(equalTo: bellImageView.trailingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
    }
    
    func setupTableView() {
        mainfeedTableView = UITableView(frame: self.view.frame, style: .plain)
        mainfeedTableView.alpha = 1.0
        mainfeedTableView.isScrollEnabled = true
        mainfeedTableView.backgroundColor = .clear
        mainfeedTableView.delegate = self
        mainfeedTableView.dataSource = self
        mainfeedTableView.register(TeamMemberTableViewCell.self, forCellReuseIdentifier: teamMemberTableViewCell)
        mainfeedTableView.allowsSelection = true
        mainfeedTableView.allowsMultipleSelection = false
        mainfeedTableView.contentInset = .zero
        mainfeedTableView.showsVerticalScrollIndicator = false
        mainfeedTableView.separatorStyle = .none
        mainfeedTableView.contentInset = UIEdgeInsets(top: .createAspectRatio(value: 20), left: 0, bottom: 100, right: 0)
        mainfeedTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainfeedTableView)
        mainfeedTableView.topAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        mainfeedTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainfeedTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainfeedTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setupLoadingIndicator() {
        
        loadingContainer.isHidden = false
        loadingContainer.alpha = 1.0
        loadingContainer.backgroundColor = .white//UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingContainer)
        loadingContainer.topAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        loadingContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loadingContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loadingContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let checkAnimation = LottieAnimation.named("tripleSpinner")
        loadingLottie.isUserInteractionEnabled = false
        loadingLottie.alpha = 1.0
        loadingLottie.loopMode = .loop
        loadingLottie.animation = checkAnimation
        loadingLottie.contentMode = .scaleAspectFill
        loadingLottie.backgroundColor = .clear
        loadingLottie.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.addSubview(loadingLottie)
        loadingLottie.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor).isActive = true
        loadingLottie.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor).isActive = true
        loadingLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingLottie.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingLottie.play()
        //print("😀😀😀 - \(loadingLottie.logHierarchyKeypaths()) - 😀😀😀")
    
        var i = 0
        let loadingLayers = ["Shape Layer 1.Ellipse 1.Stroke 1.Color", "Shape Layer 2.Ellipse 1.Stroke 1.Color", "Shape Layer 3.Ellipse 1.Stroke 1.Color"]
        for layer in 1...loadingLayers.count {
            let keyPath = AnimationKeypath(keypath: "\(loadingLayers[layer - 1])")
            if i == 0 {
                let colorProvider = ColorValueProvider(UIColor(red: 225/255, green: 61/255, blue: 227/255, alpha: 1.0).lottieColorValue)
                loadingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 1 {
                let colorProvider = ColorValueProvider(UIColor(red: 229/255, green: 93/255, blue: 132/255, alpha: 1.0).lottieColorValue)
                loadingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else {
                let colorProvider = ColorValueProvider(UIColor(red: 232/255, green: 121/255, blue: 47/255, alpha: 1.0).lottieColorValue)
                loadingLottie.setValueProvider(colorProvider, keypath: keyPath)
            }
            i += 1
        }
    }
}
