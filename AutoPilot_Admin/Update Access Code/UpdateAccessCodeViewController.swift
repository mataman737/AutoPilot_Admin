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
    
    var mainScrollView = UIScrollView()
    var wrapper = UIView()
    var mainContainer = UIView()
    var navTitleLabel = UILabel()
    var keyLine = UIView()
    var isDismissing = false
    
    weak var delegate: UpdateAccessCodeViewControllerDelegate?
    var opacityLayer = UIView()
    var cardContainer = UIView()
    var titleLabel = UILabel()
    var downArrow = UIImageView()
    var downButton = UIButton()
    var accessCodeTextContainer = UIView()
    var accessCodeTextField = UITextField()
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

extension UpdateAccessCodeViewController {
    @objc func prsentViews() {
        self.mainContainer.presentAndBounce()
        UIView.animate(withDuration: 0.25) {
            self.opacityLayer.alpha = 0.75
        }
    }
    
    @objc func dismissViews() {
        lightImpactGenerator()
        UIView.animate(withDuration: 0.25) {
            self.view.endEditing(true)
            self.opacityLayer.alpha = 0
            self.mainContainer.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
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
            toastNoti.present(withMessage: "Invalid Access Code")
            errorImpactGenerator()
        }
        
        return true
    }
    
    
    
    func submitAccessCode(accessCode: String) {
        spinner.isHidden = false
        spinner.alpha = 1.0
        guard var team = self.team else {
            print("did this 🫦🫦🫦 000")
            return
        }
        
        team.accessCode = accessCode
        API.sharedInstance.updateTeamAccessCode(team: team) { success, team, error in
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
    }
}

//MARK: SCROLLVIEW DELEGATE

extension UpdateAccessCodeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 1 {
            let yOffset = scrollView.contentOffset.y// + 44
            if yOffset > 0 {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
            
            if yOffset < -45 {
                if !isDismissing {
                    dismissViews()
                    isDismissing = true
                }
            }
        }
    }
}
