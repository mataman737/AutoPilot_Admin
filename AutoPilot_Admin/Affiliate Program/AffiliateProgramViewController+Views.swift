//
//  AffiliateProgramViewController+Views.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 11/29/23.
//

import Foundation
import UIKit
import Lottie

extension AffiliateProgramViewController {
    func setupNav() {
        navView.backgroundColor = .darkModeBackground
        navView.layer.zPosition = 2
        navView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navView)
        navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 90)).isActive = true
        
        backImageView.image = UIImage(named: "arrowLeft")
        backImageView.setImageColor(color: .white)
        backImageView.contentMode = .scaleAspectFill
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backImageView)
        backImageView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: -.createAspectRatio(value: 4)).isActive = true
        backImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 32)).isActive = true
        backImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 32)).isActive = true
        
        backButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        backButton.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        
        titleLabel.text = "Affiliate Program"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .darkModeTextColor
        titleLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 18))
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: navView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor).isActive = true
        
//        loadingLottie.loading.play()
//        loadingLottie.isUserInteractionEnabled = false
//        loadingLottie.alpha = 1.0
//        loadingLottie.contentMode = .scaleAspectFill
//        loadingLottie.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(loadingLottie)
//        loadingLottie.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        //loadingLottie.topAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
//        loadingLottie.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: -.createAspectRatio(value: 90)).isActive = true
//        loadingLottie.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        loadingLottie.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setupViews() {
        mainScrollView.backgroundColor = .darkModeBackground
        mainScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.4)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainScrollView)
        mainScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mainScrollView.topAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        
        activeInactiveContainer.backgroundColor = .white.withAlphaComponent(0.1)
        activeInactiveContainer.layer.cornerRadius = 9
        activeInactiveContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(activeInactiveContainer)
        activeInactiveContainer.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: .createAspectRatio(value: 24)).isActive = true
        activeInactiveContainer.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: .createAspectRatio(value: 30)).isActive = true
        activeInactiveContainer.widthAnchor.constraint(equalToConstant: view.frame.width - .createAspectRatio(value: 48)).isActive = true
        activeInactiveContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 55)).isActive = true
        
        activeButton.tag = 1
        activeButton.addTarget(self, action: #selector(didTapActiveInactive(sender:)), for: .touchUpInside)
        activeButton.backgroundColor = UIColor(red: 114/255, green: 71/255, blue: 147/255, alpha: 1.0)
        activeButton.layer.cornerRadius = 9
        activeButton.setTitle("Active", for: .normal)
        activeButton.titleLabel?.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 20))
        activeButton.setTitleColor(.white, for: .normal)
        activeButton.translatesAutoresizingMaskIntoConstraints = false
        activeInactiveContainer.addSubview(activeButton)
        activeButton.leadingAnchor.constraint(equalTo: activeInactiveContainer.leadingAnchor, constant: .createAspectRatio(value: 6)).isActive = true
        activeButton.trailingAnchor.constraint(equalTo: activeInactiveContainer.centerXAnchor, constant: -.createAspectRatio(value: 2.5)).isActive = true
        activeButton.topAnchor.constraint(equalTo: activeInactiveContainer.topAnchor, constant: .createAspectRatio(value: 5)).isActive = true
        activeButton.bottomAnchor.constraint(equalTo: activeInactiveContainer.bottomAnchor, constant: -.createAspectRatio(value: 5)).isActive = true
        
        inactiveButton.tag = 2
        inactiveButton.addTarget(self, action: #selector(didTapActiveInactive(sender:)), for: .touchUpInside)
        inactiveButton.backgroundColor = .white.withAlphaComponent(0.1)
        inactiveButton.layer.cornerRadius = 9
        inactiveButton.setTitle("Inactive", for: .normal)
        inactiveButton.titleLabel?.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 20))
        inactiveButton.setTitleColor(.white.withAlphaComponent(0.3), for: .normal)
        inactiveButton.translatesAutoresizingMaskIntoConstraints = false
        activeInactiveContainer.addSubview(inactiveButton)
        inactiveButton.trailingAnchor.constraint(equalTo: activeInactiveContainer.trailingAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        inactiveButton.leadingAnchor.constraint(equalTo: activeInactiveContainer.centerXAnchor, constant: .createAspectRatio(value: 2.5)).isActive = true
        inactiveButton.topAnchor.constraint(equalTo: activeInactiveContainer.topAnchor, constant: .createAspectRatio(value: 5)).isActive = true
        inactiveButton.bottomAnchor.constraint(equalTo: activeInactiveContainer.bottomAnchor, constant: -.createAspectRatio(value: 5)).isActive = true
        
        perUserContainer.layer.masksToBounds = true
        perUserContainer.layer.cornerRadius = 9
        perUserContainer.backgroundColor = .white.withAlphaComponent(0.1)
        perUserContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(perUserContainer)
        perUserContainer.leadingAnchor.constraint(equalTo: activeInactiveContainer.leadingAnchor).isActive = true
        perUserContainer.trailingAnchor.constraint(equalTo: activeInactiveContainer.trailingAnchor).isActive = true
        perUserContainer.topAnchor.constraint(equalTo: activeInactiveContainer.bottomAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        perUserContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 392)).isActive = true
                
        perUserAmountLabel.setupLabel(text: "Affiliate Commission", txtColor: .white, font: .sofiaProSemiBold(ofSize: .createAspectRatio(value: 18)), txtAlignment: .center)
        perUserContainer.addSubview(perUserAmountLabel)
        perUserAmountLabel.topAnchor.constraint(equalTo: perUserContainer.topAnchor, constant: .createAspectRatio(value: 16)).isActive = true
        perUserAmountLabel.centerXAnchor.constraint(equalTo: perUserContainer.centerXAnchor).isActive = true
        
        circularSliderContainer.backgroundColor = .clear
        circularSliderContainer.translatesAutoresizingMaskIntoConstraints = false
        perUserContainer.addSubview(circularSliderContainer)
        circularSliderContainer.topAnchor.constraint(equalTo: perUserAmountLabel.bottomAnchor, constant: .createAspectRatio(value: 30)).isActive = true
        circularSliderContainer.centerXAnchor.constraint(equalTo: perUserContainer.centerXAnchor).isActive = true
        circularSliderContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 220)).isActive = true
        circularSliderContainer.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 220)).isActive = true
        
        //
        
        circularSlider.pgHighlightedColor = UIColor(red: 114/255, green: 71/255, blue: 147/255, alpha: 1.0)
        circularSlider.bgColor = .white.withAlphaComponent(0.1)
        circularSlider.delegate = self
        circularSlider.knobRadius = 22
        circularSlider.lineWidth = 10
        circularSlider.backgroundColor = .clear
        circularSlider.translatesAutoresizingMaskIntoConstraints = false
        circularSliderContainer.addSubview(circularSlider)
        circularSlider.fillSuperview()
        
        myInvestmentAmountLabel.layer.zPosition = 100
        myInvestmentAmountLabel.text = "$5"
        myInvestmentAmountLabel.textAlignment = .center
        myInvestmentAmountLabel.textColor = .white
        myInvestmentAmountLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 50))
        myInvestmentAmountLabel.numberOfLines = 0
        myInvestmentAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        circularSliderContainer.addSubview(myInvestmentAmountLabel)
        myInvestmentAmountLabel.centerYAnchor.constraint(equalTo: circularSliderContainer.centerYAnchor).isActive = true
        myInvestmentAmountLabel.centerXAnchor.constraint(equalTo: circularSliderContainer.centerXAnchor).isActive = true
        
        myInvestmentDetailLabel.layer.zPosition = 100
        myInvestmentDetailLabel.text = "$0"
        myInvestmentDetailLabel.textAlignment = .center
        myInvestmentDetailLabel.textColor = .white.withAlphaComponent(0.5)
        myInvestmentDetailLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 27))
        myInvestmentDetailLabel.numberOfLines = 0
        myInvestmentDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        circularSliderContainer.addSubview(myInvestmentDetailLabel)
        myInvestmentDetailLabel.topAnchor.constraint(equalTo: myInvestmentAmountLabel.bottomAnchor, constant: .createAspectRatio(value: 4)).isActive = true
        myInvestmentDetailLabel.centerXAnchor.constraint(equalTo: circularSliderContainer.centerXAnchor).isActive = true
        
        perUserDetailLabel.setupLabel(text: "", txtColor: .white.withAlphaComponent(0.5), font: .sofiaProRegular(ofSize: .createAspectRatio(value: 13)), txtAlignment: .center)
        let perUserDetailLabelText = "Use the slider to determine what percentage of the subscription you would like to give your affiliates"
        perUserDetailLabel.setupLineHeight(myText: perUserDetailLabelText, myLineSpacing: .createAspectRatio(value: 8))
        perUserDetailLabel.textAlignment = .center
        perUserContainer.addSubview(perUserDetailLabel)
        perUserDetailLabel.bottomAnchor.constraint(equalTo: perUserContainer.bottomAnchor, constant: -.createAspectRatio(value: 21)).isActive = true
        perUserDetailLabel.trailingAnchor.constraint(equalTo: perUserContainer.trailingAnchor, constant: -.createAspectRatio(value: 31)).isActive = true
        perUserDetailLabel.leadingAnchor.constraint(equalTo: perUserContainer.leadingAnchor, constant: .createAspectRatio(value: 31)).isActive = true
        
        monthContainer.backgroundColor = .white.withAlphaComponent(0.1)
        monthContainer.layer.cornerRadius = 9
        monthContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(monthContainer)
        monthContainer.leadingAnchor.constraint(equalTo: activeInactiveContainer.leadingAnchor).isActive = true
        monthContainer.trailingAnchor.constraint(equalTo: activeInactiveContainer.trailingAnchor).isActive = true
        monthContainer.topAnchor.constraint(equalTo: perUserContainer.bottomAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        monthContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 104)).isActive = true
        
        payoutAmountLabel.setupLabel(text: "$2,480.50", txtColor: .white, font: .sofiaProSemiBold(ofSize: .createAspectRatio(value: 24)), txtAlignment: .center)
        monthContainer.addSubview(payoutAmountLabel)
        payoutAmountLabel.centerYAnchor.constraint(equalTo: monthContainer.centerYAnchor).isActive = true
        payoutAmountLabel.centerXAnchor.constraint(equalTo: monthContainer.centerXAnchor).isActive = true
        
        monthLabel.setupLabel(text: "September", txtColor: .white.withAlphaComponent(0.2), font: .sofiaProSemiBold(ofSize: .createAspectRatio(value: 12)), txtAlignment: .center)
        monthContainer.addSubview(monthLabel)
        monthLabel.bottomAnchor.constraint(equalTo: payoutAmountLabel.topAnchor, constant: -.createAspectRatio(value: 9)).isActive = true
        monthLabel.centerXAnchor.constraint(equalTo: monthContainer.centerXAnchor).isActive = true
        
        payOutDateLabel.setupLabel(text: "Total payout to affiliates", txtColor: .white.withAlphaComponent(0.5), font: .sofiaProRegular(ofSize: .createAspectRatio(value: 12)), txtAlignment: .center)
        monthContainer.addSubview(payOutDateLabel)
        payOutDateLabel.topAnchor.constraint(equalTo: payoutAmountLabel.bottomAnchor, constant: .createAspectRatio(value: 9)).isActive = true
        payOutDateLabel.centerXAnchor.constraint(equalTo: monthContainer.centerXAnchor).isActive = true
        
        currentSubsContainer.backgroundColor = .white.withAlphaComponent(0.1)
        currentSubsContainer.layer.cornerRadius = 9
        currentSubsContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(currentSubsContainer)
        currentSubsContainer.leadingAnchor.constraint(equalTo: monthContainer.leadingAnchor, constant: 0).isActive = true
        currentSubsContainer.trailingAnchor.constraint(equalTo: monthContainer.centerXAnchor, constant: -.createAspectRatio(value: 8)).isActive = true
        currentSubsContainer.topAnchor.constraint(equalTo: monthContainer.bottomAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        currentSubsContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 104)).isActive = true
                
        subCountLabel.setupLabel(text: "29", txtColor: .white, font: .sofiaProSemiBold(ofSize: .createAspectRatio(value: 24)), txtAlignment: .center)
        currentSubsContainer.addSubview(subCountLabel)
        subCountLabel.centerYAnchor.constraint(equalTo: currentSubsContainer.centerYAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        subCountLabel.centerXAnchor.constraint(equalTo: currentSubsContainer.centerXAnchor).isActive = true
        
        subCountTitleLabel.setupLabel(text: "Affiliate subscribers", txtColor: .white.withAlphaComponent(0.5), font: .sofiaProRegular(ofSize: .createAspectRatio(value: 12)), txtAlignment: .center)
        currentSubsContainer.addSubview(subCountTitleLabel)
        subCountTitleLabel.topAnchor.constraint(equalTo: subCountLabel.bottomAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        subCountTitleLabel.centerXAnchor.constraint(equalTo: currentSubsContainer.centerXAnchor).isActive = true
        
        lifetimeContainer.addTarget(self, action: #selector(goToAffiliateProgram), for: .touchUpInside)
        lifetimeContainer.backgroundColor = .white.withAlphaComponent(0.1)
        lifetimeContainer.layer.cornerRadius = 9
        lifetimeContainer.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(lifetimeContainer)
        lifetimeContainer.trailingAnchor.constraint(equalTo: monthContainer.trailingAnchor, constant: 0).isActive = true
        lifetimeContainer.leadingAnchor.constraint(equalTo: monthContainer.centerXAnchor, constant: .createAspectRatio(value: 8)).isActive = true
        lifetimeContainer.topAnchor.constraint(equalTo: monthContainer.bottomAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        lifetimeContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 104)).isActive = true
        
        lifeTimeCountLabel.isUserInteractionEnabled = false
        lifeTimeCountLabel.setupLabel(text: "4", txtColor: .white, font: .sofiaProSemiBold(ofSize: .createAspectRatio(value: 24)), txtAlignment: .center)
        lifetimeContainer.addSubview(lifeTimeCountLabel)
        lifeTimeCountLabel.centerYAnchor.constraint(equalTo: lifetimeContainer.centerYAnchor, constant: -.createAspectRatio(value: 6)).isActive = true
        lifeTimeCountLabel.centerXAnchor.constraint(equalTo: lifetimeContainer.centerXAnchor).isActive = true
        
        lifeTimeTitleLabel.isUserInteractionEnabled = false
        lifeTimeTitleLabel.setupLabel(text: "# of Affiliates", txtColor: .white.withAlphaComponent(0.5), font: .sofiaProRegular(ofSize: .createAspectRatio(value: 12)), txtAlignment: .center)
        lifetimeContainer.addSubview(lifeTimeTitleLabel)
        lifeTimeTitleLabel.topAnchor.constraint(equalTo: lifeTimeCountLabel.bottomAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        lifeTimeTitleLabel.centerXAnchor.constraint(equalTo: lifetimeContainer.centerXAnchor).isActive = true
        
        let termsLabelText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed."
        termsLabel.setupLineHeight(myText: termsLabelText, myLineSpacing: .createAspectRatio(value: 8))
        termsLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 10))
        termsLabel.textAlignment = .left
        termsLabel.textColor = .white.withAlphaComponent(0.4)
        termsLabel.numberOfLines = 0
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(termsLabel)
        termsLabel.leadingAnchor.constraint(equalTo: monthContainer.leadingAnchor).isActive = true
        termsLabel.trailingAnchor.constraint(equalTo: monthContainer.trailingAnchor).isActive = true
        termsLabel.topAnchor.constraint(equalTo: currentSubsContainer.bottomAnchor, constant: .createAspectRatio(value: 15)).isActive = true
        
        blackGradient.isUserInteractionEnabled = false
        blackGradient.layer.zPosition = 2
        blackGradient.image = UIImage(named: "blackGradient")
        blackGradient.contentMode = .scaleAspectFill
        blackGradient.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(blackGradient)
        blackGradient.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        blackGradient.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        blackGradient.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        blackGradient.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 225)).isActive = true
    }
    
}
