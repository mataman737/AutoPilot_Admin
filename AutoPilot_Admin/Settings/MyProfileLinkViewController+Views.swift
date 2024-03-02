//
//  MyProfileLinkViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import Foundation
import UIKit
import EFQRCode
import PWSwitch

extension MyProfileLinkViewController {
    
    func setupViews() {
        
        if isDarkMode {
            cardContainer.backgroundColor = .themeGray
            textColor = .white
        } else {
            cardContainer.backgroundColor = .white
            textColor = .newBlack
        }
        
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
        mainContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 420)).isActive = true
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
        
        navTitleLabel.textColor = .black
        navTitleLabel.isUserInteractionEnabled = false
        navTitleLabel.textAlignment = .center
        navTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 19))
        navTitleLabel.numberOfLines = 0
        navTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(navTitleLabel)
        navTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        navTitleLabel.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        
        qrImageView.setImageColor(color: textColor)
        qrImageView.contentMode = .scaleAspectFill
        qrImageView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(qrImageView)
        qrImageView.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        qrImageView.centerXAnchor.constraint(equalTo: navTitleLabel.centerXAnchor, constant: 0).isActive = true
        qrImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 182)).isActive = true
        qrImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 182)).isActive = true
        
        spinner.isHidden = false
        spinner.alpha = 1.0
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        mainContainer.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: qrImageView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: qrImageView.centerYAnchor).isActive = true
        
        qrLinkTrackingImageView.alpha = 0
        qrLinkTrackingImageView.image = UIImage(named: "phQR")
        qrLinkTrackingImageView.setImageColor(color: textColor)
        qrLinkTrackingImageView.contentMode = .scaleAspectFill
        qrLinkTrackingImageView.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(qrLinkTrackingImageView)
        qrLinkTrackingImageView.topAnchor.constraint(equalTo: navTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        qrLinkTrackingImageView.centerXAnchor.constraint(equalTo: navTitleLabel.centerXAnchor, constant: 0).isActive = true
        qrLinkTrackingImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 182)).isActive = true
        qrLinkTrackingImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 182)).isActive = true
                
        copyURLButton.addTarget(self, action: #selector(linkCopied), for: .touchUpInside)
        copyURLButton.continueLabel.text = "Copy URL"
        copyURLButton.continueLabel.centerXAnchor.constraint(equalTo: copyURLButton.gradientBG.centerXAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        copyURLButton.crownImageView.image = UIImage(named: "copyImg")
        copyURLButton.layer.zPosition = 2
        copyURLButton.layer.cornerRadius = .createAspectRatio(value: 56)/2
        copyURLButton.layer.masksToBounds = true
        copyURLButton.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(copyURLButton)
        copyURLButton.leadingAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: .createAspectRatio(value: 9.5)).isActive = true
        copyURLButton.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -.createAspectRatio(value: 22)).isActive = true
        copyURLButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -.createAspectRatio(value: 46)).isActive = true
        copyURLButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        shareURLButton.addTarget(self, action: #selector(didTapShareURL), for: .touchUpInside)
        shareURLButton.continueLabel.text = "Share URL"
        shareURLButton.continueLabel.centerXAnchor.constraint(equalTo: shareURLButton.gradientBG.centerXAnchor, constant: .createAspectRatio(value: 13)).isActive = true
        shareURLButton.crownImageView.image = UIImage(named: "shareImg")
        shareURLButton.layer.zPosition = 2
        shareURLButton.layer.cornerRadius = .createAspectRatio(value: 56)/2
        shareURLButton.layer.masksToBounds = true
        shareURLButton.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.addSubview(shareURLButton)
        shareTrailing = shareURLButton.trailingAnchor.constraint(equalTo: mainContainer.centerXAnchor, constant: -.createAspectRatio(value: 9.5))
        shareTrailing.isActive = true
        shareURLButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: .createAspectRatio(value: 22)).isActive = true
        shareURLButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -.createAspectRatio(value: 46)).isActive = true
        shareURLButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
    }
    
}

