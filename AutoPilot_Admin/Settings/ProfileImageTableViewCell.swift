//
//  ProfileImageTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import UIKit

class ProfileImageTableViewCell: UITableViewCell {
    
    var profileImageView = UIImageView()
    var dismissArrowImageView = UIImageView()
    var dismissButton = UIButton()
    var nameLabel = UILabel()
    var dateJoinedLabel = UILabel()
    
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

extension ProfileImageTableViewCell {
    
    func setupViews() {
                         
        dismissArrowImageView.isHidden = true
        dismissArrowImageView.image = UIImage(named: "newDownArrow")
        dismissArrowImageView.setImageColor(color: .white)
        dismissArrowImageView.contentMode = .scaleAspectFill
        dismissArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dismissArrowImageView)
        dismissArrowImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 16)).isActive = true
        dismissArrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        dismissArrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 22)).isActive = true
        dismissArrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 22)).isActive = true
        
        nameLabel.textAlignment = .left
        nameLabel.textColor = .newBlack
        nameLabel.font = .sofiaProBold(ofSize: .createAspectRatio(value: 32))
        nameLabel.numberOfLines = 1
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        //nameLabel.topAnchor.constraint(equalTo: dismissArrowImageView.bottomAnchor, constant: .createAspectRatio(value: 36)).isActive = true
        nameLabel.topAnchor.constraint(equalTo: dismissArrowImageView.topAnchor, constant: .createAspectRatio(value: 0)).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 26)).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 98)).isActive = true
        
        dismissButton.isHidden = true
        dismissButton.backgroundColor = .clear
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dismissButton)
        dismissButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: dismissArrowImageView.trailingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: dismissArrowImageView.bottomAnchor, constant: .createAspectRatio(value: 30)).isActive = true
        
        profileImageView.isUserInteractionEnabled = true
        profileImageView.backgroundColor = .clear
        profileImageView.layer.cornerRadius = .createAspectRatio(value: 64)/2
        profileImageView.image = UIImage(named: "")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 22)).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 64)).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 64)).isActive = true
        
        dateJoinedLabel.textAlignment = .left
        dateJoinedLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
        dateJoinedLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 16))
        dateJoinedLabel.numberOfLines = 1
        dateJoinedLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateJoinedLabel)
        dateJoinedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        dateJoinedLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        dateJoinedLabel.trailingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: -.createAspectRatio(value: 20)).isActive = true
    }
    
}



