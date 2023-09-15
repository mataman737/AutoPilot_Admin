//
//  TimeOptionView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/14/23.
//

import UIKit

class TimeOptionView: UIButton {
    
    var blueView = UIView()
    var timeLabel = UILabel()

    override init(frame: CGRect) {
       super.init(frame: frame)
       self.backgroundColor = .clear
       setupViews()
       
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}

// MARK: VIEWS

extension TimeOptionView {
    
    func setupViews() {
        
        blueView.isHidden = false
        blueView.alpha = 0
        blueView.backgroundColor = .black
        blueView.layer.cornerRadius = 28/2
        blueView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(blueView)
        //blueView.fillSuperview()
        blueView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blueView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blueView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blueView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        timeLabel.textColor = .swBlue
        timeLabel.textAlignment = .center
        timeLabel.font = .sofiaProMedium(ofSize: 11)
        timeLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        timeLabel.numberOfLines = 0
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeLabel)
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 1).isActive = true
        
    }
    
    @objc func showBlueView() {
        UIView.animate(withDuration: 0.2) {
            self.timeLabel.textColor = .white
            self.blueView.alpha = 1.0
            self.blueView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    @objc func hideBlueView() {
        UIView.animate(withDuration: 0.2) {
            self.timeLabel.textColor = UIColor.newBlack.withAlphaComponent(0.5)
            self.blueView.alpha = 0
            self.blueView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }
    }
    
}

