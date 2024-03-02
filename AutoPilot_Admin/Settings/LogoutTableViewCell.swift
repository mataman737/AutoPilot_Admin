//
//  LogoutTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    var titleLabel = UILabel()

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

extension LogoutTableViewCell {
    func setupViews() {
        titleLabel.text = "Log out"//.localiz()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(red: 244/255, green: 77/255, blue: 77/255, alpha: 1.0)
        titleLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 14))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 22)).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.createAspectRatio(value: 15)).isActive = true
    }
}
