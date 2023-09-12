//
//  UpdateTeamNameAndPhotoViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/8/23.
//

import UIKit
import PhotoCircleCrop
import WXImageCompress

protocol UpdateTeamNameAndPhotoViewControllerDelegate: AnyObject {
    func didUpdateTeamNamePhoto()
}

class UpdateTeamNameAndPhotoViewController: UIViewController {
    
    weak var delegate: UpdateTeamNameAndPhotoViewControllerDelegate?
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
    var isTeamNameChange = false
    var teamPhotoImageView = UIImageView()
    var photo: UIImage?
    var photoSet = false
    var premiumChannelButton = ContinueButton()
    var didSetTeamNamePhoto = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        perform(#selector(prsentViews), with: self, afterDelay: 0.05)
    }
}

//MARK: ACTIONS

extension UpdateTeamNameAndPhotoViewController {
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

extension UpdateTeamNameAndPhotoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            if let tft = textField.text {
                if photoSet == true {
                    submitTeamNameUpdate(name: tft)
                }
            }
        } else {
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "Invalid Promo")
            errorImpactGenerator()
        }
        
        return true
    }
    
    func submitTeamNameUpdate(name: String) {
        didSetTeamNamePhoto.set(true, forKey: "didSetTeamNamePhoto")
        delegate?.didUpdateTeamNamePhoto()
        dismissViews()
        //DYLAN - NEED TO UDPATE TEAM NAME AND PHOTO HERE
    }
    
    func submitAccessCode(promo: String) {
        
        //DYLAN - NEED TO UPDATE THIS FOR ACCESS CODE
        
        /*
        API.sharedInstance.redeemFreeTrial(promo: promo) { success, info, error in
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
            
            guard success, let info = info else {
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
        */
    }
}

//MARK: CIRCLE PHOTO DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension UpdateTeamNameAndPhotoViewController: CircleCropViewControllerDelegate {
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
        self.teamPhotoImageView.image = photo
    }
    
    func circleCropDidCropImage(_ image: UIImage) {
        self.photo = image.wxCompress()
        uploadImage()
        teamPhotoImageView.image = photo
    }
    
    func circleCropDidCancel() {
        print("User canceled the crop flow")
    }
}
