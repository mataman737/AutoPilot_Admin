//
//  BlurredView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/3/23.
//

import Foundation
import UIKit

class BlurredView: UIView {

    let containerView = UIView()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
   }
}

// MARK: Helpers

extension BlurredView {
    func setupViews() {
        
        // 1. create container view
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        containerView.fillSuperview()
        
        // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .dark)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.75)
        customBlurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        // 3. create semi-transparent black view
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.5)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        
        // 4. add both as subviews
        containerView.addSubview(customBlurEffectView)
        customBlurEffectView.fillSuperview()
        containerView.addSubview(dimmedView)
        dimmedView.fillSuperview()
        
        
    }
}
