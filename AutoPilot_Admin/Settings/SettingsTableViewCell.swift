//
//  SettingsTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    var generalImageView = UIImageView()
    var titleLabel = UILabel()
    var arrowImageView = UIImageView()
    var dividerLine = UIView()

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

extension SettingsTableViewCell {
    
    func setupViews() {
        
        generalImageView.contentMode = .scaleAspectFill
        generalImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(generalImageView)
        generalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 22)).isActive = true
        generalImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        generalImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        generalImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 24)).isActive = true
        
        titleLabel.text = "More Options"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white//.white
        titleLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 16))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: generalImageView.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        arrowImageView.image = UIImage(named: "arrowRight")?.imageFlippedForRightToLeftLayoutDirection()
        arrowImageView.setImageColor(color: .white)
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowImageView)
        arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 20)).isActive = true
        
        dividerLine.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 1)).isActive = true
    }
    
}

