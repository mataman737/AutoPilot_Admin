//
//  PickTraderTypeViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 11/27/23.
//

import UIKit

protocol PickTraderTypeViewControllerDelegate: AnyObject {
    func didTapTrader(type: String)
}

class PickTraderTypeViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var isNVUDemo = UserDefaults()
    var isDarkMode = UserDefaults()
    var opacityLayer = UIView()
    var mainScrollView = UIScrollView()
    var wrapper = UIView()
    var mainContainer = UIView()
    var navView = UIView()
    var navTitleLabel = UILabel()
    var dateLabel = UILabel()
    var keyLine = UIView()
    var leadImageView = UIImageView()
    var leadNameLabel = UILabel()
    var recentSignalsOption = OptionsView()
    var longTermSignalsOption = OptionsView()
    //var successCheck = LottieAnimationView()
    var addedToWatchListLabel = UILabel()
    let toastView = ToastNotificationView()
    
    var isDismissing = false
    var didTapCreate = false
    var didTapJoin = false
    var leadName: String = ""
                
    weak var delegate: PickTraderTypeViewControllerDelegate?
    var entryPriceLock = UIImageView()
    
    var textColor: UIColor = UIColor.white

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupColors()
        perform(#selector(animateViewsIn), with: self, afterDelay: 0.01)
    }
}

//MARK: ACTIONS

extension PickTraderTypeViewController {
    @objc func animateViewsIn() {
        self.mainContainer.presentAndBounce()
        UIView.animate(withDuration: 0.2) {
            self.opacityLayer.alpha = 0.75
        }
    }
    
    @objc func newFollowupReminderTapped() {
        lightImpactGenerator()
        didTapCreate = true
        self.dimissVC()
    }
    
    @objc func didTapMarketingCenter() {
        lightImpactGenerator()
        didTapJoin = true
        self.dimissVC()
    }
    
    @objc func dimissVC() {
        UIView.animate(withDuration: 0.2) {
            self.mainScrollView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.opacityLayer.alpha = 0
        } completion: { (success) in
            self.dismiss(animated: false) {
                if self.didTapCreate {
                    self.delegate?.didTapTrader(type: "trader")
                }
                
                if self.didTapJoin {
                    self.delegate?.didTapTrader(type: "admin")
                }
                                
            }
        }
    }
}

//MARK: SCROLLVIEW DELEGATE

extension PickTraderTypeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 1 {
            let yOffset = scrollView.contentOffset.y// + 44
            if yOffset > -44 {
                scrollView.setContentOffset(CGPoint(x: 0, y: -44), animated: false)
            }
            
            if yOffset < -85 {
                if !isDismissing {
                    dimissVC()
                    isDismissing = true
                }
            }
        }
                
    }
}

