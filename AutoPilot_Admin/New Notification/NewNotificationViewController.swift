//
//  NewNotificationViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/28/23.
//

import UIKit
import YPImagePicker
import WXImageCompress
import FSCalendar
import DateTimePicker
import PWSwitch

protocol NewNotificationViewControllerDelegate: AnyObject {
    func showNotiLoading()
    func didCreateNewNotification()
}

class NewNotificationViewController: UIViewController {

    weak var delegate: NewNotificationViewControllerDelegate?
    var opacityLayer = UIView()
    var animationContainer = UIView()
    var animationTop: NSLayoutConstraint!
    var topDistance: CGFloat = 64
    var mainScrollView = UIScrollView()
    var containerView = UIView()
    var navView = UIView()
    var pickInterestLabel = UILabel()
    var stepLabel = UILabel()
    var dismissImageView = UIImageView()
    var dismissButton = UIButton()
    var messageContainer = UIView()
    var messageTextView = UITextView()
    var placeHolderLabel = UILabel()
    var nextButton = UIButton()
    var confirmView = ConfirmAlertView()
    var notificationImageView = UIImageView()
    var eventNameContainer = UIView()
    var notificationNameTextField = UITextField()
    var productImageView = UIImageView()
    var notificationTitleCreated = false
    var messageEmpty = true
    var currentText = ""
    var notiTitleString = ""
    var notiMessageString = ""
    let titleLimitLabel = UILabel()
    var messageLimitLabel = UILabel()
    var titleLimit = 25
    var messageLimit = 100
    var isEnteringTitle = true
    var isDoingPhoto = false
    var isDoingProduct = false
    var image: UIImage?
    var photoUrl: String?
    var typeSelected = 0
    var accessContainer = UIView()
    var accessTextField = UITextField()
    var regionContainer = UIButton()
    var regionLabel = UILabel()
    var userTypeContainer = UIButton()
    var userTypeLabel = UILabel()
    var dateTimeContainer = UIButton()
    var dateTimeLabel = UILabel()
    var confirmButton = ContinueButton()
    var languageOptions: [String] = ["English", "Spanish", "Korean", "Chinese", "Portuguese"]
    var memberTypeOptions: [String] = ["All Users", "Associate", "Customer", "Free", "Pending"]
    var selectedLanguage = ""
    var selectedMemberType = ""
    //weak var calendar: FSCalendar!
    var selectedDates = [Date]()
    var textColor: UIColor = UIColor.white
    var isScheduledNotificationSwitchOn = false
    var pwSubSwitchContainer = UIView()
    var pwSubSwitch = PWSwitch()
    var selectedNotificationDate: Date?
    var urlToPassContainer = UIView()
    var urlToPassTextField = UITextField()
    
    //let calendar = Calendar.current
    //let currentDate = calendar.startOfDay(for: Date())
    //let min = currentDate
    //let max = calendar.date(byAdding: .day, value: 90, to: currentDate)!
    //let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
    
    var picker: DateTimePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCalendar()
        //perform(#selector(showViews), with: self, afterDelay: 0.01)
    }

}

//MARK: ACTIONS

extension NewNotificationViewController: PickOptionViewControllerDelegate {
    func didPickOption(optionSelected: String) {
        if typeSelected == 0 {
            regionLabel.text = optionSelected
            regionLabel.textColor = .black
            
            switch optionSelected {
            case "English":
                selectedLanguage = "en"
            case "Spanish":
                selectedLanguage = "es"
            case "Korean":
                selectedLanguage = "ko"
            case "Japanese":
                selectedLanguage = "ja"
            case "Chinese":
                selectedLanguage = "zh-Hans"
            case "Portuguese":
                selectedLanguage = "pt-BR"
            default:
                selectedLanguage = "en"
            }
            
        } else {
            selectedMemberType = optionSelected
            userTypeLabel.text = optionSelected
            userTypeLabel.textColor = .black
                        
        }
    }
    
    @objc func subOnSwitchChanged() {
        lightImpactGenerator()
        if isScheduledNotificationSwitchOn {
            isScheduledNotificationSwitchOn = false
            dateTimeLabel.text = "Date & Time (optional)"
            dateTimeLabel.textColor = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0)
            selectedNotificationDate = nil
        } else {
            isScheduledNotificationSwitchOn = true
            
        }
    }
}

//MARK: ACTIONS

extension NewNotificationViewController {
    
    @objc func didTapDateTime() {
        lightImpactGenerator()
        picker?.show()
    }
    
    @objc func didTapOrderType(sender: UIButton) {
        
        let pickOptionVC = PickOptionViewController()
        pickOptionVC.modalPresentationStyle = .overFullScreen
        pickOptionVC.delegate = self
        
        if sender.tag == 0 {
            typeSelected = 0
            pickOptionVC.titleLabel.text = "Pick Language"
            pickOptionVC.shareURLButton.continueLabel.text = "Confirm Language"
            pickOptionVC.options = languageOptions
        } else {
            typeSelected = 1
            pickOptionVC.titleLabel.text = "Pick Member Type"
            pickOptionVC.shareURLButton.continueLabel.text = "Confirm Member Type"
            pickOptionVC.options = memberTypeOptions
        }
                
        self.present(pickOptionVC, animated: false, completion: nil)
    }
    
    @objc func sendBroadcast() {
            
        if isScheduledNotificationSwitchOn {
            if selectedNotificationDate == nil {
                errorImpactGenerator()
                let toastNoti = ToastNotificationView()
                toastNoti.present(withMessage: "Set a date and time!")
                confirmView.animateViewsOut()
                return
            }
        } else {
            selectedNotificationDate = nil
        }
            
        
        confirmView.animateBroadcastSuccess()

        if let image = image {
            let key = "notification:\(UUID().uuidString)"
            ImageUploader.uploadImage(image: image.wxCompress(), key: key, completion: { [weak self] (error, success, url) in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                guard success else {
                    print("error uploading image")
                    return
                }
                      
                let notification = Notification(title: self?.notificationNameTextField.text, userId: nil/*Admin.current.id*/, enigmaId: Admin.current.enigmaId, subtitle: nil, body: self?.messageTextView.text, itemUrl: self?.urlToPassTextField.text, imageUrl: url, language: self?.selectedLanguage, userType: nil, added: Date(), scheduled: self?.selectedNotificationDate)
                print("\(notification) 🚨🚨🚨")
                self?.delegate?.showNotiLoading()
                API.sharedInstance.sendNotification(notification: notification) { success, _, error in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    
                    guard success else {
                        print("error sending notification")
                        return
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.didCreateNewNotification()
                    }
                }
            })
        } else {
            let notification = Notification(title: self.notificationNameTextField.text, userId: nil/*Admin.current.id*/, enigmaId: Admin.current.enigmaId, subtitle: nil, body: self.messageTextView.text, itemUrl: self.urlToPassTextField.text, imageUrl: nil, language: self.selectedLanguage, userType: nil, added: Date(), scheduled: self.selectedNotificationDate)
            self.delegate?.showNotiLoading()
            API.sharedInstance.sendNotification(notification: notification) { success, _, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                guard success else {
                    print("error sending notification")
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.didCreateNewNotification()
                }
            }
        }
    }
    
    @objc func showViews() {
        UIView.animate(withDuration: 0.4, animations: {
            self.animationContainer.transform = CGAffineTransform(translationX: 0, y: -10)
            //self.messageTextView.becomeFirstResponder()
            //self.notificationNameTextField.becomeFirstResponder()
            self.opacityLayer.alpha = 0.75
        }) { (success) in
            UIView.animate(withDuration: 0.2, animations: {
                self.animationContainer.transform = CGAffineTransform(translationX: 0, y: 10)
            }) { (success) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.animationContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                }) { (success) in
                    //
                }
            }
        }
    }
    
    @objc func animateViewsOut() {
        print("did this")
        
        /*
        UIView.animate(withDuration: 0.35, animations: {
            self.animationContainer.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.opacityLayer.alpha = 0
            self.view.endEditing(true)
        }) { (success) in
            self.dismiss(animated: false) {
                //
            }
        }
        */
        
        self.dismiss(animated: true) {
            //
        }
        
    }
    
    @objc func changeToUpdate() {
        if notificationTitleCreated && !messageEmpty {
            nextButton.backgroundColor = .themeBlack
        } else {
            nextButton.backgroundColor = .themeInActive
        }
    }
    
    @objc func didTapEndTextInput() {
        self.view.endEditing(true)
    }
    
    @objc func didTapConfirm() {
        if accessTextField.text == "Gorda" && selectedLanguage != "" && selectedMemberType != "" {
            confirmView.animateViewsin()
        } else {
            errorImpactGenerator()
            let toastNoti = ToastNotificationView()
            toastNoti.present(withMessage: "Incorrect Permission Code!")
        }
    }
    
}

//MARK: EVENT MEDIA DELEGATE & PICK IMAGE DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension NewNotificationViewController: PickImageVideoViewControllerDelegate {
    func didPickImage(image: UIImage, isVideo: Bool, url: URL?) {
        self.image = image
        notificationImageView.image = image
        isDoingPhoto = true
        notificationNameTextField.becomeFirstResponder()
        print("💋💋💋\(url)💋💋💋")
    }
    
    @objc func didSelectMedia() {
        if isDoingProduct {
            errorImpactGenerator()
        } else {
            let pickImageVC = PickImageVideoViewController()
            pickImageVC.isCoverorDetailPhoto = true
            pickImageVC.delegate = self
            pickImageVC.view.backgroundColor = .clear
            pickImageVC.modalPresentationStyle = .overFullScreen
            self.present(pickImageVC, animated: true)
        }
    }
}

//MARK: TEXTVIEW DELEGATE

extension NewNotificationViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        titleLimitLabel.isHidden = true
        messageLimitLabel.isHidden = false
        isEnteringTitle = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            self.view.endEditing(true)
            return false
        } else {
            let  char = text.cString(using: String.Encoding.utf8)!
               
            let isBackSpace = strcmp(char, "\\b")
               
            if (isBackSpace == -92) {
                currentText = textView.text!.substring(to: textView.text!.index(before: textView.text!.endIndex))
            }
            else {
                currentText = textView.text! + text
            }
            
            //notiTitleString = currentText
            
            notiMessageString = currentText
            
            //print("\(notiMessageString.count) - 🤢🤢🤢")
            
            if currentText != "" {
                placeHolderLabel.isHidden = true
                
                if notiMessageString.count > messageLimit {
                    messageEmpty = true
                } else {
                    messageEmpty = false
                }
                
            } else {
                placeHolderLabel.isHidden = false
                messageEmpty = true
                //nextButton.backgroundColor = .themeInActive
            }
            
            messageLimitLabel.text = "\(notiMessageString.count)/\(messageLimit)"
            
            changeToUpdate()
            
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleLimitLabel.isHidden = false
        messageLimitLabel.isHidden = true
        isEnteringTitle = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var updatedTextString : NSString = textField.text! as NSString
        updatedTextString = updatedTextString.replacingCharacters(in: range, with: string) as NSString
       //self.methodYouWantToCallWithUpdatedString(updatedTextString)
        
        if textField.tag == 1 {
            if updatedTextString as String != "" {
                
                if notiTitleString.count > titleLimit {
                    notificationTitleCreated = false
                } else {
                    notificationTitleCreated = true
                }
                
                
            } else {
                notificationTitleCreated = false
            }
            
            notiTitleString = updatedTextString as String
            
            titleLimitLabel.text = "\(notiTitleString.count)/\(titleLimit)"
            
            changeToUpdate()
        }
        
        //print("\(textField.tag) - \(updatedTextString) - ❤️❤️❤️")
                
       return true
    }
    
}

//MARK: CONFIRM VIEW DELEGATE

extension NewNotificationViewController: ConfirmAlertViewDelegte {
    func cancelTapped() {
        if isEnteringTitle {
            //self.notificationNameTextField.becomeFirstResponder()
        } else {
            //self.messageTextView.becomeFirstResponder()
        }
    }
    
    func didFinishCheckmarkAnimation() {
        successImpactGenerator()
        animateViewsOut()
        //delegate?.didCreateNewNotification(broadCastTitle: notiTitleString, broadCastMessage: notiMessageString, imageUrl: self.photoUrl)
    }
    
    func popVCBack() {
        //
    }
    
    func didCompleteLoadingAnimation() {
        //
    }
}

//MARK: CALENDAR DELEGATE & DATASOURCE

extension NewNotificationViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func updateDateFormat(pickedDate: Date, updateFirstDay: Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(
            [.calendar, .timeZone,
             .era, .quarter,
             .year, .month, .day,
             .hour, .minute, .second, .nanosecond,
             .weekday, .weekdayOrdinal,
             .weekOfMonth, .weekOfYear, .yearForWeekOfYear],
            from: pickedDate)
        
                
        if let dateMonth = dateComponents.month {
            print("🩸 - \(dateMonth) - 🩸")
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return .black
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if !selectedDates.contains(date) {
            selectedDates.append(date)
        }
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDates.removeAll(where: {$0 == date})
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }

        return array
    }
    
}

extension NewNotificationViewController: DateTimePickerDelegate {
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        selectedNotificationDate = didSelectDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma - MMMM d, yyyy"
        let formattedDate = dateFormatter.string(from: didSelectDate)
        //print("\(formattedDate) 👑👑👑 \(picker)")
        dateTimeLabel.text = formattedDate
        dateTimeLabel.textColor = .black
    }
    
}
