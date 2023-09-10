//
//  MyProfileLinkViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/5/23.
//

import UIKit
import EFQRCode
import PWSwitch

class MyProfileLinkViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var isNVUDemo = UserDefaults()
    var opacityLayer = UIView()
    var cardContainer = UIView()
    var cardHeight: NSLayoutConstraint!
    var titleLabel = UILabel()
    var detailLabel = UILabel()
    var downArrow = UIImageView()
    var downButton = UIButton()
    var copyButton = UIButton()
    var linkLabel = UILabel()
    var settingsImageView = UIImageView()
    var settingsButton = UIButton()
    var nameContainer = UIView()
    var nameTextField = UITextField()
    var continueButton = ContinueButton()
    
    var holdingTankTitleLabel = UILabel()
    var holdingTankDetailLabel = UILabel()
    var pwSubSwitchContainer = UIView()
    var pwSubSwitch = PWSwitch()
    
    var qrImageView = UIImageView()
    var shareURLButton = UpgradeAccountButton()//UIButton()
    var shareTrailing: NSLayoutConstraint!
    var copyURLButton = UpgradeAccountButton()
    var qrLinkTrackingImageView = UIImageView()
    
    var isDarkMode = false
    var inSettingsMode = false
    var isLinkWithoutTracking = true
    var didEngageTextField = false
    var textColor: UIColor = UIColor.white
    
    var teamSettingsTitleLabel = UILabel()
    var teamSettingsContainer = UIView()
    var dividerLine = UIView()
    var alternatingLabel = UILabel()
    var alternatingDetailLabel = UILabel()
    var alternatingBoxImageView = UIImageView()
    var smartLabel = UILabel()
    var smartDetailLabel = UILabel()
    var smartBoxImageView = UIImageView()
    var teamLabel = UILabel()
    var teamDetailLabel = UILabel()
    var teamBoxImageView = UIImageView()
    var webAlias: String?
    
    var alternatingButton = UIButton()
    var smartButton = UIButton()
    var teamButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        //setupSettings()
        generateLinkNoTrackingQRCode()
        perform(#selector(presentViews), with: self, afterDelay: 0.05)
    }
}

//MARK: ACTIONS

extension MyProfileLinkViewController {
    @objc func presentViews() {
        UIView.animate(withDuration: 0.2, animations: {
            self.opacityLayer.alpha = 0.4
            self.cardContainer.transform = CGAffineTransform(translationX: 0, y: -5)
        }) { (success) in
            UIView.animate(withDuration: 0.15, animations: {
                self.cardContainer.transform = CGAffineTransform(translationX: 0, y: 5)
            }) { (success) in
                UIView.animate(withDuration: 0.1) {
                    self.cardContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            }
        }
    }
    
    @objc func generateLinkNoTrackingQRCode() {
        Task {
            if let shareLink = await Admin.current.getShareLink(), let image = EFQRCode.generate(
                    for: shareLink,
                    watermark: UIImage(named: "nvu_qr1")?.cgImage //nvu_qr1 //WWF //newEnigmaE //enigmaE //qrLinkZero
            ) {
                print("Create QRCode image success \(image)")
                qrImageView.image = UIImage(cgImage: image)
            } else {
                print("Create QRCode image failed!")
            }
        }
    }
    
    func removeEmailSpecialCharacters(_ email: String) -> String {
        let components = email.components(separatedBy: "@")
        guard components.count == 2 else {
            return email
        }
        let username = components[0]
        let domain = components[1].replacingOccurrences(of: ".", with: "")
        return username + domain
    }
    
    @objc func generateLinkTrackingQRCode() {
        Task {
            if let textTracking = nameTextField.text {
                if textTracking.contains(" ") {
                    let toastNoti = ToastNotificationView()
                    toastNoti.present(withMessage: "Remove spaces!!!")
                    nameContainer.badWiggle()
                    errorImpactGenerator()
                } else {
                    self.detailLabel.text = textTracking
                    if let shareLink = await Admin.current.getShareLink(), let image = EFQRCode.generate(
                        for: shareLink,
                                            
                        watermark: UIImage(named: "nvu_qr2")?.cgImage //WWF //newEnigmaE //enigmaE //qrLinkOne
                    ) {
                        print("Create QRCode image success \(image)")
                        qrLinkTrackingImageView.image = UIImage(cgImage: image)
                    } else {
                        print("Create QRCode image failed!")
                    }
                }
            }
        }
    }
    
    @objc func didTapSetTracking() {
        if nameTextField.text?.contains(" ") ?? false || nameTextField.text == "" {
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "Invalid Tracking Text")
            nameContainer.badWiggle()
            errorImpactGenerator()
        } else {
            generateLinkTrackingQRCode()
                                                
            cardHeight.constant = 400 - 10
            UIView.animate(withDuration: 0.35) {
                self.qrLinkTrackingImageView.alpha = 1.0
                self.nameContainer.alpha = 0
                self.detailLabel.alpha = 1.0
                self.view.endEditing(true)
                self.view.layoutIfNeeded()
            } completion: { success in
                self.cardHeight.constant = 400 + 5
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                } completion: { success in
                    self.cardHeight.constant = 400
                    UIView.animate(withDuration: 0.2) {
                        self.view.layoutIfNeeded()
                    } completion: { success in
                        self.downButton.isUserInteractionEnabled = true
                    }
                }
            }
            
        }
        
        //generateLinkTrackingQRCode()
    }
    
    @objc func didTapTextField() {
        titleLabel.text = "Link With Tracking"
        isLinkWithoutTracking = false
        cardHeight.constant = 595 + 10
        UIView.animate(withDuration: 0.35) {
            self.qrImageView.alpha = 0
            self.nameContainer.alpha = 1.0
            self.detailLabel.alpha = 1.0
            self.nameTextField.becomeFirstResponder()
            self.view.layoutIfNeeded()
        } completion: { success in
            self.cardHeight.constant = 595 - 5
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            } completion: { success in
                self.cardHeight.constant = 595
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                } completion: { success in
                    self.teamSettingsContainer.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    @objc func subOnSwitchChanged() {
        lightImpactGenerator()
        if isLinkWithoutTracking {
            UIView.animate(withDuration: 0.35) {
                self.detailLabel.text = "Please enter tracking text\n(no spaces)"
                self.nameTextField.becomeFirstResponder()
            }
        } else {
            titleLabel.text = "Link Without Tracking"
            isLinkWithoutTracking = true
            
            cardHeight.constant = 385 - 10
            UIView.animate(withDuration: 0.35) {
                self.qrImageView.alpha = 1.0
                self.qrLinkTrackingImageView.alpha = 0
                self.nameContainer.alpha = 0
                self.detailLabel.alpha = 0
                self.view.endEditing(true)
                self.view.layoutIfNeeded()
            } completion: { success in
                self.cardHeight.constant = 385 + 5
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                } completion: { success in
                    self.cardHeight.constant = 385
                    UIView.animate(withDuration: 0.2) {
                        self.view.layoutIfNeeded()
                    } completion: { success in
                        self.downButton.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
    
    @objc func tappedSettingsOption(sender: UIButton) {
        lightImpactGenerator()
        switch sender.tag {
        case 1:
            alternatingBoxImageView.image = UIImage(named: "checkBoxFill")
            smartBoxImageView.image = UIImage(named: "checkBoxEmpty")
            teamBoxImageView.image = UIImage(named: "checkBoxEmpty")
        case 2:
            alternatingBoxImageView.image = UIImage(named: "checkBoxEmpty")
            smartBoxImageView.image = UIImage(named: "checkBoxFill")
            teamBoxImageView.image = UIImage(named: "checkBoxEmpty")
        default:
            alternatingBoxImageView.image = UIImage(named: "checkBoxEmpty")
            smartBoxImageView.image = UIImage(named: "checkBoxEmpty")
            teamBoxImageView.image = UIImage(named: "checkBoxFill")
        }
    }
    
    @objc func linkCopied() {
        Task {
            lightImpactGenerator()
            let pasteboard = UIPasteboard.general
            print("did this 👑👑👑 111")
            pasteboard.string = await Admin.current.getShareLink()
            perform(#selector(dismissViews), with: self, afterDelay: 0.1)
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "URL copied to clipboard")
        }
    }
    
    @objc func dismissViews() {
        lightImpactGenerator()
        UIView.animate(withDuration: 0.2, animations: {
            self.opacityLayer.alpha = 0
            if self.isLinkWithoutTracking {
                self.cardContainer.transform = CGAffineTransform(translationX: 0, y: 385)
            } else {
                self.cardContainer.transform = CGAffineTransform(translationX: 0, y: 600)
            }
            self.view.endEditing(true)
        }) { (success) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func didTapShareURL() {
        Task {
            lightImpactGenerator()
            if inSettingsMode {
                didTapDone()
            } else if let shareLink = await Admin.current.getShareLink() {
                print("did this 👑👑👑 111")
                let items = [URL(string: shareLink)]
                let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
                present(ac, animated: true)
            }
        }
    }
    
    @objc func didTapDone() {
        inSettingsMode = false
        cardHeight.constant = 385 - 10
        shareTrailing.constant = -10.5
        //shareURLButton.showOriginalLabel()
        self.teamSettingsContainer.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.35) {
            self.titleLabel.alpha = 1.0
            self.qrImageView.alpha = 1.0
            self.downArrow.alpha = 1.0
            self.copyURLButton.alpha = 1.0
            self.settingsImageView.alpha = 1.0
            self.teamSettingsContainer.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { success in
            self.cardHeight.constant = 385 + 5
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            } completion: { success in
                self.cardHeight.constant = 385
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                } completion: { success in
                    //
                }
            }
        }
    }
    
    @objc func didTapSettings() {
        lightImpactGenerator()
        //shareURLButton.showNewLabel()
        inSettingsMode = true
        cardHeight.constant = 594 + 10
        let trailing = (view.frame.width / 2) - 26
        shareTrailing.constant = trailing
        UIView.animate(withDuration: 0.35) {
            self.titleLabel.alpha = 0
            self.qrImageView.alpha = 0
            self.downArrow.alpha = 0
            self.copyURLButton.alpha = 0
            self.downButton.isUserInteractionEnabled = false
            self.teamSettingsContainer.alpha = 1.0
            self.settingsImageView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { success in
            self.cardHeight.constant = 594 - 5
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            } completion: { success in
                self.cardHeight.constant = 594
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                } completion: { success in
                    //
                }
            }
        }
    }
}

//MARK: TEXTFIELD DELEGATE

extension MyProfileLinkViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didTapTextField()
    }
}
