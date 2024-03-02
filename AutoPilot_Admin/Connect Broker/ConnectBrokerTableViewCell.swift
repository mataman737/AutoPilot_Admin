//
//  ConnectBrokerTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/11/23.
//

import UIKit

class ConnectBrokerTableViewCell: UITableViewCell {
        
    var brokerLabel = UILabel()
    var dividerLine = UIView()
    var brokerHealth = UIView()
    var isDarkMode = UserDefaults()
    var arrowImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: VIEWS

extension ConnectBrokerTableViewCell {
    func setupViews() {
        brokerLabel.text = "Prevail FX"
        brokerLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 18))
        brokerLabel.textAlignment = .left
        
        brokerLabel.textColor = .black.withAlphaComponent(1.0)
        brokerLabel.numberOfLines = 1
        brokerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(brokerLabel)
        brokerLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .createAspectRatio(value: 36)).isActive = true
        brokerLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.createAspectRatio(value: 56)).isActive = true
        brokerLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        
        dividerLine.backgroundColor = .black.withAlphaComponent(0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .createAspectRatio(value: 36)).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.createAspectRatio(value: 36)).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 1)).isActive = true
        
        brokerHealth.isHidden = true
        brokerHealth.backgroundColor = .liveGreen
        brokerHealth.layer.cornerRadius = .createAspectRatio(value: 10)/2
        brokerHealth.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(brokerHealth)
        brokerHealth.centerYAnchor.constraint(equalTo: brokerLabel.centerYAnchor, constant: .createAspectRatio(value: 0)).isActive = true
        brokerHealth.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.createAspectRatio(value: 36)).isActive = true
        brokerHealth.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 10)).isActive = true
        brokerHealth.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 10)).isActive = true
        
        arrowImageView.isHidden = true
        arrowImageView.image = UIImage(named: "arrowRight")
        arrowImageView.setImageColor(color: .black.withAlphaComponent(0.5))
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(arrowImageView)
        arrowImageView.trailingAnchor.constraint(equalTo: self.dividerLine.trailingAnchor, constant: .createAspectRatio(value: 4)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
}
