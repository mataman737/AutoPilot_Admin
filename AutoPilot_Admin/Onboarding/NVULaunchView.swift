//
//  NVULaunchView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/3/23.
//

import UIKit

protocol NVULaunchViewDelegate: AnyObject {
    func didFinishLaunchVideo()
}

class NVULaunchView: UIView {
    
    var swLogoImageView = UIImageView()
        
    weak var delegate: NVULaunchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if let color = UIColor.hexToUIColor("#202020") {
            self.backgroundColor = color
        }        
        setupViews()
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}

//MARK: VIEWS

extension NVULaunchView {
    func setupViews() {
        swLogoImageView.image = UIImage(named: "smartTraderLogoDark")
        swLogoImageView.contentMode = .scaleAspectFit
        swLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(swLogoImageView)
        swLogoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        swLogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        swLogoImageView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        swLogoImageView.widthAnchor.constraint(equalToConstant: 240).isActive = true
    }
    
    @objc func hideLaunch() {
        
        UIView.animate(withDuration: 0.35, delay: 0.5, options: []) {
            self.swLogoImageView.alpha = 0
            self.swLogoImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        } completion: { success in
            UIView.animate(withDuration: 0.2) {
                self.alpha = 0
            } completion: { success in
                self.removeFromSuperview()
                self.isUserInteractionEnabled = false
            }
        }
        
    }
}

//MARK: SET UP VIDEO & AUDIO ------------------------------------------------------------------------------------------------------------------------------------

extension NVULaunchView {
    
}
