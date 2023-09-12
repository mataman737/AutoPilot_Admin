//
//  UpdateAccessCodeViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/8/23.
//

import UIKit

protocol UpdateAccessCodeViewControllerDelegate: AnyObject {
    func didUpdateAccessCode()
}

class UpdateAccessCodeViewController: UIViewController {
    
    weak var delegate: UpdateAccessCodeViewControllerDelegate?
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
    var didSetAccessCode = UserDefaults()
        
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
                submitAccessCode(accessCode: tft)
            }
        } else {
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "Invalid Code")
            errorImpactGenerator()
        }
        
        return true
    }
    
    func submitTeamNameUpdate(name: String) {
        guard var team = self.team else { return }
        team.name = name
        API.sharedInstance.updateTeam(team: team) { success, team, error in
            guard error == nil else {
                print("\(error!) 🤌🤌🤌")
                
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
    
    func submitAccessCode(accessCode: String) {
        
        self.didSetAccessCode.set(true, forKey: "didSetAccessCode")
        self.delegate?.didUpdateAccessCode()
        self.successImpactGenerator()
        self.dismissViews()
        
        /*
        guard var team = self.team else {
            print("did this 🫦🫦🫦 000")
            return
        }        
        team.accessCode = accessCode
        API.sharedInstance.updateTeam(team: team) { success, team, error in
            guard error == nil else {
                print("\(error!) 🤌🤌🤌")
                
                DispatchQueue.main.async {
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Code not saved!")
                    self.errorImpactGenerator()
                }
                
                return
            }
            
            guard success, let team = team else {
                print("error submitting promo code 🤌🤌🤌")
                DispatchQueue.main.async {
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Code not saved!")
                    self.errorImpactGenerator()
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("did this 🤌🤌🤌  000")
                self?.didSetAccessCode.set(true, forKey: "didSetAccessCode")
                self?.delegate?.didUpdateAccessCode()
                self?.successImpactGenerator()
                self?.dismissViews()
            }
        }
        */
    }
}
