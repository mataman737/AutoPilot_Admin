//
//  TeamMemberTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/9/23.
//

import UIKit

class TeamMemberTableViewCell: UITableViewCell {
    
    var circleEmptyStateImageView = UIImageView()
    var circleImageView = UIImageView()
    var arrowImageView = UIImageView()
    var chatNameLabel = UILabel()
    var chatDescriptionLabel = UILabel()
    var last30DayPercentChange = UILabel()

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

extension TeamMemberTableViewCell {
    func setupViews() {
        circleEmptyStateImageView.image = UIImage(named: "enigmaUserPH")
        circleEmptyStateImageView.layer.cornerRadius = .createAspectRatio(value: 57)/2
        circleEmptyStateImageView.layer.masksToBounds = true
        circleEmptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(circleEmptyStateImageView)
        circleEmptyStateImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        circleEmptyStateImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        circleEmptyStateImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 57)).isActive = true
        circleEmptyStateImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 57)).isActive = true
                
        circleImageView.layer.cornerRadius = .createAspectRatio(value: 57)/2
        circleImageView.layer.masksToBounds = true
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(circleImageView)
        circleImageView.centerXAnchor.constraint(equalTo: circleEmptyStateImageView.centerXAnchor).isActive = true
        circleImageView.centerYAnchor.constraint(equalTo: circleEmptyStateImageView.centerYAnchor).isActive = true
        circleImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 57)).isActive = true
        circleImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 57)).isActive = true
        
        arrowImageView.image = UIImage(named: "channelArrow")
        arrowImageView.setImageColor(color: .black.withAlphaComponent(0.35))
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowImageView)
        arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        
        chatNameLabel.text = "Community"
        chatNameLabel.font = .poppinsSemiBold(ofSize: .createAspectRatio(value: 21))
        chatNameLabel.textColor = .black
        chatNameLabel.numberOfLines = 1
        chatNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chatNameLabel)
        chatNameLabel.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        chatNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 50)).isActive = true
        chatNameLabel.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor, constant: -.createAspectRatio(value: 9)).isActive = true
        
        chatDescriptionLabel.text = "Lorem ipsum dolor sit amet"
        chatDescriptionLabel.font = .poppinsRegular(ofSize: .createAspectRatio(value: 12))
        chatDescriptionLabel.textColor = .black.withAlphaComponent(0.5)
        chatDescriptionLabel.numberOfLines = 0
        chatDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chatDescriptionLabel)
        chatDescriptionLabel.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        chatDescriptionLabel.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor, constant: .createAspectRatio(value: 9)).isActive = true
        
        last30DayPercentChange.text = "0%"
        last30DayPercentChange.textAlignment = .right
        last30DayPercentChange.font = .poppinsSemiBold(ofSize: .createAspectRatio(value: 16))
        last30DayPercentChange.textColor = .liveDataGreen
        last30DayPercentChange.numberOfLines = 0
        last30DayPercentChange.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(last30DayPercentChange)
        last30DayPercentChange.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -.createAspectRatio(value: 8)).isActive = true
        last30DayPercentChange.centerYAnchor.constraint(equalTo: arrowImageView.centerYAnchor).isActive = true
    }
}
