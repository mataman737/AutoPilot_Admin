//
//  UpdateTeamNameAndPhotoViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/8/23.
//

import UIKit
import PhotoCircleCrop
import WXImageCompress
import Kingfisher

protocol UpdateTeamNameAndPhotoViewControllerDelegate: AnyObject {
    func didUpdateTeamNamePhoto()
}

class UpdateTeamNameAndPhotoViewController: UIViewController {
    
    var mainScrollView = UIScrollView()
    var wrapper = UIView()
    var mainContainer = UIView()
    var navTitleLabel = UILabel()
    var keyLine = UIView()
    var isDismissing = false
    weak var delegate: UpdateTeamNameAndPhotoViewControllerDelegate?
    var isDarkMode = UserDefaults()
    var opacityLayer = UIView()
    var cardContainer = UIView()
    var titleLabel = UILabel()
    var downArrow = UIImageView()
    var downButton = UIButton()
    var teamNameContainer = UIView()
    var teamNameTextField = UITextField()
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
    var team: Team?
    var spinner = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        //print("🎯🎯🎯 \(team) 🎯🎯🎯")
        
        perform(#selector(prsentViews), with: self, afterDelay: 0.05)
    }
}

//MARK: ACTIONS

extension UpdateTeamNameAndPhotoViewController {
    @objc func prsentViews() {
        self.mainContainer.presentAndBounce()
        UIView.animate(withDuration: 0.2) {
            self.opacityLayer.alpha = 0.75
        }
    }
    
    @objc func dismissViews() {
        lightImpactGenerator()
        UIView.animate(withDuration: 0.2) {
            self.view.endEditing(true)
            self.opacityLayer.alpha = 0
            self.mainContainer.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
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
                } else {
                    presentErrorToast()
                }
            }
        } else {
            presentErrorToast()
        }
        
        return true
    }
    
    func presentErrorToast() {
        let toastNoti = ToastNotificationView()
        toastNoti.present(withMessage: "Team Name & Photo Required")
        errorImpactGenerator()
        if photoSet != true {
            teamPhotoImageView.badWiggle()
        }
        
        if teamNameTextField.text == "" {
            teamNameContainer.badWiggle()
        }
    }
    
    func submitTeamNameUpdate(name: String) {
        spinner.isHidden = false
        spinner.alpha = 1.0
        
        if let team = self.team, let image = self.photo {
            let key = "team:\(team.id.uuidString)-\(UUID().uuidString)"
            ImageUploader.uploadImage(image: image.wxCompress(), key: key, completion: { [weak self] (error, success, url) in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                guard success else {
                    print("error uploading image")
                    return
                }
                      
                self?.updateTeam(name: name, imageUrl: url)
            })
        } else {
            self.updateTeam(name: name, imageUrl: team?.photo)
        }
    }
    
    func updateTeam(name: String, imageUrl: String?) {
        guard var team = self.team else { return }
        team.name = name
        team.photo = imageUrl
        API.sharedInstance.updateTeam(team: team) { success, team, error in
            guard error == nil else {
                print("\(error!) 🤌🤌🤌")
                DispatchQueue.main.async {
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Error updating team")
                    self.errorImpactGenerator()
                    self.dismissViews()
                    self.spinner.isHidden = true
                    self.spinner.alpha = 0
                }
                return
            }
            
            guard success, let team = team else {
                print("error submitting promo code 🤌🤌🤌")
                DispatchQueue.main.async {
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Error updating team")
                    self.errorImpactGenerator()
                    self.dismissViews()
                    self.spinner.isHidden = true
                    self.spinner.alpha = 0
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.didSetTeamNamePhoto.set(true, forKey: "didSetTeamNamePhoto")
                self?.delegate?.didUpdateTeamNamePhoto()
                self?.successImpactGenerator()
                self?.dismissViews()
            }
        }

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

//MARK: SCROLLVIEW DELEGATE

extension UpdateTeamNameAndPhotoViewController: UIScrollViewDelegate {
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
