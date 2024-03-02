//
//  OptionsView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/6/23.
//

import UIKit

class OptionsView: UIView {
    
    var iconImageView = UIImageView()
    var optionTitleLabel = UILabel()
    var optionDetailLabel = UILabel()
    var optionButton = UIButton()
    var deactiveLabel = UILabel()
    var deactiveBubble = UIView()

    override init(frame: CGRect) {
       super.init(frame: frame)
       self.backgroundColor = .clear
       setupViews()
       
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}

// MARK: Helpers

extension OptionsView {
    
    func setupViews() {
        
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(iconImageView)
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        optionTitleLabel.textColor = .newBlack
        optionTitleLabel.font = .poppinsSemiBold(ofSize: 18)
        optionTitleLabel.textAlignment = .left
        optionTitleLabel.numberOfLines = 1
        optionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(optionTitleLabel)
        optionTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: .createAspectRatio(value: 21)).isActive = true
        optionTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        
        optionDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
        optionDetailLabel.font = .poppinsRegular(ofSize: .createAspectRatio(value: 14))
        optionDetailLabel.textAlignment = .left
        optionDetailLabel.numberOfLines = 0
        optionDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(optionDetailLabel)
        optionDetailLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: .createAspectRatio(value: 21)).isActive = true
        optionDetailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        optionDetailLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        //optionDetailLabel.topAnchor.constraint(equalTo: optionTitleLabel.bottomAnchor, constant: .createAspectRatio(value: 5)).isActive = true
        
        optionButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(optionButton)
        optionButton.fillSuperview()
        
        deactiveLabel.isHidden = true
        deactiveLabel.textColor = .white
        deactiveLabel.layer.zPosition = 2
        deactiveLabel.text = "Deactivated"
        deactiveLabel.textAlignment = .left
        deactiveLabel.font = .poppinsRegular(ofSize: .createAspectRatio(value: 14))
        deactiveLabel.numberOfLines = 0
        deactiveLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deactiveLabel)
        deactiveLabel.leadingAnchor.constraint(equalTo: optionTitleLabel.trailingAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        deactiveLabel.centerYAnchor.constraint(equalTo: optionTitleLabel.centerYAnchor, constant: 0).isActive = true
        
        deactiveBubble.isHidden = true
        deactiveBubble.backgroundColor = .red
        deactiveBubble.layer.cornerRadius = .createAspectRatio(value: 5)
        deactiveBubble.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deactiveBubble)
        deactiveBubble.leadingAnchor.constraint(equalTo: deactiveLabel.leadingAnchor, constant: -.createAspectRatio(value: 5)).isActive = true
        deactiveBubble.trailingAnchor.constraint(equalTo: deactiveLabel.trailingAnchor, constant: .createAspectRatio(value: 5)).isActive = true
        deactiveBubble.centerYAnchor.constraint(equalTo: deactiveLabel.centerYAnchor, constant: -.createAspectRatio(value: 1)).isActive = true
        deactiveBubble.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 18)).isActive = true
        
    }
    
}


