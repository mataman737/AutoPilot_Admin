//
//  SubscriberCountTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/24/23.
//

import UIKit

class SubscriberCountTableViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var monthStartLabel = UILabel()
    var arrowImageView = UIImageView()
    var monthEndLabel = UILabel()
    var percentChangeLabel = UILabel()
    
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

extension SubscriberCountTableViewCell {
    func setupViews() {
        
        titleLabel.text = "Total Subscribers"
        titleLabel.textAlignment = .left
        titleLabel.textColor = .newBlack.withAlphaComponent(0.5)
        titleLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: .createAspectRatio(value: 11)).isActive = true
        
        monthStartLabel.text = "190"
        monthStartLabel.textAlignment = .left
        monthStartLabel.textColor = .newBlack
        monthStartLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 18))
        monthStartLabel.numberOfLines = 0
        monthStartLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(monthStartLabel)
        monthStartLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        monthStartLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        
        arrowImageView.image = UIImage(named: "subArrow")
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(arrowImageView)
        arrowImageView.leadingAnchor.constraint(equalTo: monthStartLabel.trailingAnchor, constant: .createAspectRatio(value: 7)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: monthStartLabel.centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 5.77)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 33)).isActive = true
        
        monthEndLabel.text = "280"
        monthEndLabel.textAlignment = .left
        monthEndLabel.textColor = .newBlack
        monthEndLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 18))
        monthEndLabel.numberOfLines = 0
        monthEndLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(monthEndLabel)
        monthEndLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: .createAspectRatio(value: 7)).isActive = true
        monthEndLabel.centerYAnchor.constraint(equalTo: monthStartLabel.centerYAnchor).isActive = true
        
        percentChangeLabel.text = "+47.37%"
        percentChangeLabel.textAlignment = .right
        percentChangeLabel.textColor = UIColor(red: 70/255, green: 192/255, blue: 83/255, alpha: 1.0)
        percentChangeLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 18))
        percentChangeLabel.numberOfLines = 0
        percentChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(percentChangeLabel)
        percentChangeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        percentChangeLabel.centerYAnchor.constraint(equalTo: monthStartLabel.centerYAnchor).isActive = true
    }
}
