//
//  UpgradeAccountButton.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import UIKit

class UpgradeAccountButton: UIButton {

    var isNVUDemo = UserDefaults()
    var gradientBG = UIImageView()
    var continueLabel = UILabel()
    var crownImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: VIEWS

extension UpgradeAccountButton {
    
    func setupViews() {
        gradientBG.image = UIImage(named: "buttonGradientNVU")
        gradientBG.contentMode = .scaleAspectFill
        gradientBG.isUserInteractionEnabled = false
        gradientBG.backgroundColor = .clear
        gradientBG.layer.cornerRadius = .createAspectRatio(value: 56)/2
        gradientBG.layer.masksToBounds = true
        gradientBG.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(gradientBG)
        gradientBG.fillSuperview()
        
        continueLabel.isUserInteractionEnabled = false
        continueLabel.textAlignment = .center
        continueLabel.textColor = .white
        continueLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 16))
        continueLabel.numberOfLines = 0
        continueLabel.translatesAutoresizingMaskIntoConstraints = false
        gradientBG.addSubview(continueLabel)
        continueLabel.centerYAnchor.constraint(equalTo: gradientBG.centerYAnchor).isActive = true
        
        crownImageView.contentMode = .scaleAspectFill
        crownImageView.translatesAutoresizingMaskIntoConstraints = false
        gradientBG.addSubview(crownImageView)
        crownImageView.trailingAnchor.constraint(equalTo: continueLabel.leadingAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        crownImageView.centerYAnchor.constraint(equalTo: gradientBG.centerYAnchor).isActive = true
        crownImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        crownImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
    }
}

