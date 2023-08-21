//
//  NoSignalsTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit

class NoSignalsTableViewCell: UITableViewCell {
    
    var noSignalsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//MARK: VIEWS

extension NoSignalsTableViewCell {
    func setupViews() {
        noSignalsLabel.text = "No Signals"
        noSignalsLabel.font = .sofiaProMedium(ofSize: 18)
        noSignalsLabel.textAlignment = .left
        noSignalsLabel.textColor = .red
        noSignalsLabel.numberOfLines = 0
        noSignalsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(noSignalsLabel)
        noSignalsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        noSignalsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        noSignalsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
    }
}

