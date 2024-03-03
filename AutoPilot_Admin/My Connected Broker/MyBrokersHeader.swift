//
//  MyBrokersHeader.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/11/23.
//

import Foundation
import UIKit

//MARK: CUSTOM HEADERVIEW

class MyBrokersHeader: UITableViewHeaderFooterView {

    let whiteView = UIView()
    var checkoutTitleLabel = UILabel()
    var numberOfItemsLabel = UILabel()
    var dividerLine = UIView()
    var invisibleButton = UIButton()
    var dismissArrowImageView = UIImageView()
    var dismissButton = UIButton()
    var keyLine = UIView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension MyBrokersHeader {
    func setupViews() {
        keyLine.backgroundColor = .black.withAlphaComponent(0.25)
        keyLine.layer.cornerRadius = .createAspectRatio(value: 4)/2
        keyLine.translatesAutoresizingMaskIntoConstraints = false
        whiteView.addSubview(keyLine)
        keyLine.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor).isActive = true
        keyLine.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        keyLine.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 34)).isActive = true
        keyLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        
        invisibleButton.backgroundColor = .clear
        invisibleButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(invisibleButton)
        invisibleButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        invisibleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        invisibleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        invisibleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 20
        whiteView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        whiteView.layer.masksToBounds = true
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(whiteView)
        whiteView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        whiteView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        whiteView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        whiteView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 80)).isActive = true
        whiteView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        
        checkoutTitleLabel.textAlignment = .center
        checkoutTitleLabel.textColor = UIColor(red: 17/255, green: 18/255, blue: 19/255, alpha: 1.0)
        checkoutTitleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 18))
        checkoutTitleLabel.numberOfLines = 0
        checkoutTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        whiteView.addSubview(checkoutTitleLabel)
        checkoutTitleLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: .createAspectRatio(value: 32)).isActive = true
        checkoutTitleLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor, constant: 0).isActive = true
        
        dismissArrowImageView.image = UIImage(named: "dismissArrowBlack")
        dismissArrowImageView.contentMode = .scaleAspectFill
        dismissArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.addSubview(dismissArrowImageView)
        dismissArrowImageView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        dismissArrowImageView.topAnchor.constraint(equalTo: checkoutTitleLabel.centerYAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        dismissArrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        dismissArrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true

        dismissButton.backgroundColor = .clear
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        whiteView.addSubview(dismissButton)
        dismissButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: whiteView.topAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: dismissArrowImageView.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: dismissArrowImageView.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        
        numberOfItemsLabel.isHidden = true
        numberOfItemsLabel.textAlignment = .center
        numberOfItemsLabel.textColor = UIColor(red: 116/255, green: 117/255, blue: 118/255, alpha: 1.0)
        numberOfItemsLabel.font = .poppinsMedium(ofSize: 15)
        numberOfItemsLabel.numberOfLines = 0
        numberOfItemsLabel.translatesAutoresizingMaskIntoConstraints = false
        whiteView.addSubview(numberOfItemsLabel)
        numberOfItemsLabel.topAnchor.constraint(equalTo: checkoutTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 4)).isActive = true
        numberOfItemsLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor, constant: 0).isActive = true
        
        dividerLine.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 230/255, alpha: 1.0)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        whiteView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
    }
}
