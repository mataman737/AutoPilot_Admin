//
//  AffiliateProgramViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 11/29/23.
//

import UIKit
import Lottie
import EFQRCode

class AffiliateProgramViewController: UIViewController {

    var navView = UIView()
    var backImageView = UIImageView()
    var backButton = UIButton()
    var titleLabel = UILabel()
    //var loadingLottie = LoadingLottieView()
    var mainScrollView = UIScrollView()
    
    var activeInactiveContainer = UIView()
    var activeButton = UIButton()
    var inactiveButton = UIButton()
    var activeAniView = UIView()
    var inActiveAniView = UIView()
    
    var monthContainer = UIView()
    var monthLabel = UILabel()
    var payoutAmountLabel = UILabel()
    var payOutDateLabel = UILabel()
    var currentSubsContainer = UIView()
    var subCountLabel = UILabel()
    var subCountTitleLabel = UILabel()
    var lifetimeContainer = UIButton()
    var lifeTimeCountLabel = UILabel()
    var lifeTimeTitleLabel = UILabel()
    var perUserContainer = UIView()
    var perUserLottie = LottieAnimationView()
    var perUserAmountLabel = UILabel()
    var perUserDetailLabel = UILabel()
    var myLinkContainer = UIView()
    var qrImageView = UIImageView()
    var payPalContainer = UIButton()
    var payPalTitleLabel = UILabel()
    var payPalEmailLabel = UILabel()
    var moreImageView = UIImageView()
    var termsLabel = UILabel()
    var blackGradient = UIImageView()
    var shareLinkButton = UIButton()
    
    var circularSliderContainer = UIView()
    var circularSlider = CircularSlider()
    var myInvestmentAmountLabel = UILabel()
    var myInvestmentDetailLabel = UILabel()
    var subscriptionAmount: Double = 120.00
    var commissionPercent = 0.25
    var dollarAmount = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.masksToBounds = true
        self.view.backgroundColor = .darkModeBackground
        setupNav()
        setupViews()
        //hideLoaderAndShow()
        
        animateSlider()
        //perform(#selector(animateSlider), with: self, afterDelay: 0.25)
    }

}

//MARK: ACTIONS

extension AffiliateProgramViewController {
    @objc func goToAffiliateProgram() {
        lightImpactGenerator()
        let affiliateVC = AffiliatesViewController()
        self.present(affiliateVC, animated: true)
        //self.navigationController?.pushViewController(affiliateVC, animated: true)
    }
    
    @objc func animateSlider() {
        circularSlider.setValue(Float(commissionPercent) * 200, animated: false) //200 is 100%
        //let dollarAmountToAnimateTo = userBalance * (safeGuardPercent * 0.01)
        //myInvestmentDetailLabel.countFrom(0, to: dollarAmountToAnimateTo, withDuration: 0.35)
        //myInvestmentAmountLabel.countFrom(0, to: CGFloat(safeGuardPercent), withDuration: 0.35)
        //numbersTiedToSlider = true
    }
    
    @objc func popBack() {
        lightImpactGenerator()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func hideLoaderAndShow() {
        UIView.animate(withDuration: 0.35, animations: {
            //self.loadingLottie.alpha = 0
        }) { (success) in
            //
        }
    }
    
    @objc func didTapActiveInactive(sender: UIButton) {
        lightImpactGenerator()
        switch sender.tag {
        case 1:
            activeButton.backgroundColor = UIColor(red: 114/255, green: 71/255, blue: 147/255, alpha: 1.0)
            activeButton.setTitleColor(.white, for: .normal)
            inactiveButton.backgroundColor = .white.withAlphaComponent(0.1)
            inactiveButton.setTitleColor(.white.withAlphaComponent(0.3), for: .normal)
        default:
            inactiveButton.backgroundColor = UIColor(red: 114/255, green: 71/255, blue: 147/255, alpha: 1.0)
            inactiveButton.setTitleColor(.white, for: .normal)
            activeButton.backgroundColor = .white.withAlphaComponent(0.1)
            activeButton.setTitleColor(.white.withAlphaComponent(0.3), for: .normal)
        }
    }
}

//MARK: CIRCULAR SLIDER DELEGATE

extension AffiliateProgramViewController: CircularSliderDelegate {
    func circularSlider(_ circularSlider: CircularSlider, valueForValue value: Float) -> Float {
        //print("\(value.rounded()) 🚀🚀🚀")
        let roundedValue = value.rounded()
                        
        if roundedValue == 0 {
            
            myInvestmentAmountLabel.text = "0%"
            myInvestmentDetailLabel.text = "$0"
            dollarAmount = "0"
            
        } else if roundedValue <= (0.005 * 200) {
            
            myInvestmentAmountLabel.text = "0.5%"
            dollarAmount = "\(0.005 * subscriptionAmount)"
            
        } else if roundedValue <= (0.01 * 200) {
            
            myInvestmentAmountLabel.text = "1.0%"
            dollarAmount = "\(0.01 * subscriptionAmount)"
            
        } else if roundedValue <= (0.015 * 200) {
            
            myInvestmentAmountLabel.text = "1.5%"
            dollarAmount = "\(0.015 * subscriptionAmount)"
            
        } else if roundedValue <= (0.02 * 200) {
            
            myInvestmentAmountLabel.text = "2.0%"
            myInvestmentDetailLabel.text = "$\((0.02 * subscriptionAmount).rounded(toPlaces: 2).withCommas())"
            dollarAmount = "\(0.02 * subscriptionAmount)"
            
        } else if roundedValue <= (0.025 * 200) {
            
            myInvestmentAmountLabel.text = "2.5%"
            dollarAmount = "\(0.025 * subscriptionAmount)"
            
        } else if roundedValue <= (0.03 * 200) {
            
            myInvestmentAmountLabel.text = "3.0%"
            dollarAmount = "\(0.03 * subscriptionAmount)"
            
        } else if roundedValue <= (0.035 * 200) {
            
            myInvestmentAmountLabel.text = "3.5%"
            dollarAmount = "\(0.035 * subscriptionAmount)"
            
        } else if roundedValue <= (0.04 * 200) {
            
            myInvestmentAmountLabel.text = "4.0%"
            dollarAmount = "\(0.04 * subscriptionAmount)"
            
        } else if roundedValue <= (0.045 * 200) {
            
            myInvestmentAmountLabel.text = "4.5%"
            dollarAmount = "\(0.045 * subscriptionAmount)"
            
        } else if roundedValue <= (0.05 * 200) {
            
            myInvestmentAmountLabel.text = "5.0%"
            dollarAmount = "\(0.05 * subscriptionAmount)"
            
        } else if roundedValue <= (0.055 * 200) {
            
            myInvestmentAmountLabel.text = "5.5%"
            dollarAmount = "\(0.055 * subscriptionAmount)"
            
        } else if roundedValue <= (0.06 * 200) {
            
            myInvestmentAmountLabel.text = "6.0%"
            dollarAmount = "\(0.06 * subscriptionAmount)"
            
        } else if roundedValue <= (0.065 * 200) {
            
            myInvestmentAmountLabel.text = "6.5%"
            dollarAmount = "\(0.065 * subscriptionAmount)"
            
        } else if roundedValue <= (0.07 * 200) {
            
            myInvestmentAmountLabel.text = "7.0%"
            dollarAmount = "\(0.07 * subscriptionAmount)"
            
        } else if roundedValue <= (0.075 * 200) {
            
            myInvestmentAmountLabel.text = "7.5%"
            dollarAmount = "\(0.075 * subscriptionAmount)"
            
        } else if roundedValue <= (0.080 * 200) {
            
            myInvestmentAmountLabel.text = "8.0%"
            dollarAmount = "\(0.08 * subscriptionAmount)"
            
        } else if roundedValue <= (0.085 * 200) {
            
            myInvestmentAmountLabel.text = "8.5%"
            dollarAmount = "\(0.085 * subscriptionAmount)"
            
        } else if roundedValue <= (0.090 * 200) {
            
            myInvestmentAmountLabel.text = "9.0%"
            dollarAmount = "\(0.09 * subscriptionAmount)"
            
        } else if roundedValue <= (0.095 * 200) {
            
            myInvestmentAmountLabel.text = "9.5%"
            dollarAmount = "\(0.095 * subscriptionAmount)"
            
        } else if roundedValue <= (0.1 * 200) {
            
            myInvestmentAmountLabel.text = "10%"
            dollarAmount = "\(0.1 * subscriptionAmount)"
        } else if roundedValue <= (0.15 * 200) {
            
            myInvestmentAmountLabel.text = "15%"
            dollarAmount = "\(0.15 * subscriptionAmount)"
            
        } else if roundedValue <= (0.2 * 200) {
            
            myInvestmentAmountLabel.text = "20%"
            dollarAmount = "\(0.2 * subscriptionAmount)"
            
        } else if roundedValue <= (0.25 * 200) {
            
            myInvestmentAmountLabel.text = "25%"
            myInvestmentDetailLabel.text = "$\((0.25 * subscriptionAmount).rounded(toPlaces: 2).withCommas())"
            dollarAmount = "\(0.25 * subscriptionAmount)"
            
        } else if roundedValue <= (0.3 * 200) {
            
            myInvestmentAmountLabel.text = "30%"
            dollarAmount = "\(0.3 * subscriptionAmount)"
            
        } else if roundedValue <= (0.35 * 200) {
            
            myInvestmentAmountLabel.text = "35%"
            dollarAmount = "\(0.35 * subscriptionAmount)"
            
        } else if roundedValue <= (0.4 * 200) {
            
            myInvestmentAmountLabel.text = "40%"
            dollarAmount = "\(0.4 * subscriptionAmount)"
            
        } else if roundedValue <= (0.45 * 200) {
            
            myInvestmentAmountLabel.text = "45%"
            dollarAmount = "\(0.45 * subscriptionAmount)"
            
        } else if roundedValue <= (0.5 * 200) {
            
            myInvestmentAmountLabel.text = "50%"
            dollarAmount = "\(0.5 * subscriptionAmount)"
            
        } else if roundedValue <= (0.5 * 200) {
            
            myInvestmentAmountLabel.text = "55%"
            dollarAmount = "\(0.55 * subscriptionAmount)"
            
        } else if roundedValue <= (0.6 * 200) {
            
            myInvestmentAmountLabel.text = "60%"
            dollarAmount = "\(0.6 * subscriptionAmount)"
            
        } else if roundedValue <= (0.65 * 200) {
            
            myInvestmentAmountLabel.text = "65%"
            dollarAmount = "\(0.65 * subscriptionAmount)"
            
        } else if roundedValue <= (0.7 * 200) {
            
            myInvestmentAmountLabel.text = "70%"
            dollarAmount = "\(0.7 * subscriptionAmount)"
            
        } else if roundedValue <= (0.75 * 200) {
            
            myInvestmentAmountLabel.text = "75%"
            dollarAmount = "\(0.75 * subscriptionAmount)"
            
        } else if roundedValue <= (0.8 * 200) {
            
            myInvestmentAmountLabel.text = "80%"
            dollarAmount = "\(0.8 * subscriptionAmount)"
            
        } else if roundedValue <= (0.85 * 200) {
            
            myInvestmentAmountLabel.text = "85%"
            dollarAmount = "\(0.85 * subscriptionAmount)"
            
        } else if roundedValue <= (0.9 * 200) {
            
            myInvestmentAmountLabel.text = "90%"
            dollarAmount = "\(0.9 * subscriptionAmount)"
            
        } else if roundedValue <= (0.95 * 200) {
            
            myInvestmentAmountLabel.text = "95%"
            dollarAmount = "\(0.95 * subscriptionAmount)"
            
        } else if roundedValue <= (1.0 * 200) {
            myInvestmentAmountLabel.text = "100%"
            dollarAmount = "\(1.0 * subscriptionAmount)"
            
        } else {
            myInvestmentAmountLabel.text = "$\(roundedValue)"
        }
        
        
        
        if let dolAmt = Double(dollarAmount) {
            myInvestmentDetailLabel.text = "$\((dolAmt).rounded(toPlaces: 2).withCommas())"
        }
        
        
        
        
        
        if Int(roundedValue) % 10 == 0 {
            //softImpactGenerator()
            lightImpactGenerator()
        }
        
        return value
    }
}
