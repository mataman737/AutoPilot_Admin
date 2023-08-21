//
//  PickOptionViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit

protocol PickOptionViewControllerDelegate: AnyObject {
    func didPickOption(optionSelected: String)
}

class PickOptionViewController: UIViewController {
    
    weak var delegate: PickOptionViewControllerDelegate?
    var opacityLayer = UIView()
    var cardContainer = UIView()
    var cardHeight: NSLayoutConstraint!
    var titleLabel = UILabel()
    var downArrow = UIImageView()
    var downButton = UIButton()
    var copyButton = UIButton()
    var linkLabel = UILabel()
    
    var purpGradientBG = UIImageView()
    var qrImageView = UIImageView()
    var shareURLButton = ContinueButton()
    var copyURLButton = UIButton()

    var timePickerView = UIPickerView()
    var options: [String] = ["English", "Spanish", "Portuguese", "Japanese", "Korean", "French", "Russian", "Chinese"]
    var rowSelected = 0
    
    var optionSelected = false
    var fromSplash = false
    var isDarkMode = false
    var textColor: UIColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLaunchTransition()
        perform(#selector(presentViews), with: self, afterDelay: 0.05)
        
        let opacityTapped = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        opacityLayer.addGestureRecognizer(opacityTapped)
        downButton.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
    }

}

//MARK: ACTIONS

extension PickOptionViewController {
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
    
    @objc func hideCard() {
        self.cardContainer.isHidden = true
    }
    
    @objc func dismissViews() {
        lightImpactGenerator()
        UIView.animate(withDuration: 0.2, animations: {
            self.opacityLayer.alpha = 0
            self.cardContainer.transform = CGAffineTransform(translationX: 0, y: 385)
        }) { (success) in
            self.dismiss(animated: true) {
                if self.optionSelected {
                    self.delegate?.didPickOption(optionSelected: self.options[self.rowSelected])
                }
            }
        }
    }
    
    @objc func updateTapped() {
        lightImpactGenerator()
        self.optionSelected = true
        dismissViews()
    }
}

//MARK: PICKER DELEGATE & DATASOURCE

extension PickOptionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        return NSAttributedString(string: options[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
                
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return view.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
    }
    
}


