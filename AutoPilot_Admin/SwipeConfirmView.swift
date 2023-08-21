//
//  SwipeConfirmView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit
import Lottie

protocol SwipeConfirmViewDelegate: AnyObject {
    func didConfirmDepositFunds()
}

class SwipeConfirmView: UIView {
    
    weak var delegate: SwipeConfirmViewDelegate?
    var swipeContainer = UIView()
    var swipeBG = UIImageView()
    var swipeScrollView = UIScrollView()
    var containerOne = UIView()
    var containerTwo = UIView()
    var swipeLabel = UILabel()
    var swipeLottie = LottieAnimationView()
    
    var arrowsContainer = UIView()
    var arrowsAnimation = LottieAnimationView()
    
    
    var activeDrag = false
    var didConfirm = false

    override init(frame: CGRect) {
       super.init(frame: frame)
        //self.layer.masksToBounds = true
       self.backgroundColor = .clear
       setupViews()
       
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}

// MARK: Helpers

extension SwipeConfirmView {
    func setupViews() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        swipeContainer.layer.masksToBounds = true
        swipeContainer.layer.cornerRadius = .createAspectRatio(value: 56)/2
        swipeContainer.backgroundColor = .clear
        swipeContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(swipeContainer)
        swipeContainer.fillSuperview()
                
        swipeBG.image = UIImage(named: "buttonGradient")
        swipeBG.contentMode = .scaleAspectFill
        swipeBG.backgroundColor = .clear
        swipeBG.translatesAutoresizingMaskIntoConstraints = false
        swipeContainer.addSubview(swipeBG)
        swipeBG.fillSuperview()
        
        //swipeLabel.alpha = 0
        swipeLabel.isUserInteractionEnabled = false
        swipeLabel.layer.zPosition = 2
        swipeLabel.text = "BTC Payment"
        swipeLabel.textAlignment = .right
        swipeLabel.textColor = .white
        swipeLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 17))
        swipeLabel.numberOfLines = 0
        swipeLabel.translatesAutoresizingMaskIntoConstraints = false
        swipeBG.addSubview(swipeLabel)
        swipeLabel.trailingAnchor.constraint(equalTo: swipeBG.trailingAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        swipeLabel.centerYAnchor.constraint(equalTo: swipeBG.centerYAnchor, constant: 0).isActive = true
                
        /*
        let swipeSize = (screenWidth - 44) * 2
        swipeScrollView.backgroundColor = .clear
        swipeScrollView.contentSize = CGSize(width: swipeSize, height: 56)
        swipeScrollView.showsHorizontalScrollIndicator = false
        swipeScrollView.translatesAutoresizingMaskIntoConstraints = false
        swipeScrollView.decelerationRate = .fast
        swipeContainer.addSubview(swipeScrollView)
        swipeScrollView.leadingAnchor.constraint(equalTo: swipeContainer.leadingAnchor).isActive = true
        swipeScrollView.topAnchor.constraint(equalTo: swipeContainer.topAnchor).isActive = true
        swipeScrollView.trailingAnchor.constraint(equalTo: swipeContainer.trailingAnchor).isActive = true
        swipeScrollView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        swipeScrollView.contentOffset.x = CGFloat(swipeSize / 2)
        */
        
        let swipeSize = (screenWidth - .createAspectRatio(value: 22)) * 2
        swipeScrollView.contentSize = CGSize(width: swipeSize, height: 0)
        swipeScrollView.delegate = self
        swipeScrollView.decelerationRate = .fast
        swipeScrollView.showsHorizontalScrollIndicator = false
        swipeScrollView.translatesAutoresizingMaskIntoConstraints = false
        swipeContainer.addSubview(swipeScrollView)
        swipeScrollView.leadingAnchor.constraint(equalTo: swipeContainer.leadingAnchor).isActive = true
        swipeScrollView.topAnchor.constraint(equalTo: swipeContainer.topAnchor).isActive = true
        swipeScrollView.trailingAnchor.constraint(equalTo: swipeContainer.trailingAnchor).isActive = true
        swipeScrollView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        swipeScrollView.contentOffset.x = CGFloat(screenWidth - .createAspectRatio(value: 22 * 2))
        
        //containerOne.isHidden = true
        containerOne.backgroundColor = .clear
        containerOne.translatesAutoresizingMaskIntoConstraints = false
        swipeScrollView.addSubview(containerOne)
        containerOne.leadingAnchor.constraint(equalTo: swipeScrollView.leadingAnchor).isActive = true
        containerOne.topAnchor.constraint(equalTo: swipeScrollView.topAnchor).isActive = true
        containerOne.widthAnchor.constraint(equalToConstant: CGFloat(screenWidth - .createAspectRatio(value: 44))).isActive = true
        containerOne.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true
        
        //arrowsContainer.isHidden = true
        arrowsContainer.backgroundColor = .white
        arrowsContainer.layer.cornerRadius = .createAspectRatio(value: 50)/2
        arrowsContainer.translatesAutoresizingMaskIntoConstraints = false
        swipeScrollView.addSubview(arrowsContainer)
        arrowsContainer.leadingAnchor.constraint(equalTo: containerOne.trailingAnchor, constant: .createAspectRatio(value: 3)).isActive = true
        arrowsContainer.centerYAnchor.constraint(equalTo: containerOne.centerYAnchor, constant: 0).isActive = true
        arrowsContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 50)).isActive = true
        arrowsContainer.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 99)).isActive = true
        
        let checkAnimation = LottieAnimation.named("blueArrows")
        arrowsAnimation.isUserInteractionEnabled = false
        arrowsAnimation.alpha = 1.0
        arrowsAnimation.animation = checkAnimation
        arrowsAnimation.loopMode = .loop
        arrowsAnimation.contentMode = .scaleAspectFill
        arrowsAnimation.backgroundColor = .clear
        arrowsAnimation.translatesAutoresizingMaskIntoConstraints = false
        arrowsContainer.addSubview(arrowsAnimation)
        arrowsAnimation.centerYAnchor.constraint(equalTo: arrowsContainer.centerYAnchor).isActive = true
        arrowsAnimation.centerXAnchor.constraint(equalTo: arrowsContainer.centerXAnchor).isActive = true
        arrowsAnimation.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 50)).isActive = true
        arrowsAnimation.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 50)).isActive = true
        arrowsAnimation.play()
        arrowsAnimation.transform = CGAffineTransform(rotationAngle: -.pi/2)
        
        var i = 0
        let loadingLayers = ["3/arrow-up Outlines.Group 1.Stroke 1.Color", "2/arrow-up Outlines.Group 1.Stroke 1.Color", "1/arrow-up Outlines.Group 1.Stroke 1.Color"]
        for layer in 1...loadingLayers.count {
            let keyPath = AnimationKeypath(keypath: "\(loadingLayers[layer - 1])")
            if i == 0 {
                let colorProvider = ColorValueProvider(UIColor(red: 232/255, green: 121/255, blue: 48/255, alpha: 1.0).withAlphaComponent(1.0).lottieColorValue)
                arrowsAnimation.setValueProvider(colorProvider, keypath: keyPath)
            } else if i == 1 {
                let colorProvider = ColorValueProvider(UIColor(red: 229/255, green: 91/255, blue: 137/255, alpha: 1.0).withAlphaComponent(1.0).lottieColorValue)
                arrowsAnimation.setValueProvider(colorProvider, keypath: keyPath)
            } else {
                let colorProvider = ColorValueProvider(UIColor(red: 225/255, green: 62/255, blue: 227/255, alpha: 1.0).withAlphaComponent(1.0).lottieColorValue)
                arrowsAnimation.setValueProvider(colorProvider, keypath: keyPath)
            }
            i += 1
        }
                
        containerTwo.isHidden = true
        containerTwo.isUserInteractionEnabled = false
        containerTwo.backgroundColor = .clear
        containerTwo.translatesAutoresizingMaskIntoConstraints = false
        swipeScrollView.addSubview(containerTwo)
        containerTwo.leadingAnchor.constraint(equalTo: containerOne.trailingAnchor).isActive = true
        containerTwo.topAnchor.constraint(equalTo: swipeScrollView.topAnchor).isActive = true
        containerTwo.widthAnchor.constraint(equalToConstant: CGFloat(screenWidth - .createAspectRatio(value: 52))).isActive = true
        containerTwo.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 56)).isActive = true

    }
}

//MARK: SCROLLVIEW DELEGATE

extension SwipeConfirmView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xAxis = scrollView.contentOffset.x
        if xAxis <= .createAspectRatio(value: 300) {
            //animateTimerLabel(timerOn: false)
            //showingTimer = false
        } else {
//            if !showingTimer {
//                showingTimer = true
//                animateTimerLabel(timerOn: true)
//            }
        }
        
        if activeDrag {
            if xAxis <= .createAspectRatio(value: 125) {
                if !didConfirm {
                    delegate?.didConfirmDepositFunds()
                }
                didConfirm = true
                swipeScrollView.contentOffset.x = CGFloat(.createAspectRatio(value: 125)) //151
                swipeScrollView.isUserInteractionEnabled = false
                swipeScrollView.isScrollEnabled = false
                successImpactGenerator()
            }
        }
        
        if xAxis < .createAspectRatio(value: 330) {
//            UIView.animate(withDuration: 0.35) {
//                self.swipeLabel.alpha = 0
//            }
        } else {
            UIView.animate(withDuration: 0.35) {
                self.swipeLabel.alpha = 1.0
            }
        }
                    
        //print("\(xAxis) 🧠🧠🧠")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        activeDrag = true
        
        UIView.animate(withDuration: 0.35) {
            self.swipeLabel.alpha = 0
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        activeDrag = false
        if !didConfirm {
            //scrollView.setContentOffset(CGPoint(x: .createAspectRatio(value: 330), y: 0), animated: true)
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let setPosition = CGFloat(screenWidth - .createAspectRatio(value: 22 * 2))
            scrollView.setContentOffset(CGPoint(x: setPosition, y: 0), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if !didConfirm {
            //scrollView.setContentOffset(CGPoint(x: .createAspectRatio(value: 330), y: 0), animated: true)
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let setPosition = CGFloat(screenWidth - .createAspectRatio(value: 22 * 2))
            scrollView.setContentOffset(CGPoint(x: setPosition, y: 0), animated: true)
        }
    }
    
    func resetSwipe() {
        didConfirm = false
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let setPosition = CGFloat(screenWidth - .createAspectRatio(value: 22 * 2))
        swipeScrollView.setContentOffset(CGPoint(x: setPosition, y: 0), animated: true)
        swipeScrollView.isUserInteractionEnabled = true
        swipeScrollView.isScrollEnabled = true
        //self.badWiggle()
        self.activeDrag = false
        print("did this 👅👅👅 000")
    }
}

