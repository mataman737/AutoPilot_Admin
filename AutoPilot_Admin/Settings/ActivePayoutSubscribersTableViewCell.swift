//
//  ActivePayoutSubscribersTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/23/23.
//

import UIKit

class ActivePayoutSubscribersTableViewCell: UITableViewCell {
    
    var payoutContainer = UIView()
    var activeSubscribersContainer = UIView()
    var payoutDetailLabel = UILabel()
    var subDetailLabel = UILabel()
    var payoutLabel = UILabel()
    var subLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: VIEWS

extension ActivePayoutSubscribersTableViewCell {
    func setupViews() {
        
        payoutContainer.backgroundColor = .black.withAlphaComponent(0.1)
        payoutContainer.layer.cornerRadius = .createAspectRatio(value: 11)
        payoutContainer.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(payoutContainer)
        payoutContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        payoutContainer.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -.createAspectRatio(value: 6.5)).isActive = true
        payoutContainer.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        payoutContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 100)).isActive = true
        
        payoutLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 22))
        payoutLabel.textAlignment = .center
        payoutLabel.textColor = .black
        payoutLabel.numberOfLines = 0
        payoutLabel.translatesAutoresizingMaskIntoConstraints = false
        payoutContainer.addSubview(payoutLabel)
        payoutLabel.centerXAnchor.constraint(equalTo: payoutContainer.centerXAnchor).isActive = true
        payoutLabel.centerYAnchor.constraint(equalTo: payoutContainer.centerYAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        
        payoutDetailLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 12))
        payoutDetailLabel.textAlignment = .center
        payoutDetailLabel.textColor = .black.withAlphaComponent(0.5)
        payoutDetailLabel.numberOfLines = 0
        payoutDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        payoutContainer.addSubview(payoutDetailLabel)
        payoutDetailLabel.centerXAnchor.constraint(equalTo: payoutContainer.centerXAnchor).isActive = true
        payoutDetailLabel.topAnchor.constraint(equalTo: payoutLabel.bottomAnchor, constant: .createAspectRatio(value: 9)).isActive = true
        
        activeSubscribersContainer.backgroundColor = .black.withAlphaComponent(0.1)
        activeSubscribersContainer.layer.cornerRadius = .createAspectRatio(value: 11)
        activeSubscribersContainer.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(activeSubscribersContainer)
        activeSubscribersContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        activeSubscribersContainer.leadingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: .createAspectRatio(value: 6.5)).isActive = true
        activeSubscribersContainer.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        activeSubscribersContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 100)).isActive = true
        
        subLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 22))
        subLabel.textAlignment = .center
        subLabel.textColor = .black
        subLabel.numberOfLines = 0
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        activeSubscribersContainer.addSubview(subLabel)
        subLabel.centerXAnchor.constraint(equalTo: activeSubscribersContainer.centerXAnchor).isActive = true
        subLabel.centerYAnchor.constraint(equalTo: activeSubscribersContainer.centerYAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        
        subDetailLabel.text = "Active Subscribers"
        subDetailLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 12))
        subDetailLabel.textAlignment = .center
        subDetailLabel.textColor = .black.withAlphaComponent(0.5)
        subDetailLabel.numberOfLines = 0
        subDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        activeSubscribersContainer.addSubview(subDetailLabel)
        subDetailLabel.centerXAnchor.constraint(equalTo: activeSubscribersContainer.centerXAnchor).isActive = true
        subDetailLabel.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: .createAspectRatio(value: 9)).isActive = true
    }
}
