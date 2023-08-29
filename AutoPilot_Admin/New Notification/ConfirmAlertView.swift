//
//  ConfirmAlertView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/28/23.
//

import Foundation
import Lottie

protocol ConfirmAlertViewDelegte: AnyObject {
    func didFinishCheckmarkAnimation()
    func cancelTapped()
    func popVCBack()
    func didCompleteLoadingAnimation()
}

class ConfirmAlertView: UIView {

    var delegate: ConfirmAlertViewDelegte!
    var opacityLayer = UIView()
    var containerView = UIView()
    var contentView = UIView()
    var reqTitleLabel = UILabel()
    var reqDetailLabel = UILabel()
    var topDividerLine = UIView()
    var centerDividerLine = UIView()
    var confirmLabel = UILabel()
    var cancelLabel = UILabel()
    
    var confirmButton = UIButton()
    var cancelButton = UIButton()
    var checkmarkLottie = LottieAnimationView()
    var denyLottie = LottieAnimationView()
    var errorLottie = LottieAnimationView()
    var rocketLottie = LottieAnimationView()
    var whiteCoverView = UIView()
    var lottieCompleted = false
    var isTrash = false
    
    var loadingView = UIView()
    var loadingLottie = LottieAnimationView()
    var uploadingLabel = UILabel()
    var showRocketShip = false
    var lottieString = "checkoutSuccess"
    
    var broadcastLottie = LottieAnimationView()
    var spinner = UIActivityIndicatorView(style: .medium)
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
        setupLoadingIndicator()
        setupBroadcastLottie()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: Helpers

extension ConfirmAlertView {
    func setupViews() {
        
        opacityLayer.backgroundColor = .black
        opacityLayer.alpha = 0
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 11
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.18
        containerView.layer.shadowRadius = 0.28
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        //containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32).isActive = true
        //containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 375 - 64).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 180).isActive = true //204
        containerView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        containerView.alpha = 0
        
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentView)
        contentView.fillSuperview()
                
        reqTitleLabel.textAlignment = .center
        reqTitleLabel.textColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)
        reqTitleLabel.font = .sofiaProBold(ofSize: 18)
        reqTitleLabel.numberOfLines = 0
        reqTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reqTitleLabel)
        reqTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        reqTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        
        reqDetailLabel.textAlignment = .center
        reqDetailLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        reqDetailLabel.font = .sofiaProRegular(ofSize: 15)
        reqDetailLabel.numberOfLines = 0
        reqDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reqDetailLabel)
        //reqDetailLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        reqDetailLabel.topAnchor.constraint(equalTo: reqTitleLabel.bottomAnchor, constant: 7).isActive = true
        reqDetailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        reqDetailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        topDividerLine.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 230/255, alpha: 1.0)
        topDividerLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topDividerLine)
        topDividerLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 31.5).isActive = true
        topDividerLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -31.5).isActive = true
        topDividerLine.topAnchor.constraint(equalTo: reqDetailLabel.bottomAnchor, constant: 20.5).isActive = true
        topDividerLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        centerDividerLine.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 230/255, alpha: 1.0)
        centerDividerLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(centerDividerLine)
        centerDividerLine.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        centerDividerLine.topAnchor.constraint(equalTo: topDividerLine.bottomAnchor, constant: 19).isActive = true
        centerDividerLine.heightAnchor.constraint(equalToConstant: 19.51).isActive = true
        centerDividerLine.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        confirmLabel.text = "CONFIRM"
        confirmLabel.textAlignment = .center
        confirmLabel.textColor = UIColor(red: 255/255, green: 81/255, blue: 6/255, alpha: 1.0)
        confirmLabel.font = .sofiaProBold(ofSize: 13)
        confirmLabel.numberOfLines = 0
        confirmLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(confirmLabel)
        confirmLabel.centerYAnchor.constraint(equalTo: centerDividerLine.centerYAnchor).isActive = true
        confirmLabel.leadingAnchor.constraint(equalTo: centerDividerLine.trailingAnchor, constant: 0).isActive = true
        confirmLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        cancelLabel.text = "CANCEL"
        cancelLabel.textAlignment = .center
        cancelLabel.textColor = UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0)
        cancelLabel.font = .sofiaProBold(ofSize: 13)
        cancelLabel.numberOfLines = 0
        cancelLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cancelLabel)
        cancelLabel.centerYAnchor.constraint(equalTo: centerDividerLine.centerYAnchor).isActive = true
        cancelLabel.trailingAnchor.constraint(equalTo: centerDividerLine.leadingAnchor, constant: 0).isActive = true
        cancelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        
        //Buttons
        
        confirmButton.backgroundColor = .clear//UIColor.red.withAlphaComponent(0.5)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(confirmButton)
        confirmButton.leadingAnchor.constraint(equalTo: centerDividerLine.trailingAnchor, constant: 0).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: confirmLabel.bottomAnchor, constant: 20).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        confirmButton.topAnchor.constraint(equalTo: confirmLabel.topAnchor, constant: -20).isActive = true
        
        cancelButton.addTarget(self, action: #selector(animateViewsOut), for: .touchUpInside)
        cancelButton.backgroundColor = .clear//UIColor.blue.withAlphaComponent(0.5)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: cancelLabel.bottomAnchor, constant: 20).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: centerDividerLine.leadingAnchor, constant: 0).isActive = true
        cancelButton.topAnchor.constraint(equalTo: cancelLabel.topAnchor, constant: -20).isActive = true
        
        whiteCoverView.isHidden = true
        whiteCoverView.alpha = 0
        whiteCoverView.backgroundColor = .white
        whiteCoverView.layer.cornerRadius = 11
        whiteCoverView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(whiteCoverView)
        whiteCoverView.fillSuperview()
                
        //let animationName = isTrash ? "checkDelete" : "checkoutSuccess"
        let animationName = "checkoutSuccess"
        let checkAnimation = LottieAnimation.named(animationName) //checkoutSuccess
        checkmarkLottie.isUserInteractionEnabled = false
        checkmarkLottie.alpha = 0
        checkmarkLottie.animation = checkAnimation
        checkmarkLottie.loopMode = .playOnce
        checkmarkLottie.contentMode = .scaleAspectFill
        checkmarkLottie.backgroundColor = .clear
        checkmarkLottie.translatesAutoresizingMaskIntoConstraints = false
        whiteCoverView.addSubview(checkmarkLottie)
        checkmarkLottie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        checkmarkLottie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        checkmarkLottie.heightAnchor.constraint(equalToConstant: 200).isActive = true
        checkmarkLottie.widthAnchor.constraint(equalToConstant: 200).isActive = true
       
        //print("😀😀😀 - \(checkmarkLottie.logHierarchyKeypaths()) - 😀😀😀")
        
        let loadingLayers = ["ae_demo Outlines.Group 1.Stroke 1.Color", "ae_demo Outlines.Group 2.Stroke 1.Color"]
        for layer in 1...loadingLayers.count {
            let keyPath = AnimationKeypath(keypath: "\(loadingLayers[layer - 1])")
            let colorProvider = ColorValueProvider(UIColor.themeBlack.lottieColorValue)
            checkmarkLottie.setValueProvider(colorProvider, keypath: keyPath)
        }
        
        let denyAnimation = LottieAnimation.named("checkDelete")
        denyLottie.isUserInteractionEnabled = false
        denyLottie.alpha = 0
        denyLottie.animation = denyAnimation
        denyLottie.loopMode = .playOnce
        denyLottie.animationSpeed = 0.75
        denyLottie.contentMode = .scaleAspectFill
        denyLottie.backgroundColor = .clear
        denyLottie.translatesAutoresizingMaskIntoConstraints = false
        whiteCoverView.addSubview(denyLottie)
        denyLottie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        denyLottie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        denyLottie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        denyLottie.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //print("😀😀😀 - \(denyLottie.logHierarchyKeypaths()) - 😀😀😀")
        
        let denyLoadingLayers = ["ae_demo Outlines.Group 1.Stroke 1.Color", "ae_demo Outlines.Group 2.Stroke 1.Color", "circle.Ellipse 1.Stroke 1.Color", "circle.Ellipse 1.Fill 1.Color", "line1.Shape 1.Stroke 1.Color", "line1.Shape 1.Fill 1.Color", "2.Shape 1.Stroke 1.Color", "1.Shape 1.Stroke 1.Color"]
        for layer in 1...denyLoadingLayers.count {
            let denyLayer = denyLoadingLayers[layer - 1]
            let keyPath = AnimationKeypath(keypath: "\(denyLayer)")
            
            let colorProvider = ColorValueProvider(UIColor(red: 255/255, green: 78/255, blue: 78/255, alpha: 1.0).lottieColorValue)
            denyLottie.setValueProvider(colorProvider, keypath: keyPath)
        }
        
        let errorAnimation = LottieAnimation.named("error")
        errorLottie.isUserInteractionEnabled = false
        errorLottie.alpha = 0
        errorLottie.animation = errorAnimation
        errorLottie.loopMode = .playOnce
        errorLottie.animationSpeed = 0.75
        errorLottie.contentMode = .scaleAspectFill
        errorLottie.backgroundColor = .clear
        errorLottie.translatesAutoresizingMaskIntoConstraints = false
        whiteCoverView.addSubview(errorLottie)
        errorLottie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        errorLottie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        errorLottie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        errorLottie.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        let rocketAnimation = LottieAnimation.named("rocketShip") //checkoutSuccess
        rocketLottie.isUserInteractionEnabled = false
        rocketLottie.alpha = 0
        rocketLottie.animation = rocketAnimation
        rocketLottie.loopMode = .playOnce
        rocketLottie.contentMode = .scaleAspectFill
        rocketLottie.backgroundColor = .clear
        rocketLottie.translatesAutoresizingMaskIntoConstraints = false
        whiteCoverView.addSubview(rocketLottie)
        rocketLottie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        rocketLottie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        rocketLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rocketLottie.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //
        
        spinner.isHidden = true
        spinner.alpha = 0
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        whiteCoverView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: whiteCoverView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: whiteCoverView.centerYAnchor).isActive = true
    }
    
    func setupLoadingIndicator() {
        
        loadingView.isHidden = true
        loadingView.alpha = 0
        loadingView.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
        loadingView.layer.zPosition = 100
        loadingView.isHidden = false
        loadingView.backgroundColor = .clear
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(loadingView)
        loadingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        loadingView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        
        let checkAnimation = LottieAnimation.named("checkLoad")
        loadingLottie.isUserInteractionEnabled = false
        loadingLottie.alpha = 1.0
        loadingLottie.loopMode = .loop
        loadingLottie.animation = checkAnimation
        loadingLottie.contentMode = .scaleAspectFill
        loadingLottie.backgroundColor = .clear
        loadingLottie.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(loadingLottie)
        loadingLottie.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        loadingLottie.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: -15).isActive = true
        loadingLottie.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        loadingLottie.heightAnchor.constraint(equalToConstant: 250).isActive = true
        loadingLottie.widthAnchor.constraint(equalToConstant: 250).isActive = true
        //loadingLottie.play()
        loadingLottie.play(fromFrame: 0, toFrame: 17, loopMode: .loop, completion: nil)
        //print("😀😀😀 - \(loadingLottie.logHierarchyKeypaths()) - 😀😀😀")
    
        var i = 0
        let loadingLayers = ["Shape Layer 1.Ellipse 1.Stroke 1.Color", "Shape Layer 2.Ellipse 1.Stroke 1.Color", "Shape Layer 3.Ellipse 1.Stroke 1.Color"]
        for layer in 1...loadingLayers.count {
            let keyPath = AnimationKeypath(keypath: "\(loadingLayers[layer - 1])")
            if i == 0 {
                let colorProvider = ColorValueProvider(UIColor.themeBlack.withAlphaComponent(1.0).lottieColorValue)
                loadingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 1 {
                let colorProvider = ColorValueProvider(UIColor.themeBlack.withAlphaComponent(0.8).lottieColorValue)
                loadingLottie.setValueProvider(colorProvider, keypath: keyPath)
            } else {
                let colorProvider = ColorValueProvider(UIColor.themeBlack.withAlphaComponent(0.6).lottieColorValue)
                loadingLottie.setValueProvider(colorProvider, keypath: keyPath)
            }
            i += 1
        }
        
        uploadingLabel.text = "Uploading Drop"
        uploadingLabel.textAlignment = .center
        uploadingLabel.textColor = UIColor.themeBlack.withAlphaComponent(0.6)
        uploadingLabel.font = .sofiaProMedium(ofSize: 12)
        uploadingLabel.numberOfLines = 0
        uploadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(uploadingLabel)
        uploadingLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        uploadingLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: 35).isActive = true
        
    }
    
    func setupBroadcastLottie() {
        let checkAnimation = LottieAnimation.named("broadcastSent") //checkoutSuccess//broadcastSent
        broadcastLottie.isUserInteractionEnabled = false
        broadcastLottie.alpha = 0
        broadcastLottie.animation = checkAnimation
        //broadcastLottie.loopMode = .loop//.playOnce
        broadcastLottie.contentMode = .scaleAspectFill
        broadcastLottie.backgroundColor = .white//UIColor.red.withAlphaComponent(0.5)
        broadcastLottie.translatesAutoresizingMaskIntoConstraints = false
        whiteCoverView.addSubview(broadcastLottie)
        broadcastLottie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        broadcastLottie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        broadcastLottie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        broadcastLottie.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
}

//MARK: ACTIONS

extension ConfirmAlertView {
    
    @objc func animateViewsin() {
        
        self.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.opacityLayer.alpha = 0.7
            self.containerView.transform = CGAffineTransform(translationX: 1.05, y: 1.05)
            self.containerView.alpha = 1.0
        }) { (success) in
            UIView.animate(withDuration: 0.15, animations: {
                self.containerView.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            }) { (success) in
                UIView.animate(withDuration: 0.15) {
                    self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            }
        }
    }
    
    @objc func animateViewsOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.opacityLayer.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.containerView.alpha = 0
        }) { (success) in
            self.isHidden = true
            if self.lottieCompleted {
                self.delegate.didFinishCheckmarkAnimation()
                self.removeFromSuperview()
            } else {
                self.delegate.cancelTapped()
            }
        }
    }
    
    @objc func hideRocket() {
        UIView.animate(withDuration: 0.3, animations: {
            self.opacityLayer.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.containerView.alpha = 0
        }) { (success) in
            self.isHidden = true
            self.whiteCoverView.alpha = 0
            self.rocketLottie.alpha = 0
            if self.lottieCompleted {
                self.delegate.didFinishCheckmarkAnimation()
                //self.removeFromSuperview()
            }
        }
    }
    
    @objc func animateOutGoToLive() {
        UIView.animate(withDuration: 0.3, animations: {
            self.opacityLayer.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.containerView.alpha = 0
        }) { (success) in
            self.isHidden = true
            if self.lottieCompleted {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func showSpinner() {
        whiteCoverView.isHidden = false
        spinner.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.whiteCoverView.alpha = 1.0
            self.spinner.alpha = 1.0
        }) { (success) in
            
        }
    }
    
    @objc func animateBroadcastSuccess() {
        whiteCoverView.isHidden = false
        broadcastLottie.alpha = 1.0
        spinner.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.whiteCoverView.alpha = 1.0
            self.checkmarkLottie.alpha = 1.0
        }) { (success) in
            self.broadcastLottie.play(fromFrame: 0, toFrame: 196, loopMode: .playOnce) { (success) in
                self.lottieCompleted = true
                self.animateViewsOut()
                //self.delegate.didFinishCheckmarkAnimation()
            }
        }
    }
    
    @objc func showSuccess() {
        whiteCoverView.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.whiteCoverView.alpha = 1.0
            self.checkmarkLottie.alpha = 1.0
        }) { (success) in
            self.checkmarkLottie.play { (success) in
                print("done")
                self.lottieCompleted = true
                self.animateViewsOut()
            }
        }
    }
    
    @objc func rocketTime() {
        whiteCoverView.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.whiteCoverView.alpha = 1.0
            self.rocketLottie.alpha = 1.0
        }) { (success) in
            self.rocketLottie.play { (success) in
                print("done")
                self.lottieCompleted = true
                self.hideRocket()
            }
        }
    }
    
    @objc func showDeny() {
        whiteCoverView.isHidden = false
        spinner.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            self.whiteCoverView.alpha = 1.0
            self.denyLottie.alpha = 1.0
        }) { (success) in
            self.denyLottie.play { success in
                self.lottieCompleted = true
                self.perform(#selector(self.animateViewsOut), with: self, afterDelay: 0.25)
            }
            /*
            self.denyLottie.play(fromFrame: 0, toFrame: 20, loopMode: .playOnce) { (success) in
                print("done")
                self.lottieCompleted = true
                self.perform(#selector(self.animateViewsOut), with: self, afterDelay: 0.25)
            }
             */
        }
    }
    
    @objc func showError() {
        whiteCoverView.isHidden = false
        spinner.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            self.whiteCoverView.alpha = 1.0
            self.errorLottie.alpha = 1.0
        }) { (success) in
            self.errorLottie.play { success in
                self.lottieCompleted = true
                self.perform(#selector(self.animateViewsOut), with: self, afterDelay: 0.25)
            }
            /*
            self.denyLottie.play(fromFrame: 0, toFrame: 20, loopMode: .playOnce) { (success) in
                print("done")
                self.lottieCompleted = true
                self.perform(#selector(self.animateViewsOut), with: self, afterDelay: 0.25)
            }
             */
        }
    }
    
    @objc func showUploading() {
        
        UIView.animate(withDuration: 0.35) {
            self.contentView.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
            self.contentView.alpha = 0
        }
        
        playLoading()
        self.loadingView.isHidden = false
        UIView.animate(withDuration: 0.35, delay: 0.25, options: [], animations: {
            self.loadingView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.loadingView.alpha = 1.0
        }) { (succcess) in
            //self.delegate.didCompleteLoadingAnimation()
        }
    }
    
    @objc func playLoading() {
        self.loadingLottie.play(fromFrame: 0, toFrame: 17, loopMode: .playOnce) { (success) in
            self.delegate.didCompleteLoadingAnimation()
        }
    }
    
    @objc func playLoadingCompleted(popBack: Bool) {
        self.loadingLottie.play(fromFrame: 17, toFrame: 42, loopMode: .playOnce) { (success) in
            self.animateViewsOut()
            if popBack {
                self.perform(#selector(self.doThePopBack), with: self, afterDelay: 0.25)
            }
        }
    }
    
    @objc func doThePopBack() {
        self.delegate.popVCBack()
    }
    
}

