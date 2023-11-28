//
//  AddTraderViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 10/3/23.
//

import UIKit
import FlagPhoneNumber

protocol AddTraderViewControllerDelegate: AnyObject {
    func didUpdateAccessCode()
}

class AddTraderViewController: UIViewController {
    
    weak var delegate: AddTraderViewControllerDelegate?
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
    var phoneNumberTextField = FPNTextField()
    var nextButton = ContinueButton()
    var phoneNubmerIsValid = false
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        perform(#selector(prsentViews), with: self, afterDelay: 0.05)
    }
}

//MARK: ACTIONS

extension AddTraderViewController {
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

extension AddTraderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /*
        if textField.text != "" {
            if let tft = textField.text {
                submitAccessCode(accessCode: tft)
            }
        } else {
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "Invalid Access Code")
            errorImpactGenerator()
        }
        */
        return true
    }
    
    @objc func inviteMemberToTeam() {
        lightImpactGenerator()
        
        if phoneNubmerIsValid && phoneNumber != "" {
            guard let teamIdString = Admin.current.teamId, let teamId = UUID(uuidString: teamIdString) else {
                print("no team id")
                return
            }
            
            API.sharedInstance.inviteMemberToTeam(pendingAdminRequest: PendingAdminRequest(teamId: teamId, name: "Name", phone: phoneNumber, adminType: "trader")) { success, _, error in
                guard error == nil else {
                    print(error!)
                    DispatchQueue.main.async {
                        self.presentError()
                    }
                    return
                }
                
                guard success else {
                    print("error adding team member")
                    DispatchQueue.main.async {
                        self.presentError()
                    }
                    
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    //team member added
                    self?.dismissViews()
                    self?.presentSuccessToast()
                }
            }
        } else {
            errorImpactGenerator()
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "Invalid phone number!")
        }
    }
    
    func presentSuccessToast() {
        successImpactGenerator()
        let toastNoti = ToastNotificationView()
        toastNoti.present(withMessage: "Invite sent!")
    }
    
    func presentError() {
        errorImpactGenerator()
        let toastNoti = ToastNotificationView()
        toastNoti.present(withMessage: "Error sending invite!")
    }
}

//MARK: FLAG DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension AddTraderViewController: FPNTextFieldDelegate, FPNTextFieldDelegateTwo {
    func didDismissCountries() {
        print("did this 🤡🤡🤡")
        self.phoneNumberTextField.becomeFirstResponder()
        //self.phoneNumberTextField.inputAccessoryView = accessoryContainer
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
        if isValid {
            print("valid!!!")
            phoneNubmerIsValid = true
        } else {
            print("Invalid!!!")
            phoneNubmerIsValid = false
        }
        
        guard let number = textField.getFormattedPhoneNumber(format: FPNFormat.E164), isValid else {
            //disableContinue()
            return
        }
        
        self.phoneNumber = number
    }
    
    func fpnDisplayCountryList() {
        //
    }
    
    
}
