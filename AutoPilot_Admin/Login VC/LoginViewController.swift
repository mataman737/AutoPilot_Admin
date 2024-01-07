//
//  LoginViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 12/18/23.
//

import StreamChat
import UIKit
import PhotoCircleCrop
import WXImageCompress
import StreamChat

protocol LoginViewControllerDelegate {
    func didGoReturnToSplash()
}

class LoginViewController: UIViewController {

    var transitionView = UIView()
    var appLogoImageView = UIImageView()
    let fromLogin = UserDefaults()
    var delegate: LoginViewControllerDelegate!
    var navView = UIView()
    var xImageView = UIImageView()
    var progressZero = SignupProgressView()
    var progressOne = SignupProgressView()
    var emailContainerView = UIView()
    var phoneNumberTextField = FPNTextField()
    let accessoryContainer = UIView()
    var codeTextField = OneTimeCodeTextField()
    var nextButton = ContinueButton()
    var dismissButton = UIButton()
    var mainScrollView = UIScrollView()
    var phoneNumberContainer = UIView()
    var codeContainer = UIView()
    var phoneNubmerIsValid = false
    var phoneNumber = ""
    var dismissImageView = UIImageView()
    var isStepOne = true
    var fromSignUp = UserDefaults()
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersRegion()
        setupViews()
        setupTransition()
        
        self.perform(#selector(animateFirstProgress), with: self, afterDelay: 0.5)
    }
    
    func getUsersRegion() {
        // Get the user's current locale
        let userLocale = Locale.current
        let demoSpecificRegion = false

        // Extract the country code from the user's locale
        if let countryCode = userLocale.region?.identifier {
            if demoSpecificRegion {
                if #available(iOS 16, *) {
                    let region = Locale.Region.brazil.identifier
                    
                    // Convert the country code to an integer
                    if let country = FPNCountryCode(rawValue: region) {
                        // Set the flag using the country code
                        //print("\(country) 🤓🤓🤓")
                        print("doing this 🫦🫦🫦 000")
                        //usersCountry = country
                        phoneNumberTextField.setFlag(countryCode: country)
                    } else {
                        // Handle the case where the user's locale doesn't provide a valid country code
                        print("doing this 🫦🫦🫦 222")
                    }
                } else {
                    // Fallback on earlier versions
                    print("doing this 🫦🫦🫦 111")
                }
            } else {
                if let country = FPNCountryCode(rawValue: countryCode) {
                    // Set the flag using the country code
                    //print("\(country) 🤓🤓🤓")
                    //usersCountry = country
                    phoneNumberTextField.setFlag(countryCode: country)
                } else {
                    // Handle the case where the user's locale doesn't provide a valid country code
                }
            }
        } else {
            // Handle the case where the user's locale doesn't provide a country code
        }
    }

}

//MARK: TEXTFIELD DELEGATE

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 2 {
            phoneNumberTextField.inputAccessoryView = accessoryContainer
        }
    }
}

//MARK: FLAG DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension LoginViewController: FPNTextFieldDelegate, FPNTextFieldDelegateTwo {
    func didDismissCountries() {
        self.phoneNumberTextField.becomeFirstResponder()
        self.phoneNumberTextField.inputAccessoryView = accessoryContainer
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

//MARK: ACTIONS ------------------------------------------------------------------------------------------------------------------------------------

extension LoginViewController {
    @objc func animateFirstProgress() {
        self.progressZero.showProgress()
    }
    
    @objc func nextTapped() {
        if isStepOne {
            
            if phoneNubmerIsValid {
                print("\(phoneNumber) 😪😪😪")
                nextButton.showLoader()
                nextButton.isUserInteractionEnabled = false
                API.sharedInstance.sendSMSVerify(user: AdminSignup(phone: phoneNumber)) { (success, _, error) in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    
                    guard success else {
                        print("error getting on wait list")
                        return
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.codeTextField.becomeFirstResponder()
                        self?.showOTC()
                        self?.progressOne.showProgress()
                        self?.isStepOne = false
                        self?.nextButton.showOriginalLabel()
                        self?.nextButton.isUserInteractionEnabled = true
                    }
                }
            } else {
                errorImpactGenerator()
                phoneNumberContainer.badWiggle()
            }
            
        } else {
            nextButton.showLoader()
            nextButton.isUserInteractionEnabled = false
            API.sharedInstance.sendSMSVerifyLogin(loginRequest: SMSLoginAttempt(code: codeTextField.text ?? "", phone: phoneNumber, displayName: "")) { [weak self] (success, admin, error, statusCode) in                
                if error != nil {
                    DispatchQueue.main.async {
                        print("failed verifying sms code")
                        print(error!)
                    }
                    return
                }
                guard success else {
                    guard let statusCode = statusCode else {
                        DispatchQueue.main.async {
                            print("failed verifying sms")
                        }
                        return
                    }
                    
                    guard statusCode != 401 else {
                        DispatchQueue.main.async {
                            print("Incorrect code")
                        }
                        return
                    }
                    
                    guard statusCode != 406 else { //account not approved
                        return
                    }
                    
                    DispatchQueue.main.async {
                        print("failed verifying sms")
                    }
                    return
                }
                
                guard let admin = admin else {
                    print("error with admin response")
                    return
                }
                
                DispatchQueue.main.async {
                    Admin.current = admin
                    Admin.saveCurrentAdmin()
                    ChatClient.login()
                    self?.fromLogin.set(true, forKey: "fromLogin")
                    self?.perform(#selector(self?.transitionHome), with: self, afterDelay: 0.5)
                }
            }
        }
    }
    
    
    
    
    @objc func dismissVC() {
        lightImpactGenerator()
        self.dismiss(animated: true) {
            //
        }
    }
    
    @objc func transitionHome() {
        self.transitionView.isHidden = false
        self.transitionView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.35, delay: 0, options: []) {
            self.navView.alpha = 0
            self.mainScrollView.alpha = 0
            self.view.endEditing(true)
        } completion: { success in
            self.transitionView.isHidden = false
            UIView.animate(withDuration: 0.35, delay: 0, options: []) {
                self.transitionView.alpha = 1.0
            } completion: { success in
                self.goToHome()
            }
        }
    }
            
    func goToHome() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MyTabBarController") as! MyTabBarController
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = vc
        fromSignUp.set(true, forKey: "comingFromSignUp")
    }
    
    @objc func showPhoneNumber() {
        self.mainScrollView.setContentOffset(CGPoint(x: view.frame.width, y: 0), animated: true)
        phoneNumberTextField.becomeFirstResponder()
    }
    
    @objc func showOTC() {
        self.mainScrollView.setContentOffset(CGPoint(x: view.frame.width * 1, y: 0), animated: true)
        codeTextField.becomeFirstResponder()
    }
    
}
