//
//  OneTimeCodeTextField.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/30/23.
//

import UIKit

class OneTimeCodeTextField: UITextField {

    var didEnterLastDigit: ((String) -> Void)?
    
    var defaultCharacter = ""
    
    private var isConfigured = false
    
    private var digitLabels = [UILabel]()
    var isFour = false
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    func configure(with slotCount: Int = 6) { //4 or 6
        guard isConfigured == false else { return }
        isConfigured.toggle()
        
        configureTextField()
        
        let labelsStackView = createLabelsStackView(with: slotCount)
        addSubview(labelsStackView)
        
        addGestureRecognizer(tapRecognizer)
        
        labelsStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
    }

    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        backgroundColor = .clear
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelsStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        if isFour {
            stackView.spacing = 18
        } else {
            stackView.spacing = 12
        }
        stackView.backgroundColor = .clear
        stackView.layer.cornerRadius = 8
        stackView.layer.masksToBounds = true
        
        for _ in 1 ... count {
                            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            if isFour {
                label.font = .systemFont(ofSize: 40)
            } else {
                label.font = .systemFont(ofSize: 35) //30
            }
            label.textColor = .black
            label.isUserInteractionEnabled = true
            label.text = defaultCharacter
            label.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            label.layer.borderWidth = 1
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = .white
            stackView.addArrangedSubview(label)
            
            digitLabels.append(label)
        }
        
        return stackView
    }
    
    @objc
    private func textDidChange() {
        
        guard let text = self.text, text.count <= digitLabels.count else { return }
        
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text = defaultCharacter
            }
        }
        
        if text.count == digitLabels.count {
            didEnterLastDigit?(text)
        }
    }
    
}

extension OneTimeCodeTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitLabels.count || string == ""
    }
}


