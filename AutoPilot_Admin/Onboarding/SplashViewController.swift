//
//  SplashViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

//
//  SplashViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import FlagPhoneNumber
import StreamChat
import UIKit
import PhotoCircleCrop
import WXImageCompress
import StreamChat

protocol SplashViewControllerDelegate {
    func didGoReturnToSplash()
}

class SplashViewController: UIViewController {

    var delegate: SplashViewControllerDelegate!
    
    var userInfoContainer = UIView()
    var profilePhotoImageView = UIImageView()
    var userNameContainer = UIView()
    var usernameTextfield = UITextField()
    
    var joinLabel = UILabel()
    var joinDescriptionLabel = UILabel()
    var emailContainerView = UIView()
    var phoneNumberTextField = FPNTextField()
    
    var passwordContainer = UIView()
    var codeTextField = OneTimeCodeTextField()
    
    var emailFieldCompleted = false
    var passwordFieldCompleted = false
        
    var continueFBImageView = UIImageView()
    var fbButton = UIButton()
    
    var goingBackToSplash = false
    var dismissButton = UIButton()
    
    var mainScrollView = UIScrollView()
    var phoneNumberContainer = UIView()
    var codeContainer = UIView()
    var phoneNubmerIsValid = false
    
    var phoneNumber = ""
        
    var dismissImageView = UIImageView()
    var isStepOne = true
    var isStepTwo = true
    var photoSet = false
    
    var transitionView = UIView()
    
    var fromSignUp = UserDefaults()
    
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

}

//MARK: FLAG DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension SplashViewController: FPNTextFieldDelegate {
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

extension SplashViewController {
    
    @objc func nextTapped() {
        
        if isStepOne {
            
            if photoSet == false {
                profilePhotoImageView.badWiggle()
                errorImpactGenerator()
                return
            }
            
            if usernameTextfield.text == "" {
                userNameContainer.badWiggle()
                errorImpactGenerator()
                return
            }
            
            showPhoneNumber()
            isStepOne = false
            
        } else if isStepTwo {
            
            if phoneNubmerIsValid {
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
                        self?.isStepTwo = false
                    }
                }
            } else {
                errorImpactGenerator()
                phoneNumberContainer.badWiggle()
            }
            
        } else {
            if photoSet {
                API.sharedInstance.sendSMSVerifyLogin(loginRequest: SMSLoginAttempt(code: codeTextField.text ?? "", phone: phoneNumber, displayName: usernameTextfield.text ?? "")) { [weak self] (success, admin, error, statusCode) in
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
                    
                    guard let photo = self?.photo else { return }

                    ImageUploader.uploadImage(image: photo, key: "admin:\(admin.id!.uuidString)") { error, success, uploadedUrl in
                        guard error == nil else {
                            print(error!)
                            return
                        }
                        
                        guard success else {
                            print("error uploading image")
                            return
                        }
                        
                        Admin.current.profilePhotoUrl = uploadedUrl
                        
                        API.sharedInstance.updateAdmin(admin: Admin.current) { success, admin, error in
                            guard error == nil else {
                                print(error!)
                                return
                            }
                            
                            guard success, let admin = admin else {
                                print("error updating admin")
                                return
                            }
                            
                            DispatchQueue.main.async {
                                Admin.current = admin
                                Admin.saveCurrentAdmin()
                                
                                ChatClient.login()
                                self?.goToHome()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @objc func dismissVC() {
        self.dismiss(animated: true) {
            //
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
        self.mainScrollView.setContentOffset(CGPoint(x: view.frame.width * 2, y: 0), animated: true)
        codeTextField.becomeFirstResponder()
    }
    
}


//MARK: CIRCLE PHOTO DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension SplashViewController: CircleCropViewControllerDelegate {
    @objc func replacePhotoClicked() {
        lightImpactGenerator()
        
        ImagePickerManager().pickImage(self){ image in
            if let image = image {
                self.pickedImage(image: image)
            } else {
                print("no photo retrieved")
            }
        }
        
        
    }
    
    func pickedImage(image: UIImage) {
        self.photo = image
        let circleCropController = CircleCropViewController()
        circleCropController.delegate = self
        circleCropController.image = image
        self.present(circleCropController, animated: true, completion: nil)
    }
    
    func uploadImage() {
        guard let photo = self.photo else {
            print("photo is nil, can't upload")
            return
        }
        
        self.photoSet = true
        self.profilePhotoImageView.image = photo
    }
    
    func circleCropDidCropImage(_ image: UIImage) {
        self.photo = image.wxCompress()
        uploadImage()
                
        profilePhotoImageView.image = photo
    }
    
    func circleCropDidCancel() {
        print("User canceled the crop flow")
    }
}
