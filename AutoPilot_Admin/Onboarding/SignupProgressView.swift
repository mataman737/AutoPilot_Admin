//
//  SignupProgressView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/3/23.
//

import UIKit

class SignupProgressView: UIView {
    
    var progressBar = UIView()

    override init(frame: CGRect) {
       super.init(frame: frame)
        self.layer.cornerRadius = .createAspectRatio(value: 6)/2
        self.layer.masksToBounds = true
        self.backgroundColor = .black.withAlphaComponent(0.15)
       setupViews()
       
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}

// MARK: VIEWS

extension SignupProgressView {
    func setupViews() {
        progressBar.backgroundColor = .black
        progressBar.layer.cornerRadius = .createAspectRatio(value: 6)/2
        progressBar.layer.masksToBounds = true
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(progressBar)
        progressBar.fillSuperview()
        progressBar.transform = CGAffineTransform(translationX: -.createAspectRatio(value: 100), y: 0)
    }
}

// MARK: ACTIONS

extension SignupProgressView {
    func showProgress() {
        UIView.animate(withDuration: 0.5, animations: {
            self.progressBar.transform = CGAffineTransform(translationX: .createAspectRatio(value: 0), y: 0)
        }) { (success) in
            
        }
    }
    
    func hideProgress() {
        UIView.animate(withDuration: 0.5, animations: {
            self.progressBar.transform = CGAffineTransform(translationX: -.createAspectRatio(value: 100), y: 0)
        }) { (success) in
            
        }
    }
}
