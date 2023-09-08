//
//  EmptyStateView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit

protocol EmptyStateViewDelegate: AnyObject {
    func goToFirstTab()
}

class EmptyStateView: UIView {
    
    var delegate: EmptyStateViewDelegate!
    var lockLabel = UILabel()
    var lockTitleLabel = UILabel()
    var lockDetailLabel = UILabel()
    var squadUpButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: VIEWS

extension EmptyStateView {
    
    func setupViews() {
                       
        lockLabel.alpha = 0
        lockLabel.text = "👋"
        lockLabel.textAlignment = .center
        lockLabel.textColor = .newBlack
        lockLabel.font = .sofiaProSemiBold(ofSize: 40)
        lockLabel.numberOfLines = 0
        lockLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lockLabel)
        lockLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        lockLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        lockTitleLabel.alpha = 0
        lockTitleLabel.text = "Say Hello!"
        lockTitleLabel.textAlignment = .center
        lockTitleLabel.textColor = .newBlack
        lockTitleLabel.font = .sofiaProSemiBold(ofSize: 18)
        lockTitleLabel.numberOfLines = 0
        lockTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lockTitleLabel)
        lockTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        lockTitleLabel.topAnchor.constraint(equalTo: lockLabel.bottomAnchor, constant: 19).isActive = true
        
        lockDetailLabel.alpha = 0
        lockDetailLabel.text = "You can send Darrell a message\nafter you buy his package."
        lockDetailLabel.textAlignment = .center
        lockDetailLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
        lockDetailLabel.font = .sofiaProRegular(ofSize: 14)
        lockDetailLabel.numberOfLines = 0
        lockDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lockDetailLabel)
        lockDetailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        lockDetailLabel.topAnchor.constraint(equalTo: lockTitleLabel.bottomAnchor, constant: 9).isActive = true
        
        squadUpButton.addTarget(self, action: #selector(goToFirstItem), for: .touchUpInside)
        squadUpButton.alpha = 0
        squadUpButton.backgroundColor = UIColor(red: 144/255, green: 97/255, blue: 169/255, alpha: 1.0)
        squadUpButton.setTitle("Browse Darrell's Programs", for: .normal)
        squadUpButton.setTitleColor(.newBlack, for: .normal)
        squadUpButton.titleLabel?.font = .sofiaProRegular(ofSize: 14)
        squadUpButton.layer.cornerRadius = 11
        squadUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(squadUpButton)
        squadUpButton.topAnchor.constraint(equalTo: lockDetailLabel.bottomAnchor, constant: 19).isActive = true
        squadUpButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        squadUpButton.heightAnchor.constraint(equalToConstant: 53).isActive = true
        squadUpButton.widthAnchor.constraint(equalToConstant: 277).isActive = true
        
    }
    
}

//MARK: ACTIONS

extension EmptyStateView {
    func hidViews() {
        hideView(viewToAnimate: lockLabel, delayTime: 0.1)
        hideView(viewToAnimate: lockTitleLabel, delayTime: 0.1)
        hideView(viewToAnimate: lockDetailLabel, delayTime: 0.1)
        hideView(viewToAnimate: squadUpButton, delayTime: 0.1)
    }
    
    func showViews() {
        self.isHidden = false
        showView(viewToAnimate: lockLabel, delayTime: 0.1)
        showView(viewToAnimate: lockTitleLabel, delayTime: 0.15)
        showView(viewToAnimate: lockDetailLabel, delayTime: 0.2)
        showView(viewToAnimate: squadUpButton, delayTime: 0.25)
    }
    
    func showView(viewToAnimate: UIView, delayTime: Double) {
        UIView.animate(withDuration: 0.35, delay: delayTime, options: [], animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            viewToAnimate.alpha = 1.0
        }) { (success) in
            UIView.animate(withDuration: 0.3, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { (success) in
                UIView.animate(withDuration: 0.3, animations: {
                    viewToAnimate.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }) { (success) in
                    //
                }
            }
        }
    }
    
    func hideView(viewToAnimate: UIView, delayTime: Double) {
        UIView.animate(withDuration: 0.35, delay: delayTime, options: [], animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            viewToAnimate.alpha = 0
        }) { (success) in
            self.isHidden = true
        }
    }
    
    @objc func goToFirstItem() {
        lightImpactGenerator()
        self.delegate.goToFirstTab()
    }
}

