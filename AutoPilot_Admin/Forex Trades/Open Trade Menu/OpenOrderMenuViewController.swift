//
//  OpenOrderMenuViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/6/23.
//

import UIKit
import Lottie

protocol OpenOrderMenuViewControllerDelegate: AnyObject {
    func didTapModifyTrade(signal: MTInstantTradeStatus)
    func didTapCloseTrade(signal: MTInstantTradeStatus)
}

class OpenOrderMenuViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    weak var delegate: OpenOrderMenuViewControllerDelegate?
    var isDarkMode = UserDefaults()
    var opacityLayer = UIView()
    var mainScrollView = UIScrollView()
    var wrapper = UIView()
    var mainContainer = UIView()
    var tradeDetailsContainer = UIView()
    var detailDivider = UIView()
    var entryPriceTitleLabel = UILabel()
    var currentPriceTitleLabel = UILabel()
    var entryPriceLabel = UILabel()
    var currentPriceLabel = UILabel()
    var arrowImageView = UIImageView()
    var unrealizedProfitTitleLabel = UILabel()
    var unrealizedProfitLabel = UILabel()
    var takeProfitTitleLabel = UILabel()
    var takeProfitLabel = UILabel()
    var stopLossTitleLabel = UILabel()
    var stopLossLabel = UILabel()
    var loadingIndicator = UIActivityIndicatorView(style: .medium)
    var cpLoadingIndicator = UIActivityIndicatorView(style: .medium)
    var navView = UIView()
    var navTitleLabel = UILabel()
    var keyLine = UIView()
    var modifyTradeOption = OptionsView()
    var closeTradeOption = OptionsView()
    var isDismissing = false
    var isModifyTrade = false
    var isCloseTrade = false
    var forexSignal: MTInstantTradeStatus!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        perform(#selector(animateViewsIn), with: self, afterDelay: 0.01)
    }
}

//MARK: ACTIONS

extension OpenOrderMenuViewController {
    @objc func animateViewsIn() {
        UIView.animate(withDuration: 0.25) {
            self.opacityLayer.alpha = 0.75
            self.mainContainer.transform = CGAffineTransform(translationX: 0, y: 0)
            self.keyLine.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc func didTapModifyCloseOrder(sender: UIButton) {
        lightImpactGenerator()
        switch sender.tag {
        case 1:
            isModifyTrade = true
        default:
            isCloseTrade = true
        }
        self.dimissVC()
    }
    
    @objc func dimissVC() {
        UIView.animate(withDuration: 0.28) {
            self.mainScrollView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.opacityLayer.alpha = 0
        } completion: { (success) in
            self.dismiss(animated: false) {
                if self.isModifyTrade {
                    self.delegate?.didTapModifyTrade(signal: self.forexSignal)
                }
                
                else if self.isCloseTrade {
                    self.delegate?.didTapCloseTrade(signal: self.forexSignal)
                }
            }
        }
    }
}

//MARK: SCROLLVIEW DELEGATE

extension OpenOrderMenuViewController: UIScrollViewDelegate {
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

