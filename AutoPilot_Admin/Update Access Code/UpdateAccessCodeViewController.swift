//
//  UpdateAccessCodeViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/8/23.
//

import UIKit

class UpdateAccessCodeViewController: UIViewController {
    
    var isDarkMode = UserDefaults()
    var opacityLayer = UIView()
    var cardContainer = UIView()
    var titleLabel = UILabel()
    var downArrow = UIImageView()
    var downButton = UIButton()
    var accessCodeTextContainer = UIView()
    var accessCodeTextField = UITextField()
    var disountPercentLabel = UILabel()
    var discountPercentContainer = UIView()
    var discountPercentTextField = UITextField()
    var bulletOneLabel = UILabel()
    var bulletTwoLabel = UILabel()
    var bulletThreeLabel = UILabel()
        
    var premiumChannelButton = ContinueButton()
    
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        perform(#selector(prsentViews), with: self, afterDelay: 0.05)
    }
}

//MARK: ACTIONS

extension UpdateAccessCodeViewController {
    @objc func prsentViews() {
        UIView.animate(withDuration: 0.25) {
            self.opacityLayer.alpha = 0.75
            self.cardContainer.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc func dismissViews() {
        lightImpactGenerator()
        UIView.animate(withDuration: 0.25) {
            self.view.endEditing(true)
            self.opacityLayer.alpha = 0
            self.cardContainer.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        } completion: { success in
            self.dismiss(animated: false)
        }
    }
}

//MARK: TEXTFIELD DELEGATE

extension UpdateAccessCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            if let tft = textField.text {
                submitAccessCode(promo: tft)
            }
        } else {
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "Invalid Promo")
            errorImpactGenerator()
        }
        
        return true
    }
    
    func submitTeamNameUpdate(name: String) {
        guard var team = self.team else { return }
        team.name = name
        API.sharedInstance.updateTeam(team: team) { success, team, error in
            guard error == nil else {
                //print(error!)
                print("\(error!) 🤌🤌🤌 111 poop")
                
                DispatchQueue.main.async {
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Invalid Promo")
                    self.errorImpactGenerator()
                }
                
                return
            }
            
            guard success, let team = team else {
                print("error submitting promo code 🤌🤌🤌")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("did this 🤌🤌🤌  000")
                let toastNoti = ToastNotificationView()
                toastNoti.present(withMessage: "Promo Applied!")
                self?.successImpactGenerator()
                self?.dismissViews()
            }
        }
    }
    
    func submitAccessCode(promo: String) {
        guard var team = self.team else { return }
        team.accessCode = promo
        API.sharedInstance.updateTeam(team: team) { success, team, error in
            guard error == nil else {
                //print(error!)
                print("\(error!) 🤌🤌🤌 111 poop")
                
                DispatchQueue.main.async {
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Invalid Promo")
                    self.errorImpactGenerator()
                }
                
                return
            }
            
            guard success, let team = team else {
                print("error submitting promo code 🤌🤌🤌")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("did this 🤌🤌🤌  000")
                let toastNoti = ToastNotificationView()
                toastNoti.present(withMessage: "Promo Applied!")
                self?.successImpactGenerator()
                self?.dismissViews()
            }
        }
    }
}
