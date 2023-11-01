//
//  SetMyFXBookLinkViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 10/11/23.
//

import UIKit

protocol SetMyFXBookLinkViewControllerDelegate: AnyObject {
    func didUpdateAccessCode()
}

class SetMyFXBookLinkViewController: UIViewController {
    
    weak var delegate: SetMyFXBookLinkViewControllerDelegate?
    var opacityLayer = UIView()
    var cardContainer = UIView()
    var titleLabel = UILabel()
    var downArrow = UIImageView()
    var downButton = UIButton()
    var myFXBookTextContainer = UIView()
    var myFXBookLinkTextField = UITextField()
    var didSetAccessCode = UserDefaults()
    var spinner = UIActivityIndicatorView(style: .medium)
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        perform(#selector(prsentViews), with: self, afterDelay: 0.05)
    }
}

//MARK: ACTIONS

extension SetMyFXBookLinkViewController {
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
    
    func isValidURL(_ string: String) -> Bool {
        if let url = URL(string: string), url.scheme != nil {
            // Check if the URL can be constructed and has a valid scheme (e.g., http, https, ftp, etc.)
            return true
        } else {
            return false
        }
    }
}

//MARK: TEXTFIELD DELEGATE

extension SetMyFXBookLinkViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            if let tft = textField.text {
                submitMyFXBookLink(myFXBookString: tft)
            }
        } else {
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "Invalid Link")
            errorImpactGenerator()
        }
        
        return true
    }
    
    
    
    func submitMyFXBookLink(myFXBookString: String) {
        if isValidURL(myFXBookString) {
            print("Valid URL")
            
            guard var team = self.team else {
                print("did this 🫦🫦🫦 000")
                return
            }
            
            team.fxBook = myFXBookString
            API.sharedInstance.updateTeamFXBook(team: team) { success, team, error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        let toastNoti = ToastNotificationView()
                        toastNoti.present(withMessage: "Code not saved!")
                        self.errorImpactGenerator()
                        self.spinner.isHidden = true
                        self.spinner.alpha = 0
                    }
                    
                    return
                }
                
                guard success, let team = team else {
                    DispatchQueue.main.async {
                        let toastNoti = ToastNotificationView()
                        toastNoti.present(withMessage: "Code not saved!")
                        self.errorImpactGenerator()
                        self.spinner.isHidden = true
                        self.spinner.alpha = 0
                    }
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.didSetAccessCode.set(true, forKey: "didSetAccessCode")
                    self?.delegate?.didUpdateAccessCode()
                    self?.successImpactGenerator()
                    self?.dismissViews()
                }
            }
            
        } else {
            print("Invalid URL")
        }
    }
}
