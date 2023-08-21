//
//  ContinueButton.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit
import Lottie

protocol ContinueButtonDelegate: AnyObject {
    func didFinishCheckmark()
}

class ContinueButton: UIButton {

    var delegate: ContinueButtonDelegate!
    var continueLabel = UILabel()
    var confirmLabel = UILabel()
    var purpleBG = UIImageView()
    var checkmarkLottie = LottieAnimationView()
    var spinner = UIActivityIndicatorView(style: .medium)
    
    var lottieColor: UIColor = UIColor.white

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: VIEWS

extension ContinueButton {
    
    func setupViews() {
        
        purpleBG.image = UIImage(named: "buttonGradient")
        purpleBG.contentMode = .scaleAspectFill
        purpleBG.isUserInteractionEnabled = false
        purpleBG.backgroundColor = .clear
        purpleBG.layer.cornerRadius = 56/2
        purpleBG.layer.masksToBounds = true
        purpleBG.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(purpleBG)
        purpleBG.fillSuperview()
        
        continueLabel.isUserInteractionEnabled = false
        continueLabel.textAlignment = .center
        continueLabel.textColor = .white
        continueLabel.font = .sofiaProBold(ofSize: 16)
        continueLabel.numberOfLines = 0
        continueLabel.translatesAutoresizingMaskIntoConstraints = false
        purpleBG.addSubview(continueLabel)
        continueLabel.centerYAnchor.constraint(equalTo: purpleBG.centerYAnchor).isActive = true
        continueLabel.centerXAnchor.constraint(equalTo: purpleBG.centerXAnchor).isActive = true
        
        confirmLabel.isUserInteractionEnabled = false
        confirmLabel.alpha = 0
        confirmLabel.textAlignment = .center
        confirmLabel.textColor = .white
        confirmLabel.font = .sofiaProBold(ofSize: 16)
        confirmLabel.numberOfLines = 0
        confirmLabel.translatesAutoresizingMaskIntoConstraints = false
        purpleBG.addSubview(confirmLabel)
        confirmLabel.centerYAnchor.constraint(equalTo: purpleBG.centerYAnchor, constant: 0).isActive = true
        confirmLabel.centerXAnchor.constraint(equalTo: purpleBG.centerXAnchor).isActive = true
        
        spinner.isHidden = true
        spinner.alpha = 0
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        purpleBG.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: purpleBG.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: purpleBG.centerYAnchor).isActive = true
        
        let checkAnimation = LottieAnimation.named("checkoutSuccess")
        checkmarkLottie.isUserInteractionEnabled = false
        checkmarkLottie.alpha = 1.0
        checkmarkLottie.animation = checkAnimation
        checkmarkLottie.loopMode = .playOnce
        checkmarkLottie.contentMode = .scaleAspectFill
        checkmarkLottie.backgroundColor = .clear
        checkmarkLottie.translatesAutoresizingMaskIntoConstraints = false
        purpleBG.addSubview(checkmarkLottie)
        checkmarkLottie.centerXAnchor.constraint(equalTo: purpleBG.centerXAnchor).isActive = true
        checkmarkLottie.centerYAnchor.constraint(equalTo: purpleBG.centerYAnchor, constant: 0).isActive = true
        checkmarkLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        checkmarkLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true
                
        //print("😀😀😀 - \(checkmarkLottie.logHierarchyKeypaths()) - 😀😀😀")
            
        let loadingLayers = ["ae_demo Outlines.Group 1.Stroke 1.Color", "ae_demo Outlines.Group 2.Stroke 1.Color"]
        for layer in 1...loadingLayers.count {
            let keyPath = AnimationKeypath(keypath: "\(loadingLayers[layer - 1])")
            let colorProvider = ColorValueProvider(UIColor.newBlack.withAlphaComponent(1.0).lottieColorValue)
            checkmarkLottie.setValueProvider(colorProvider, keypath: keyPath)
        }
        
    }
    
}

//MARK: ACTIONS

extension ContinueButton {
    @objc func transitionAni() {
        continueLabel.transform = CGAffineTransform(translationX: 0, y: 50)
        confirmLabel.transform = CGAffineTransform(translationX: 0, y: -50)
        UIView.animate(withDuration: 0.28) {
            self.confirmLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.confirmLabel.alpha = 1.0
        }
    }
    
    func showNewLabel() {
        confirmLabel.transform = CGAffineTransform(translationX: 0, y: -50)
        UIView.animate(withDuration: 0.175, delay: 0, options: [], animations: {
            self.continueLabel.transform = CGAffineTransform(translationX: 0, y: 50)
            self.continueLabel.alpha = 0
        }) { (success) in
            UIView.animate(withDuration: 0.5) {
                self.confirmLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.confirmLabel.alpha = 1.0
            }
        }
    }
    
    func showNewLabelTriggerDelegate() {
        confirmLabel.transform = CGAffineTransform(translationX: 0, y: -50)
        UIView.animate(withDuration: 0.175, delay: 0, options: [], animations: {
            self.continueLabel.transform = CGAffineTransform(translationX: 0, y: 50)
            self.continueLabel.alpha = 0
        }) { (success) in
            UIView.animate(withDuration: 0.5) {
                self.confirmLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.confirmLabel.alpha = 1.0
            } completion: { success in
                self.delegate.didFinishCheckmark()
            }

        }
    }
    
    func showNewThenOriginal() {
        confirmLabel.transform = CGAffineTransform(translationX: 0, y: -50)
        UIView.animate(withDuration: 0.175, delay: 0, options: [], animations: {
            self.continueLabel.transform = CGAffineTransform(translationX: 0, y: 50)
            self.continueLabel.alpha = 0
        }) { (success) in
            UIView.animate(withDuration: 0.5) {
                self.confirmLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.confirmLabel.alpha = 1.0
                
                self.perform(#selector(self.showOriginalLabel), with: self, afterDelay: 1.25)
            }
        }
    }
    
    
    @objc func showOriginalLabel() {
        UIView.animate(withDuration: 0.175, delay: 0, options: [], animations: {
            self.checkmarkLottie.alpha = 0
            self.confirmLabel.transform = CGAffineTransform(translationX: 0, y: -50)
            self.confirmLabel.alpha = 0
        }) { (success) in
            UIView.animate(withDuration: 0.5) {
                self.continueLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.continueLabel.alpha = 1.0
            }
        }
    }
    
    @objc func showCheckmark() {
        spinner.isHidden = true
        checkmarkLottie.play(fromFrame: 0, toFrame: 0, loopMode: .playOnce, completion: nil)
        UIView.animate(withDuration: 0.2, animations: {
            self.continueLabel.alpha = 0
            self.continueLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.spinner.alpha = 0
        }) { (success) in
            self.checkmarkLottie.alpha = 1.0
            self.checkmarkLottie.play { (success) in
                self.delegate.didFinishCheckmark()
            }
        }
    }
    
    func showLoader() {
        UIView.animate(withDuration: 0.2, animations: {
            self.continueLabel.alpha = 0
            self.continueLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (success) in
            self.spinner.isHidden = false
            UIView.animate(withDuration: 0.35) {
                self.spinner.alpha = 1.0
            }
        }
    }
    
    @objc func didCancelLoader() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            //self.spinner.transform = CGAffineTransform(translationX: 0, y: 50)
            self.spinner.alpha = 0
        }) { (success) in
            UIView.animate(withDuration: 0.2) {
                self.continueLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.continueLabel.alpha = 1.0
            }
        }
    }
    
    @objc func showCheckmarkTwo() {
        spinner.isHidden = true
        UIView.animate(withDuration: 0.2, animations: {
            self.confirmLabel.alpha = 0
            self.confirmLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.spinner.alpha = 0
        }) { (success) in
            self.checkmarkLottie.play { (success) in
                self.delegate.didFinishCheckmark()
            }
        }
    }
    
    @objc func showCheckMarkThenConfirm() {
        UIView.animate(withDuration: 0.2, animations: {
            //self.continueLabel.alpha = 0
            //self.continueLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.confirmLabel.alpha = 0
            self.confirmLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (success) in
            self.checkmarkLottie.alpha = 1.0
            self.checkmarkLottie.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.checkmarkLottie.play { (success) in
                UIView.animate(withDuration: 0.35, animations: {
                    self.checkmarkLottie.alpha = 0
                    self.checkmarkLottie.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }) { (success) in
                    UIView.animate(withDuration: 0.35, animations: {
                        self.confirmLabel.alpha = 1.0
                        self.confirmLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }) { (success) in
                        self.delegate.didFinishCheckmark()
                        self.checkmarkLottie.play(fromFrame: 0, toFrame: 0, loopMode: .none, completion: nil)
                    }
                }
            }
        }
    }
    
}

