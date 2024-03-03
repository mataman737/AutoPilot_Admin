//
//  LotSizePercentSwitchView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 1/8/24.
//

import UIKit

protocol LotSizePercentSwitchViewDelegate: AnyObject {
    func didTapSwitchOption(option: Int)
}

class LotSizePercentSwitchView: UIView {
    
    weak var delegate: LotSizePercentSwitchViewDelegate?
    var lotSizeContainer = UIButton()
    var percentContainer = UIButton()
    var lotSizeLabel = UILabel()
    var percentLabel = UILabel()
    var switchView = UIView()
    var switchCenter: NSLayoutConstraint!

    override init(frame: CGRect) {
       super.init(frame: frame)
        self.backgroundColor = .black.withAlphaComponent(0.35)
        self.layer.cornerRadius = .createAspectRatio(value: 29) / 2
        self.layer.masksToBounds = true
        setupViews()
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}

// MARK: VIEWS

extension LotSizePercentSwitchView {
    func setupViews() {
        
        lotSizeContainer.layer.zPosition = 2
        lotSizeContainer.tag = 0
        lotSizeContainer.addTarget(self, action: #selector(didTapOption(sender:)), for: .touchUpInside)
        lotSizeContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lotSizeContainer)
        lotSizeContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lotSizeContainer.trailingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lotSizeContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lotSizeContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        percentContainer.layer.zPosition = 2
        percentContainer.tag = 1
        percentContainer.addTarget(self, action: #selector(didTapOption(sender:)), for: .touchUpInside)
        percentContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(percentContainer)
        percentContainer.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        percentContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        percentContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        percentContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        lotSizeLabel.isUserInteractionEnabled = false
        lotSizeLabel.setupLabel(text: "Enabled", txtColor: .white, font: .poppinsSemiBold(ofSize: .createAspectRatio(value: 14)), txtAlignment: .center)
        lotSizeContainer.addSubview(lotSizeLabel)
        lotSizeLabel.leadingAnchor.constraint(equalTo: lotSizeContainer.leadingAnchor).isActive = true
        lotSizeLabel.trailingAnchor.constraint(equalTo: lotSizeContainer.trailingAnchor).isActive = true
        lotSizeLabel.topAnchor.constraint(equalTo: lotSizeContainer.topAnchor).isActive = true
        lotSizeLabel.bottomAnchor.constraint(equalTo: lotSizeContainer.bottomAnchor).isActive = true
        
        percentLabel.isUserInteractionEnabled = false
        percentLabel.alpha = 0.5
        percentLabel.setupLabel(text: "Disabled", txtColor: .white, font: .poppinsSemiBold(ofSize: .createAspectRatio(value: 14)), txtAlignment: .center)
        percentContainer.addSubview(percentLabel)
        percentLabel.leadingAnchor.constraint(equalTo: percentContainer.leadingAnchor).isActive = true
        percentLabel.trailingAnchor.constraint(equalTo: percentContainer.trailingAnchor).isActive = true
        percentLabel.topAnchor.constraint(equalTo: percentContainer.topAnchor).isActive = true
        percentLabel.bottomAnchor.constraint(equalTo: percentContainer.bottomAnchor).isActive = true
        
        switchView.isUserInteractionEnabled = false
        switchView.backgroundColor = .black
        switchView.layer.cornerRadius = .createAspectRatio(value: 25)/2
        switchView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(switchView)
        switchView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 25)).isActive = true
        switchView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 86)).isActive = true
        switchView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        switchCenter = switchView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -.createAspectRatio(value: 43))
        switchCenter.isActive = true
                
    }
}

// MARK: ACTIONS

extension LotSizePercentSwitchView {
    @objc func didTapOption(sender: UIButton) {
        lightImpactGenerator()
        if sender.tag == 0 {
            delegate?.didTapSwitchOption(option: 0)
            switchCenter.constant = -.createAspectRatio(value: 43)
        } else {
            delegate?.didTapSwitchOption(option: 1)
            switchCenter.constant = .createAspectRatio(value: 43)
        }
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
            if sender.tag == 0 {
                self.lotSizeLabel.alpha = 1.0
                self.percentLabel.alpha = 0.5
            } else {
                self.lotSizeLabel.alpha = 0.5
                self.percentLabel.alpha = 1.0
            }
        }
    }
    
    @objc func tradingIsFalse() {
        switchCenter.constant = .createAspectRatio(value: 43)
        self.lotSizeLabel.alpha = 0.25
        self.percentLabel.alpha = 1.0
    }
    
    @objc func tradingIsTrue() {
        switchCenter.constant = -.createAspectRatio(value: 43)
        self.lotSizeLabel.alpha = 1.0
        self.percentLabel.alpha = 0.25
    }
}
