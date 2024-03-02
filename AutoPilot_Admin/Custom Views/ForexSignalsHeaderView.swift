//
//  ForexSignalsHeaderView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit

class ForexSignalsHeaderView: UIView {
    
    var dateLabel = UILabel()
    var signalCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: VIEWS

extension ForexSignalsHeaderView {
    func setupViews() {
        
        dateLabel.font = .poppinsMedium(ofSize: 18)
        dateLabel.textAlignment = .left
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        signalCountLabel.font = .poppinsMedium(ofSize: 18)
        signalCountLabel.textAlignment = .left
        signalCountLabel.textColor = .black
        signalCountLabel.numberOfLines = 0
        signalCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(signalCountLabel)
        signalCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        signalCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
    }
}

class ActivePendingHeaderView: UIView {
    
    var sectionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: VIEWS

extension ActivePendingHeaderView {
    func setupViews() {
        sectionLabel.textAlignment = .left
        sectionLabel.font = .poppinsSemiBold(ofSize: .createAspectRatio(value: 18))
        sectionLabel.textColor = .black.withAlphaComponent(0.5)
        sectionLabel.numberOfLines = 0
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sectionLabel)
        sectionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        sectionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.createAspectRatio(value: 18)).isActive = true
    }
}

