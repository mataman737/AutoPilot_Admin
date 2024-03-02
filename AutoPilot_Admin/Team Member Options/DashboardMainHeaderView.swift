//
//  DashboardMainHeaderView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/14/23.
//

import UIKit

protocol DashboardMainHeaderViewDelegate: AnyObject {
    func showHideCube(show: Bool)
}

class DashboardMainHeaderView: UIView {

    weak var delegate: DashboardMainHeaderViewDelegate?
    var messagesEmptyState = EmptyStateView()
    var switchViewButton = UIButton()
    var switchTop: CGFloat = 10
    var listImageView = UIImageView()
    var lineImageView = UIImageView()
    var investingLabel = UILabel()
    var investingPercentLabel = UILabel()
    var investmentAmountLabel = UILabel()
    var investmentAmountPercentChangeLabel = UILabel()
    var coinPerformanceContainer = ChartsLineGraphView()
    var arrowUpImageView = UIImageView()
    
    var viewBubblesButton = UIButton()
    var bubblesImageView = UIImageView()
    //
    
    var equityLabel = UILabel()
    var equityAmountLabel = UILabel()
    var equityPercent = UILabel()
    var equityPercentAmountLabel = UILabel()
    var growthLabel = UILabel()
    var growthAmountLabel = UILabel()
    var profitLoss = UILabel()
    var profitLossLabel = UILabel()
    
    var lineGraphMode = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        modifyConstraints()
        setupViews()
        setupGraph()
        setupEmtpyState()
        
        messagesEmptyState.showViews()
                        
//        if User.current.email == "jaynetabel@gmail.com" || User.current.email == "abnerb@abnerb.com" || User.current.email == "demoaccount10@bfxtandard.com" {
            coinPerformanceContainer.isHidden = false
            messagesEmptyState.isHidden = true
            
            investmentAmountLabel.text = "$-"
            investmentAmountPercentChangeLabel.text = "$0 (0%)"
            equityAmountLabel.text = "$0.00"
            equityPercentAmountLabel.text = "0%"
            growthAmountLabel.text = "0%"
            profitLossLabel.text = "$0.00"
            //arrowUpImageView.image = UIImage(named: "greenCircleArrow")
//        } else {
//            coinPerformanceContainer.isHidden = true
//            messagesEmptyState.isHidden = false
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: VIEWS

extension DashboardMainHeaderView {
    func modifyConstraints() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        switch screenHeight {
        case .iphone5() :
            switchTop = 10
            print("111 😇")
        case .iphone78() :
            switchTop = 10
            print("222 😇")
        case .iphone78Plus() :
            switchTop = 10
            print("333 😇")
        case .iphone11() :
            print("444 😇")
        case .iphone12AndPro() :
            print("555 😇")
        case .iphone12ProMax() :
            print("666 😇")
        default:
            print("777 😇")
        }
    }
    
    func setupViews() {
        
        switchViewButton.addTarget(self, action: #selector(didTapGrid), for: .touchUpInside)
        switchViewButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        switchViewButton.layer.cornerRadius = 5
        switchViewButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(switchViewButton)
        switchViewButton.topAnchor.constraint(equalTo: self.topAnchor, constant: switchTop).isActive = true
        switchViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22).isActive = true
        switchViewButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        switchViewButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        listImageView.image = UIImage(named: "listIcon") //notiBell
        listImageView.isUserInteractionEnabled = false
        listImageView.contentMode = .scaleAspectFill
        listImageView.translatesAutoresizingMaskIntoConstraints = false
        switchViewButton.addSubview(listImageView)
        listImageView.centerYAnchor.constraint(equalTo: switchViewButton.centerYAnchor).isActive = true
        listImageView.centerXAnchor.constraint(equalTo: switchViewButton.centerXAnchor).isActive = true
        listImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        listImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        lineImageView.alpha = 0
        lineImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        lineImageView.image = UIImage(named: "lineIcon")
        lineImageView.isUserInteractionEnabled = false
        lineImageView.contentMode = .scaleAspectFill
        lineImageView.translatesAutoresizingMaskIntoConstraints = false
        switchViewButton.addSubview(lineImageView)
        lineImageView.centerYAnchor.constraint(equalTo: switchViewButton.centerYAnchor).isActive = true
        lineImageView.centerXAnchor.constraint(equalTo: switchViewButton.centerXAnchor).isActive = true
        lineImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        lineImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        //viewBubblesButton.addTarget(self, action: #selector(didTapGrid), for: .touchUpInside)
        viewBubblesButton.isHidden = false
        viewBubblesButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        viewBubblesButton.layer.cornerRadius = 5
        viewBubblesButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewBubblesButton)
        viewBubblesButton.topAnchor.constraint(equalTo: switchViewButton.topAnchor, constant: 0).isActive = true
        viewBubblesButton.trailingAnchor.constraint(equalTo: switchViewButton.leadingAnchor, constant: -15).isActive = true
        viewBubblesButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        viewBubblesButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        bubblesImageView.isHidden = false
        bubblesImageView.image = UIImage(named: "notiBell")
        bubblesImageView.setImageColor(color: .white)
        bubblesImageView.isUserInteractionEnabled = false
        bubblesImageView.contentMode = .scaleAspectFill
        bubblesImageView.translatesAutoresizingMaskIntoConstraints = false
        switchViewButton.addSubview(bubblesImageView)
        bubblesImageView.centerYAnchor.constraint(equalTo: viewBubblesButton.centerYAnchor).isActive = true
        bubblesImageView.centerXAnchor.constraint(equalTo: viewBubblesButton.centerXAnchor).isActive = true
        bubblesImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        bubblesImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        investingLabel.isHidden = true
        investingLabel.text = "INVESTING"//.localiz()
        investingLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        investingLabel.textAlignment = .left
        investingLabel.font = .poppinsMedium(ofSize: 13)//.sofiaProMedium(ofSize: 11)
        investingLabel.numberOfLines = 0
        investingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(investingLabel)
        investingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22).isActive = true
        investingLabel.topAnchor.constraint(equalTo: switchViewButton.topAnchor, constant: 0).isActive = true
                
        investmentAmountLabel.text = "$0"
        investmentAmountLabel.textColor = UIColor.white.withAlphaComponent(1.0)
        investmentAmountLabel.textAlignment = .left
        investmentAmountLabel.font = .poppinsBold(ofSize: 32)
        investmentAmountLabel.numberOfLines = 0
        investmentAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(investmentAmountLabel)
        //investmentAmountLabel.leadingAnchor.constraint(equalTo: investingLabel.leadingAnchor, constant: 0).isActive = true
        //investmentAmountLabel.topAnchor.constraint(equalTo: investingLabel.bottomAnchor, constant: 7).isActive = true
        investmentAmountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22).isActive = true
        investmentAmountLabel.topAnchor.constraint(equalTo: switchViewButton.topAnchor, constant: 0).isActive = true
        
        arrowUpImageView.image = UIImage(named: "neutralBubble") //greenCircleArrow
        arrowUpImageView.contentMode = .scaleAspectFill
        arrowUpImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(arrowUpImageView)
        arrowUpImageView.leadingAnchor.constraint(equalTo: investmentAmountLabel.leadingAnchor, constant: 0).isActive = true
        arrowUpImageView.topAnchor.constraint(equalTo: investmentAmountLabel.bottomAnchor, constant: 7).isActive = true
        arrowUpImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        arrowUpImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        investmentAmountPercentChangeLabel.alpha = 1.0
        investmentAmountPercentChangeLabel.text = "$0 (0%)" //"+ $0 (0%)"
        investmentAmountPercentChangeLabel.textColor = UIColor(red: 18/255, green: 183/255, blue: 106/255, alpha: 1.0)
        investmentAmountPercentChangeLabel.textAlignment = .left
        investmentAmountPercentChangeLabel.font = .poppinsRegular(ofSize: 14)
        investmentAmountPercentChangeLabel.numberOfLines = 0
        investmentAmountPercentChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(investmentAmountPercentChangeLabel)
        investmentAmountPercentChangeLabel.leadingAnchor.constraint(equalTo: arrowUpImageView.trailingAnchor, constant: 8).isActive = true
        investmentAmountPercentChangeLabel.centerYAnchor.constraint(equalTo: arrowUpImageView.centerYAnchor, constant: 0).isActive = true
        
        //
        
        setLabelAlphaPosition(label: equityLabel)
        equityLabel.text = "EQUITY"//.localiz()
        createDetailLabel(label: equityLabel)
        equityLabel.topAnchor.constraint(equalTo: investmentAmountLabel.bottomAnchor, constant: 15).isActive = true
        
        setLabelAlphaPosition(label: equityAmountLabel)
        equityAmountLabel.text = "$0"//"$14,659.93"
        createMainLabel(label: equityAmountLabel)
        equityAmountLabel.topAnchor.constraint(equalTo: equityLabel.bottomAnchor, constant: 7).isActive = true
        
        setLabelAlphaPosition(label: equityPercent)
        equityPercent.text = "MARGIN"//.localiz()
        createDetailLabel(label: equityPercent)
        equityPercent.topAnchor.constraint(equalTo: equityAmountLabel.bottomAnchor, constant: 15).isActive = true
        
        setLabelAlphaPosition(label: equityPercentAmountLabel)
        equityPercentAmountLabel.text = "0%"//"98.65%"
        createMainLabel(label: equityPercentAmountLabel)
        equityPercentAmountLabel.topAnchor.constraint(equalTo: equityPercent.bottomAnchor, constant: 7).isActive = true
        
        setLabelAlphaPosition(label: growthLabel)
        growthLabel.text = "FREE MARGIN"//.localiz()
        createDetailLabel(label: growthLabel)
        growthLabel.topAnchor.constraint(equalTo: equityPercentAmountLabel.bottomAnchor, constant: 15).isActive = true
        
        setLabelAlphaPosition(label: growthAmountLabel)
        growthAmountLabel.text = "0%"//"7.09%"
        createMainLabel(label: growthAmountLabel)
        growthAmountLabel.textColor = UIColor(red: 14/255, green: 254/255, blue: 81/255, alpha: 0.5)
        growthAmountLabel.topAnchor.constraint(equalTo: growthLabel.bottomAnchor, constant: 5).isActive = true
        
        setLabelAlphaPosition(label: profitLoss)
        profitLoss.text = "PROFIT/LOSS"//.localiz()
        createDetailLabel(label: profitLoss)
        profitLoss.topAnchor.constraint(equalTo: growthAmountLabel.bottomAnchor, constant: 15).isActive = true
        
        setLabelAlphaPosition(label: profitLossLabel)
        profitLossLabel.text = "$0"//"$983.82"
        createMainLabel(label: profitLossLabel)
        profitLossLabel.topAnchor.constraint(equalTo: profitLoss.bottomAnchor, constant: 7).isActive = true
    }
    
    func createMainLabel(label: UILabel) {
        label.textColor = UIColor.white.withAlphaComponent(1.0)
        label.textAlignment = .left
        label.font = .poppinsSemiBold(ofSize: 26)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22).isActive = true
    }
    
    func createDetailLabel(label: UILabel) {
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.textAlignment = .left
        label.font = .poppinsMedium(ofSize: 11)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22).isActive = true
    }
    
    func setLabelAlphaPosition(label: UILabel) {
        label.alpha = 0
        label.transform = CGAffineTransform(translationX: 0, y: 50)
    }
    
    func setupGraph() {
        
        //coinPerformanceContainer.delegate = self
        //coinPerformanceContainer.lineColor = .red
        //coinPerformanceContainer.walletHeaderView.lineChart.chartDataSet.colors = [.red]
        //coinPerformanceContainer.oneMonthOptionView.showBlueView()
        coinPerformanceContainer.backgroundColor = .clear
        coinPerformanceContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(coinPerformanceContainer)
        coinPerformanceContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        coinPerformanceContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        coinPerformanceContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        coinPerformanceContainer.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    func setupEmtpyState() {
        messagesEmptyState.lockLabel.text = "🚀"
        messagesEmptyState.lockTitleLabel.text = "Coming Soon"
        //messagesEmptyState.lockDetailLabel.setupLineHeight(myText: "Please select an access pass to\nstart using I.R.L.A", myLineSpacing: 6)
        messagesEmptyState.lockDetailLabel.setupLineHeight(myText: "View the historical data\nof your trading account", myLineSpacing: 6)
        messagesEmptyState.lockDetailLabel.textAlignment = .center
        messagesEmptyState.lockTitleLabel.textColor = .white
        messagesEmptyState.lockDetailLabel.textColor = .white.withAlphaComponent(0.5)
        messagesEmptyState.squadUpButton.setTitle("Dashboard", for: .normal)
        messagesEmptyState.squadUpButton.isHidden = true
        messagesEmptyState.backgroundColor = .clear
        messagesEmptyState.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messagesEmptyState)
        messagesEmptyState.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messagesEmptyState.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 80).isActive = true
        messagesEmptyState.heightAnchor.constraint(equalToConstant: 245).isActive = true
        messagesEmptyState.widthAnchor.constraint(equalToConstant: 305).isActive = true
    }
}

//MARK: ACTIONS

extension DashboardMainHeaderView {
    
    @objc func animateViewIn(view: UIView, delay: Double) {
        UIView.animate(withDuration: 0.35, delay: delay, options: []) {
            view.alpha = 1.0
            view.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { success in
            //
        }
    }
    
    @objc func animateViewOut(view: UIView, delay: Double) {
        UIView.animate(withDuration: 0.35, delay: delay, options: []) {
            view.alpha = 0
            view.transform = CGAffineTransform(translationX: 0, y: 50)
        } completion: { success in
            //
        }
    }
    
    @objc func showLineIcon() {
        UIView.animate(withDuration: 0.15) {
            self.listImageView.alpha = 0
            self.listImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        } completion: { success in
            UIView.animate(withDuration: 0.15) {
                self.lineImageView.alpha = 1.0
                self.lineImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
    @objc func showListIcon() {
        UIView.animate(withDuration: 0.15) {
            self.lineImageView.alpha = 0
            self.lineImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        } completion: { success in
            UIView.animate(withDuration: 0.15) {
                self.listImageView.alpha = 1.0
                self.listImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                //lineImageView
            }
        }
    }
    
    @objc func didTapGrid() {
        
        lightImpactGenerator()
        if lineGraphMode {
            showLineIcon()
            self.delegate?.showHideCube(show: true)
            animateViewOut(view: investmentAmountPercentChangeLabel, delay: 0)
            animateViewOut(view: arrowUpImageView, delay: 0)
            animateViewIn(view: equityLabel, delay: 0)
            animateViewIn(view: equityAmountLabel, delay: 0.05)
            animateViewIn(view: equityPercent, delay: 0.1)
            animateViewIn(view: equityPercentAmountLabel, delay: 0.15)
            animateViewIn(view: growthLabel, delay: 0.2)
            animateViewIn(view: growthAmountLabel, delay: 0.25)
            animateViewIn(view: profitLoss, delay: 0.3)
            animateViewIn(view: profitLossLabel, delay: 0.35)
            lineGraphMode = false
            
            UIView.animate(withDuration: 0.35) {
                //self.coinPerformanceContainer.walletHeaderView.alpha = 0
                self.coinPerformanceContainer.alpha = 0
                self.messagesEmptyState.alpha = 0
            } completion: { success in
                //
            }

            
        } else {
            showListIcon()
            animateViewOut(view: profitLossLabel, delay: 0)
            animateViewOut(view: profitLoss, delay: 0.05)
            animateViewOut(view: growthAmountLabel, delay: 0.1)
            animateViewOut(view: growthLabel, delay: 0.15)
            animateViewOut(view: equityPercentAmountLabel, delay: 0.2)
            animateViewOut(view: equityPercent, delay: 0.25)
            animateViewOut(view: equityAmountLabel, delay: 0.3)
            animateViewOut(view: equityLabel, delay: 0.35)
            animateViewIn(view: investmentAmountPercentChangeLabel, delay: 0.35)
            animateViewIn(view: arrowUpImageView, delay: 0.35)
            lineGraphMode = true
            
            UIView.animate(withDuration: 0.35, delay: 0.35, options: []) {
                self.messagesEmptyState.alpha = 1.0
                //self.coinPerformanceContainer.walletHeaderView.alpha = 1.0
                self.coinPerformanceContainer.alpha = 1.0
            } completion: { success in
                self.delegate?.showHideCube(show: false)
            }
        }
    }
    
}
