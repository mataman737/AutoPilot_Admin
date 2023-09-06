//
//  SettingsSwitchImageTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import UIKit
import PWSwitch

class SettingsSwitchImageTableViewCell: UITableViewCell {

    var isNVUDemo = UserDefaults()
    var titleLabel = UILabel()
    var arrowImageView = UIImageView()
    var generalImageView = UIImageView()
    var pwSwitchContainer = UIView()
    var pwSwitch = PWSwitch()
    var dividerLine = UIView()
    var isDarkMode = UserDefaults()

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

extension SettingsSwitchImageTableViewCell {
    
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
        titleLabel.textColor = .white
        titleLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 16))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: generalImageView.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        dividerLine.backgroundColor = UIColor.newBlack.withAlphaComponent(0.12)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 1)).isActive = true
                        
        pwSwitchContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pwSwitchContainer)
        pwSwitchContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        pwSwitchContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        pwSwitchContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 26)).isActive = true
        pwSwitchContainer.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 50)).isActive = true

        pwSwitch = PWSwitch(frame: CGRect(x: 0, y: 0, width: .createAspectRatio(value: 50), height: .createAspectRatio(value: 26)))
        pwSwitch.layer.cornerRadius = .createAspectRatio(value: 26)/2
        pwSwitch.layer.masksToBounds = true
        //pwSwitch.backgroundColor = .red
        
        //track
        pwSwitch.trackOnFillColor = isNVUDemo.bool(forKey: "isNVUDemo") ? .swBlue : .themeOrange
        pwSwitch.trackOffBorderColor = isDarkMode.bool(forKey: "isDarkMode") ? .darkModeCardBackground : UIColor(red: 218/255, green: 219/255, blue: 221/255, alpha: 1.0)
        pwSwitch.trackOnBorderColor = isNVUDemo.bool(forKey: "isNVUDemo") ? .swBlue : .themeOrange
        pwSwitch.trackOffFillColor = isDarkMode.bool(forKey: "isDarkMode") ? .darkModeCardBackground : .newBlack.withAlphaComponent(0.12)//UIColor(red: 244/255, green: 245/255, blue: 247/255, alpha: 1.0)
        pwSwitch.trackOnBorderColor = isNVUDemo.bool(forKey: "isNVUDemo") ? .swBlue : .themeOrange
        pwSwitch.trackOffPushBorderColor = .blue
        
        //thumb
        pwSwitch.thumbOffFillColor = .white//UIColor(red: 27/255, green: 28/255, blue: 30/255, alpha: 1.0)
        pwSwitch.thumbOnFillColor = .white
        pwSwitch.thumbOffBorderColor = .white//UIColor(red: 27/255, green: 28/255, blue: 30/255, alpha: 1.0)
        pwSwitch.thumbOnBorderColor = .white
        
        contentView.addSubview(pwSwitch)
        pwSwitch.setOn(false, animated: true)
        //pwSwitch.addTarget(self, action: #selector(self.onSwitchChanged), for: .valueChanged)
        if pwSwitch.on {
            //do something is switch is on
        }
        pwSwitchContainer.addSubview(pwSwitch)
        
    }
    
}

