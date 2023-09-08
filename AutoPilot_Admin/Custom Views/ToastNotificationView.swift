//
//  ToastNotificationView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit

class ToastNotificationView: UIView {

    var isNVUDemo = UserDefaults()
    private var isPresented = false
    var toastView: UIImageView!
    var toastMessageLabel: UILabel!
    var message = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //ImpactGenerator.prepare()
    }
    
    func present(withMessage message: String) {
        DispatchQueue.main.async {
            self.present(message: message, isError: false)
        }
    }
    
    func presentError(withMessage message: String) {
        present(message: message, isError: true)
    }
    
    private func present(message: String, isError: Bool) {
        
        self.message = message
        
        DispatchQueue.main.async {
            
            self.perform(#selector(self.runAnimation), with: self, afterDelay: 0.01)
            /*
            if self.isPresented { return }

            if let view = UIApplication.shared.keyWindow {
                self.isPresented = true

                let xPosition = (view.frame.width / 2) - .createAspectRatio(value: 135)
                self.toastView = UIImageView(frame: CGRect(x: xPosition, y: -.createAspectRatio(value: 80), width: .createAspectRatio(value: 270), height: .createAspectRatio(value: 40)))
                self.toastView.backgroundColor = .themePurple//UIColor(red: 6/255, green: 145/255, blue: 201/255, alpha: 1.0)//isError
                //                ? .lightCrimson
                //                : .caribbeanGreen
                self.toastView.layer.borderWidth = .createAspectRatio(value: 1)
                self.toastView.alpha = 1
                self.toastView.layer.cornerRadius = .createAspectRatio(value: 6)
                self.toastView.layer.borderColor = UIColor.themePurple.withAlphaComponent(0.1).cgColor
                DispatchQueue.main.async {
                    view.addSubview(self.toastView)
                }

                self.toastView.layer.shadowColor = UIColor.black.cgColor//isError
                //                ? UIColor.lightCrimson.cgColor
                //                : UIColor.caribbeanGreen.cgColor
                self.toastView.layer.shadowOffset = CGSize(width: 0, height: .createAspectRatio(value: 15))
                self.toastView.layer.shadowOpacity = 0.2
                self.toastView.layer.shadowRadius = .createAspectRatio(value: 20)
                self.toastView.clipsToBounds = false
                self.toastView.image = UIImage(named: self.isNVUDemo.bool(forKey: "isNVUDemo") ? "buttonGradientNVU" : "buttonGradient")
                self.toastView.layer.masksToBounds = true
                self.toastView.contentMode = .scaleAspectFill

                self.toastMessageLabel = UILabel()
                self.toastMessageLabel.text = message
                self.toastMessageLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
                self.toastMessageLabel.textColor = .white
                self.toastMessageLabel.textAlignment = .center
                self.toastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
                self.toastView.addSubview(self.toastMessageLabel)
                self.toastMessageLabel.centerYAnchor.constraint(equalTo: self.toastView.centerYAnchor).isActive = true
                self.toastMessageLabel.leadingAnchor.constraint(equalTo: self.toastView.leadingAnchor).isActive = true
                self.toastMessageLabel.trailingAnchor.constraint(equalTo: self.toastView.trailingAnchor).isActive = true
                self.toastMessageLabel.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 25)).isActive = true

                UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.toastView.alpha = 1
                    self.toastView.transform = CGAffineTransform(translationX: 0, y: .createAspectRatio(value: 132))
                }) { _ in
                    UIView.animate(withDuration: 1.0, delay: 1.5/*0.75*/, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                        self.toastView.transform = CGAffineTransform(translationX: 0, y: 0)
                    }) { _ in
                        self.toastView.removeFromSuperview()
                        self.isPresented = false
                    }
                }
            }
            */
        }
    }
    
    @objc func runAnimation() {
        if self.isPresented { return }
        
        if let view = UIApplication.shared.keyWindow {
            self.isPresented = true
            
            let xPosition = (view.frame.width / 2) - .createAspectRatio(value: 135)
            self.toastView = UIImageView(frame: CGRect(x: xPosition, y: -.createAspectRatio(value: 80), width: .createAspectRatio(value: 270), height: .createAspectRatio(value: 40)))
            self.toastView.backgroundColor = .themePurple//UIColor(red: 6/255, green: 145/255, blue: 201/255, alpha: 1.0)//isError
            //                ? .lightCrimson
            //                : .caribbeanGreen
            self.toastView.layer.borderWidth = .createAspectRatio(value: 1)
            self.toastView.alpha = 1
            self.toastView.layer.cornerRadius = .createAspectRatio(value: 6)
            self.toastView.layer.borderColor = UIColor.themePurple.withAlphaComponent(0.1).cgColor
            DispatchQueue.main.async {
                view.addSubview(self.toastView)
            }
            
            self.toastView.layer.shadowColor = UIColor.black.cgColor//isError
            //                ? UIColor.lightCrimson.cgColor
            //                : UIColor.caribbeanGreen.cgColor
            self.toastView.layer.shadowOffset = CGSize(width: 0, height: .createAspectRatio(value: 15))
            self.toastView.layer.shadowOpacity = 0.2
            self.toastView.layer.shadowRadius = .createAspectRatio(value: 20)
            self.toastView.clipsToBounds = false
            self.toastView.image = UIImage(named: "buttonGradientNVU")
            self.toastView.layer.masksToBounds = true
            self.toastView.contentMode = .scaleAspectFill
            
            self.toastMessageLabel = UILabel()
            self.toastMessageLabel.text = self.message
            self.toastMessageLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 16))
            self.toastMessageLabel.textColor = .white
            self.toastMessageLabel.textAlignment = .center
            self.toastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
            self.toastView.addSubview(self.toastMessageLabel)
            self.toastMessageLabel.centerYAnchor.constraint(equalTo: self.toastView.centerYAnchor).isActive = true
            self.toastMessageLabel.leadingAnchor.constraint(equalTo: self.toastView.leadingAnchor).isActive = true
            self.toastMessageLabel.trailingAnchor.constraint(equalTo: self.toastView.trailingAnchor).isActive = true
            self.toastMessageLabel.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 25)).isActive = true
            
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.toastView.alpha = 1
                self.toastView.transform = CGAffineTransform(translationX: 0, y: .createAspectRatio(value: 132))
            }) { _ in
                UIView.animate(withDuration: 1.0, delay: 1.5/*0.75*/, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                    self.toastView.transform = CGAffineTransform(translationX: 0, y: 0)
                }) { _ in
                    self.toastView.removeFromSuperview()
                    self.isPresented = false
                }
            }
        }
    }
    
}



