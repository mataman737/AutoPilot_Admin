//
//  MyConnectedBrokerAccountViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/11/23.
//

import Foundation
import UIKit

extension MyConnectedBrokerAccountViewController {
    
    func setupColors() {
        if isDarkMode.bool(forKey: "isDarkMode") {
            
        } else {
            
        }
    }
    
    func setupViews() {
        
        let blackTapped = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        blackLayer.isUserInteractionEnabled = true
        blackLayer.addGestureRecognizer(blackTapped)
        blackLayer.backgroundColor = .black
        blackLayer.alpha = 0
        blackLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(blackLayer)
        blackLayer.fillSuperview()
        
        contentContainer.backgroundColor = .clear//.red.withAlphaComponent(0.5)
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentContainer)
        contentContainer.fillSuperview()
        contentContainer.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        myBrokersTableView = UITableView(frame: self.view.frame, style: .grouped)
        myBrokersTableView.layer.zPosition = 2
        myBrokersTableView.isScrollEnabled = false
        myBrokersTableView.backgroundColor = .clear
        myBrokersTableView.delegate = self
        myBrokersTableView.dataSource = self        
        myBrokersTableView.register(MyBrokerOptionsTableViewCell.self, forCellReuseIdentifier: myBrokerOptionsTableViewCell)
        myBrokersTableView.register(MyBrokersHeader.self, forHeaderFooterViewReuseIdentifier: tableViewHeaderFooterReuseIdentifier)
        myBrokersTableView.contentInset = .zero
        myBrokersTableView.showsVerticalScrollIndicator = false
        myBrokersTableView.separatorStyle = .none
        myBrokersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        myBrokersTableView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(myBrokersTableView)
        myBrokersTableView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: 0).isActive = true
        //tableTop.isActive = true
        myBrokersTableView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 0).isActive = true
        myBrokersTableView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: 0).isActive = true
        myBrokersTableView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        //myBrokersTableView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        myBrokersTableView.selectRow(at: IndexPath(item: selectedOption, section: 0), animated: false, scrollPosition: .none)
        
        //myBrokersTableView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        var t = CGAffineTransform.identity
        //t = t.translatedBy(x: 0, y: view.frame.height)
        t = t.rotated(by: CGFloat(M_PI))
        // ... add as many as you want, then apply it to to the view
        myBrokersTableView.transform = t
        
        whiteBGView.isHidden = true
        whiteBGView.isUserInteractionEnabled = false
        whiteBGView.backgroundColor = .white
        whiteBGView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(whiteBGView)
        whiteBGView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true
        whiteBGView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        whiteBGView.bottomAnchor.constraint(equalTo: myBrokersTableView.bottomAnchor).isActive = true
        whiteBGView.topAnchor.constraint(equalTo: myBrokersTableView.topAnchor, constant: 465).isActive = true
        
        confirmButton.isHidden = true
        confirmButton.layer.zPosition = 3
        confirmButton.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
        confirmButton.backgroundColor = .themeBlack
        confirmButton.continueLabel.text = "Confirm"
        confirmButton.continueLabel.font = .poppinsBold(ofSize: 16)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = .poppinsMedium(ofSize: 19)
        confirmButton.layer.cornerRadius = 10
        confirmButton.layer.masksToBounds = true
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(confirmButton)
        confirmButton.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 20).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -20).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: myBrokersTableView.bottomAnchor, constant: -18).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        
        //Alert View
        
        confirmView.delegate = self
        confirmView.confirmLabel.text = "CONFIRM"
        confirmView.confirmLabel.textColor = .themeBlack
        confirmView.confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        confirmView.layer.zPosition = 10
        confirmView.isHidden = true
        confirmView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(confirmView)
        confirmView.fillSuperview()
        
    }
}

