//
//  NewNotificationViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/28/23.
//

import Foundation
import UIKit
import FSCalendar
import DateTimePicker
import PWSwitch

extension NewNotificationViewController {
    
    func setupViews() {
        
        opacityLayer.backgroundColor = .black
        opacityLayer.alpha = 0
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(opacityLayer)
        opacityLayer.fillSuperview()
        
        animationContainer.alpha = 1.0
        animationContainer.backgroundColor = .clear
        animationContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(animationContainer)
        animationContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        animationContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        animationContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        animationTop = animationContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
        animationTop.isActive = true
        //animationContainer.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        
        containerView.alpha = 1.0
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        animationContainer.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: animationContainer.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: animationContainer.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: animationContainer.bottomAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: animationContainer.topAnchor).isActive = true
        
        navView.layer.zPosition = 3
        navView.backgroundColor = .white
        navView.layer.shadowColor = UIColor.black.cgColor
        navView.layer.shadowOffset = CGSize(width: 0, height: 2)
        navView.layer.shadowOpacity = 0
        navView.layer.shadowRadius = 4
        navView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        navView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 65)).isActive = true
        
        pickInterestLabel.text = "New Notification"
        pickInterestLabel.textAlignment = .center
        pickInterestLabel.textColor = UIColor(red: 73/255, green: 73/255, blue: 73/255, alpha: 1.0)
        pickInterestLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 23))
        pickInterestLabel.numberOfLines = 0
        pickInterestLabel.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(pickInterestLabel)
        pickInterestLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        pickInterestLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        
        dismissImageView.image = UIImage(named: "dismissArrow")
        dismissImageView.contentMode = .scaleAspectFill
        dismissImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(dismissImageView)
        dismissImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .createAspectRatio(value: 18)).isActive = true
        dismissImageView.centerYAnchor.constraint(equalTo: pickInterestLabel.centerYAnchor, constant: 0).isActive = true
        dismissImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 11.67)).isActive = true
        dismissImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 21)).isActive = true
        
        dismissButton.addTarget(self, action: #selector(animateViewsOut), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(dismissButton)
        dismissButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: dismissImageView.trailingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        
        mainScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.1)
        mainScrollView.automaticallyAdjustsScrollIndicatorInsets = false
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(mainScrollView)
        mainScrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        mainScrollView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        
        let didTapImage = UITapGestureRecognizer(target: self, action: #selector(didSelectMedia))
        notificationImageView.addGestureRecognizer(didTapImage)
        notificationImageView.isUserInteractionEnabled = true
        notificationImageView.image = UIImage(named: "squarePhotoPH")
        notificationImageView.backgroundColor = .clear
        notificationImageView.layer.cornerRadius = 8
        notificationImageView.layer.masksToBounds = true
        notificationImageView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(notificationImageView)
        notificationImageView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        //notificationImageView.trailingAnchor.constraint(equalTo: navView.centerXAnchor, constant: -10).isActive = true
        notificationImageView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        notificationImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 73)).isActive = true
        notificationImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 73)).isActive = true        
        
        //Event Name
        
        eventNameContainer.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0)
        eventNameContainer.layer.cornerRadius = 10
        eventNameContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(eventNameContainer)
        eventNameContainer.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: .createAspectRatio(value: 21)).isActive = true
        //accessContainer.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -21).isActive = true
        eventNameContainer.topAnchor.constraint(equalTo: notificationImageView.bottomAnchor, constant: .createAspectRatio(value: 16)).isActive = true
        eventNameContainer.widthAnchor.constraint(equalToConstant: view.frame.width - .createAspectRatio(value: 42)).isActive = true
        eventNameContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 62)).isActive = true
        
        var placeHolder = NSMutableAttributedString()
        let Name  = "Notification Title"
        placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont.poppinsSemiBold(ofSize: 21)])
        placeHolder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0), range:NSRange(location:0,length:Name.count))
        notificationNameTextField.attributedPlaceholder = placeHolder
        notificationNameTextField.autocorrectionType = .no
        notificationNameTextField.font = .poppinsBold(ofSize: 21)
        notificationNameTextField.textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
        notificationNameTextField.tintColor = .themeBlack
        notificationNameTextField.returnKeyType = .done
        notificationNameTextField.delegate = self
        notificationNameTextField.tag = 1
        notificationNameTextField.translatesAutoresizingMaskIntoConstraints = false
        eventNameContainer.addSubview(notificationNameTextField)
        notificationNameTextField.leadingAnchor.constraint(equalTo: eventNameContainer.leadingAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        notificationNameTextField.trailingAnchor.constraint(equalTo: eventNameContainer.trailingAnchor, constant: -.createAspectRatio(value: 8)).isActive = true
        notificationNameTextField.topAnchor.constraint(equalTo: eventNameContainer.topAnchor, constant: 0).isActive = true
        notificationNameTextField.bottomAnchor.constraint(equalTo: eventNameContainer.bottomAnchor, constant: 0).isActive = true
        
        //Message
        
        messageContainer.layer.cornerRadius = 14
        messageContainer.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0)
        messageContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(messageContainer)
        messageContainer.leadingAnchor.constraint(equalTo: eventNameContainer.leadingAnchor, constant: 0).isActive = true
        messageContainer.trailingAnchor.constraint(equalTo: eventNameContainer.trailingAnchor, constant: 0).isActive = true
        messageContainer.topAnchor.constraint(equalTo: eventNameContainer.bottomAnchor, constant: .createAspectRatio(value: 16)).isActive = true
        messageContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 138)).isActive = true
                
        messageTextView.font = .poppinsBold(ofSize: .createAspectRatio(value: 21))
        messageTextView.delegate = self
        messageTextView.autocorrectionType = .no
        messageTextView.textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
        messageTextView.tintColor = .themeBlack
        messageTextView.layer.cornerRadius = 14
        messageTextView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageContainer.addSubview(messageTextView)
        messageTextView.leadingAnchor.constraint(equalTo: messageContainer.leadingAnchor, constant: .createAspectRatio(value: 11)).isActive = true
        messageTextView.trailingAnchor.constraint(equalTo: messageContainer.trailingAnchor, constant: -.createAspectRatio(value: 11)).isActive = true
        messageTextView.topAnchor.constraint(equalTo: messageContainer.topAnchor, constant: .createAspectRatio(value: 11)).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: messageContainer.bottomAnchor, constant: -.createAspectRatio(value: 11)).isActive = true
        
        nextButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: .createAspectRatio(value: 48)))
        nextButton.setTitle("Confirm", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = .poppinsBold(ofSize: .createAspectRatio(value: 18))
        if messageEmpty {
            nextButton.backgroundColor = .themeInActive
        } else {
            nextButton.backgroundColor = .themeBlack
        }
        nextButton.addTarget(self, action: #selector(didTapEndTextInput), for: .touchUpInside)
        messageTextView.inputAccessoryView = nextButton
        
        titleLimitLabel.text = "0/\(titleLimit)"
        titleLimitLabel.textAlignment = .right
        titleLimitLabel.textColor = .white
        titleLimitLabel.font = .poppinsRegular(ofSize: .createAspectRatio(value: 14))
        titleLimitLabel.numberOfLines = 0
        titleLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addSubview(titleLimitLabel)
        titleLimitLabel.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
        titleLimitLabel.trailingAnchor.constraint(equalTo: nextButton.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        
        messageLimitLabel.isHidden = true
        messageLimitLabel.text = "0/\(messageLimit)"
        messageLimitLabel.textAlignment = .right
        messageLimitLabel.textColor = .white
        messageLimitLabel.font = .poppinsRegular(ofSize: .createAspectRatio(value: 14))
        messageLimitLabel.numberOfLines = 0
        messageLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addSubview(messageLimitLabel)
        messageLimitLabel.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
        messageLimitLabel.trailingAnchor.constraint(equalTo: nextButton.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        
        notificationNameTextField.inputAccessoryView = nextButton
        
        placeHolderLabel.text = "Notification message"
        placeHolderLabel.textAlignment = .left
        placeHolderLabel.font = .poppinsBold(ofSize: .createAspectRatio(value: 21))
        placeHolderLabel.textColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0)
        placeHolderLabel.numberOfLines = 0
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        messageContainer.addSubview(placeHolderLabel)
        placeHolderLabel.leadingAnchor.constraint(equalTo: messageContainer.leadingAnchor, constant: .createAspectRatio(value: 16)).isActive = true
        placeHolderLabel.trailingAnchor.constraint(equalTo: messageContainer.trailingAnchor, constant: -.createAspectRatio(value: 11)).isActive = true
        placeHolderLabel.topAnchor.constraint(equalTo: messageContainer.topAnchor, constant: .createAspectRatio(value: 19)).isActive = true
        
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        confirmButton.layer.zPosition = 2
        confirmButton.isUserInteractionEnabled = true
        confirmButton.purpleBG.image = UIImage(named: "")
        confirmButton.purpleBG.backgroundColor = .black
        confirmButton.layer.cornerRadius = .createAspectRatio(value: 48)/2
        confirmButton.layer.masksToBounds = true
        //nextButton.purpleBG.backgroundColor = .themePurple
        confirmButton.continueLabel.text = "Send Notification"
        confirmButton.confirmLabel.text = "Please wait for video to finish"
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(confirmButton)
        confirmButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .createAspectRatio(value: 26)).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.createAspectRatio(value: 26)).isActive = true
        //nextButton.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: buttonBottom).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.createAspectRatio(value: 42)).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 48)).isActive = true
        
        //Confirm View
        
        confirmView.delegate = self
        confirmView.reqTitleLabel.text = "Send Notification"
        confirmView.confirmLabel.text = "SEND"
        confirmView.confirmLabel.textColor = .themeBlack
        confirmView.reqDetailLabel.text = "By tapping send, all users will receive this custom push notification. This action cannot be undone."
        confirmView.confirmButton.addTarget(self, action: #selector(sendBroadcast), for: .touchUpInside)
        confirmView.layer.zPosition = 10
        confirmView.isHidden = true
        confirmView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(confirmView)
        confirmView.fillSuperview()
        
        
    }
    
    func setupCalendar() {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date())
        let min = currentDate
        let max = calendar.date(byAdding: .day, value: 90, to: currentDate)!
        //let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker?.is12HourFormat = true
        if let esttz = TimeZone(identifier: "America/New_York") {
            picker?.timeZone = esttz
        }
        picker?.delegate = self
        picker?.dateFormat = "h:mma - MMMM d, yyyy"
        picker?.includesMonth = true
        picker?.highlightColor = .nvuBlueOne
        picker?.doneBackgroundColor = .nvuBlueOne
    }
    
}
