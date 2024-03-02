//
//  TeamMembersEmptyStateCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/12/23.
//

import Foundation
import UIKit

class TeamMembersEmptyStateCell: UITableViewCell {

    var teamMemberEmptyState = EmptyStateView()
    var emptyStateLabel = UILabel()
    
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

extension TeamMembersEmptyStateCell {
    func setupViews() {
        /*
        teamMemberEmptyState.isHidden = false
        teamMemberEmptyState.showViews()
        teamMemberEmptyState.lockLabel.text = "🦄"
        //teamMemberEmptyState.lockTitleLabel.text = "No Team Members"
        teamMemberEmptyState.lockDetailLabel.setupLineHeight(myText: "Everyone that joins your team\nwill show up here. Team members\nare active paid subscribers.", myLineSpacing: 4)
        teamMemberEmptyState.lockDetailLabel.textAlignment = .left
        teamMemberEmptyState.squadUpButton.setTitle("Browse Darrell's Program", for: .normal)
        teamMemberEmptyState.squadUpButton.isHidden = true
        teamMemberEmptyState.backgroundColor = .clear
        teamMemberEmptyState.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(teamMemberEmptyState)
        teamMemberEmptyState.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        teamMemberEmptyState.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        teamMemberEmptyState.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 245)).isActive = true
        teamMemberEmptyState.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 305)).isActive = true
        */
        
        emptyStateLabel.setupLabel(text: "", txtColor: .black.withAlphaComponent(0.5), font: .poppinsRegular(ofSize: .createAspectRatio(value: 12)), txtAlignment: .left)
        self.contentView.addSubview(emptyStateLabel)
        emptyStateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        emptyStateLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
    }
}
