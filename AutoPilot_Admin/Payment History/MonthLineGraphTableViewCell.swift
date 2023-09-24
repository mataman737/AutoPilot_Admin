//
//  MonthLineGraphTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/24/23.
//

import UIKit

class MonthLineGraphTableViewCell: UITableViewCell {
    
    var lineGraphContainer = UIView()
    var lineGraphView = ChartsLineMiniGraphView()
    var monthLabel = UILabel()
    var payoutAmountLabel = UILabel()

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

extension MonthLineGraphTableViewCell {
    func setupViews() {
        lineGraphContainer.layer.masksToBounds = false
        lineGraphContainer.clipsToBounds = false
        lineGraphContainer.backgroundColor = .clear
        lineGraphContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineGraphContainer)
        lineGraphContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        lineGraphContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        lineGraphContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.createAspectRatio(value: 31)).isActive = true
        lineGraphContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 80)).isActive = true
        
        lineGraphView.backgroundColor = .clear
        lineGraphView.translatesAutoresizingMaskIntoConstraints = false
        lineGraphContainer.addSubview(lineGraphView)
        lineGraphView.fillSuperview()
        
        monthLabel.setupLabel(text: "", txtColor: .black, font: .sofiaProSemiBold(ofSize: .createAspectRatio(value: 18)), txtAlignment: .left)
        contentView.addSubview(monthLabel)
        monthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: lineGraphContainer.topAnchor, constant: -.createAspectRatio(value: 31)).isActive = true
        
        payoutAmountLabel.setupLabel(text: "", txtColor: .black, font: .sofiaProSemiBold(ofSize: .createAspectRatio(value: 18)), txtAlignment: .right)
        contentView.addSubview(payoutAmountLabel)
        payoutAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 24)).isActive = true
        payoutAmountLabel.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor).isActive = true
    }
}
