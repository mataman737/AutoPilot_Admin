//
//  ChartsLineGraphView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/14/23.
//

import UIKit
import Charts

protocol ChartsLineGraphViewDelegate: AnyObject {
    func didEndPanning()
    func didStartPanning()
}

class ChartsLineGraphView: UIView {
    
    var dataToAppend: [Double] = []
    weak var delegate: ChartsLineGraphViewDelegate?
    
    //Line Chart
    var lineChart = UpdatedLineChart()
    var dateStamp = [String]()
    var coinPrice = [String]()
    var lineColor: UIColor = .blue
    
    var newDataSet: [Double] = [30, 45, 40, 55, 50, 43, 48, 50, 30, 38, 42, 58, 34, 45, 48, 30, 33, 15, 18, 16, 19, 14, 25, 22, 23, 21, 22, 40, 42, 50, 45, 38, 33, 35, 30, 26, 25, 20, 19, 23, 20, 20, 30, 35, 38, 37, 36, 80, 70, 75, 72, 68, 67, 68, 62, 70, 63, 59, 62, 70, 71, 73, 74, 70, 63, 64, 65, 57, 55, 53, 52, 60, 61, 62, 69, 70, 72, 71, 65, 60, 61, 62, 59, 60, 62, 63, 58, 67, 68, 63]
    
    //CandleStick Chart
    var candleStickChart = UpdatedCandleStickChart()
    var candleStickCount = Int()
    var candleStickRange = Int()
    
    var isCoinTokenDetail = false
    
    var timeOptionsContainer = UIStackView()
    var oneDayOptionView = TimeOptionView()
    var oneWeekOptionView = TimeOptionView()
    var oneMonthOptionView = TimeOptionView()
    var threeMonthOptionView = TimeOptionView()
    var oneYearOptionView = TimeOptionView()
    var allOptionView = TimeOptionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        // Line Chart
        populateChartData()
        setUplineChart()
        
        // Candle Stick Chart
        //populateCandleStickData()
        //setUpCandleStickChart()
        
        timeOptionsContainer.axis = .horizontal
        timeOptionsContainer.distribution = .fillEqually
        timeOptionsContainer.alignment = .center
        
        //timeOptionsContainer.layer.borderWidth = 1
        //timeOptionsContainer.layer.borderColor = UIColor.green.withAlphaComponent(0.1).cgColor
        timeOptionsContainer.layer.cornerRadius = 32/2
        timeOptionsContainer.backgroundColor = .clear
        timeOptionsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeOptionsContainer)
        timeOptionsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        timeOptionsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        timeOptionsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        timeOptionsContainer.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        oneDayOptionView.timeLabel.text = "1D"
        oneDayOptionView.translatesAutoresizingMaskIntoConstraints = false
        timeOptionsContainer.addSubview(oneDayOptionView)
        oneDayOptionView.leadingAnchor.constraint(equalTo: timeOptionsContainer.leadingAnchor, constant: 0).isActive = true
        setHeightWidth(view: oneDayOptionView, tag: 0)
        
        timeOptionsContainer.addArrangedSubview(oneDayOptionView)
        
        //width = 39
        
        
        oneWeekOptionView.timeLabel.text = "1W"
        oneWeekOptionView.translatesAutoresizingMaskIntoConstraints = false
        timeOptionsContainer.addSubview(oneWeekOptionView)
        oneWeekOptionView.leadingAnchor.constraint(equalTo: oneDayOptionView.trailingAnchor, constant: 25).isActive = true
        setHeightWidth(view: oneWeekOptionView, tag: 1)
        
        timeOptionsContainer.addArrangedSubview(oneWeekOptionView)
        
        oneMonthOptionView.timeLabel.text = "1M"
        oneMonthOptionView.translatesAutoresizingMaskIntoConstraints = false
        timeOptionsContainer.addSubview(oneMonthOptionView)
        oneMonthOptionView.leadingAnchor.constraint(equalTo: oneWeekOptionView.trailingAnchor, constant: 25).isActive = true
        setHeightWidth(view: oneMonthOptionView, tag: 2)
        
        timeOptionsContainer.addArrangedSubview(oneMonthOptionView)
        
        threeMonthOptionView.timeLabel.text = "3M"
        threeMonthOptionView.translatesAutoresizingMaskIntoConstraints = false
        timeOptionsContainer.addSubview(threeMonthOptionView)
        threeMonthOptionView.leadingAnchor.constraint(equalTo: oneMonthOptionView.trailingAnchor, constant: 25).isActive = true
        setHeightWidth(view: threeMonthOptionView, tag: 3)
        
        timeOptionsContainer.addArrangedSubview(threeMonthOptionView)
        
        oneYearOptionView.timeLabel.text = "1Y"
        oneYearOptionView.translatesAutoresizingMaskIntoConstraints = false
        timeOptionsContainer.addSubview(oneYearOptionView)
        oneYearOptionView.leadingAnchor.constraint(equalTo: threeMonthOptionView.trailingAnchor, constant: 25).isActive = true
        setHeightWidth(view: oneYearOptionView, tag: 4)
        
        timeOptionsContainer.addArrangedSubview(oneYearOptionView)
        
        allOptionView.timeLabel.text = "All"
        allOptionView.translatesAutoresizingMaskIntoConstraints = false
        timeOptionsContainer.addSubview(allOptionView)
        allOptionView.leadingAnchor.constraint(equalTo: oneYearOptionView.trailingAnchor, constant: 25).isActive = true
        setHeightWidth(view: allOptionView, tag: 5)
        
        timeOptionsContainer.addArrangedSubview(allOptionView)
        
        didSelectTimeOptionView(sender: oneWeekOptionView)
    }
    
    func setHeightWidth(view: TimeOptionView, tag: Int) {
        view.tag = tag
        view.addTarget(self, action: #selector(didSelectTimeOptionView(sender:)), for: .touchUpInside)
        view.centerYAnchor.constraint(equalTo: timeOptionsContainer.centerYAnchor, constant: -2).isActive = true
        view.heightAnchor.constraint(equalToConstant: 28).isActive = true
        view.widthAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Line Chart
    
    func populateChartData() {
        for i in 0...90 {
            dateStamp.append("\(i)")
            coinPrice.append("\(i)")
        }
        self.getChartData(with: dateStamp, values: coinPrice)
    }
    
    func setUplineChart() {
        lineChart.lineChartDelegate = self
        
        lineChart.delegate = self
        lineChart.backgroundColor = .clear
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineChart)
        //lineChart.fillSuperview()
        lineChart.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChart.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lineChart.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lineChart.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.createAspectRatio(value: 20)).isActive = true
    }
    
    // Candle Stick Chart
    
    func populateCandleStickData() {
        candleStickCount = 45
        candleStickRange = 50
        getCandleData(with: candleStickCount, range: candleStickRange)
    }
    
    func setUpCandleStickChart() {
        candleStickChart.candleStickDelegate = self
        candleStickChart.alpha = 0
        candleStickChart.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        candleStickChart.delegate = self
        candleStickChart.backgroundColor = .clear
        candleStickChart.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(candleStickChart)
        candleStickChart.fillSuperview()
    }
}

//MARK: LINE & CANDLESTICK DATA

extension ChartsLineGraphView: GetChartData {
    func getChartData(with dataPoints: [String], values: [String]) {
        self.dateStamp = dataPoints
        self.coinPrice = values
    }
}

//MARK: CANDLESTICK DATA

extension ChartsLineGraphView: GetCandleStickData {
    func getCandleData(with count: Int, range: Int) {
        self.candleStickCount = count
        self.candleStickRange = range
    }
}

//MARK: LINE CHART DELEGATE

extension ChartsLineGraphView: UpdatedLineChartDelegate {
    func didEndLineChartPan() {
        //delegate?.didEndPanning()
    }
    
    func didStartLineChartPan() {
        //delegate?.didStartPanning()
    }
}

//MARK: CANDLE STICK DELEGATE

extension ChartsLineGraphView: UpdatedCandleStickChartDelegate {
    func didEndCandleStickChartPan() {
        delegate?.didEndPanning()
    }
    
    func didStartCandleStickChartPan() {
        delegate?.didStartPanning()
    }
}


//MARK: ACTIONS

extension ChartsLineGraphView {
    @objc func didSelectTimeOptionView(sender: UIButton) {
        lightImpactGenerator()
        switch sender.tag {
        case 0:
            oneDayOptionView.showBlueView()
            oneWeekOptionView.hideBlueView()
            oneMonthOptionView.hideBlueView()
            threeMonthOptionView.hideBlueView()
            oneYearOptionView.hideBlueView()
            allOptionView.hideBlueView()
            //walletHeaderView.optionSelected = 0
        case 1:
            oneDayOptionView.hideBlueView()
            oneWeekOptionView.showBlueView()
            oneMonthOptionView.hideBlueView()
            threeMonthOptionView.hideBlueView()
            oneYearOptionView.hideBlueView()
            allOptionView.hideBlueView()
        case 2:
            oneDayOptionView.hideBlueView()
            oneWeekOptionView.hideBlueView()
            oneMonthOptionView.showBlueView()
            threeMonthOptionView.hideBlueView()
            oneYearOptionView.hideBlueView()
            allOptionView.hideBlueView()
        case 3:
            oneDayOptionView.hideBlueView()
            oneWeekOptionView.hideBlueView()
            oneMonthOptionView.hideBlueView()
            threeMonthOptionView.showBlueView()
            oneYearOptionView.hideBlueView()
            allOptionView.hideBlueView()
            
        case 4:
            oneDayOptionView.hideBlueView()
            oneWeekOptionView.hideBlueView()
            oneMonthOptionView.hideBlueView()
            threeMonthOptionView.hideBlueView()
            oneYearOptionView.showBlueView()
            allOptionView.hideBlueView()
            
        default:
            oneDayOptionView.hideBlueView()
            oneWeekOptionView.hideBlueView()
            oneMonthOptionView.hideBlueView()
            threeMonthOptionView.hideBlueView()
            oneYearOptionView.hideBlueView()
            allOptionView.showBlueView()
            //walletHeaderView.optionSelected = 1
        }
        
        //hideChart()
        //walletHeaderView.lineChart.reloadInputViews()
    }
    
    @objc func deselectAll() {
        oneDayOptionView.hideBlueView()
        oneWeekOptionView.hideBlueView()
        oneMonthOptionView.hideBlueView()
        oneYearOptionView.hideBlueView()
        allOptionView.hideBlueView()
    }
    
    /*
    @objc func hideChart() {
        UIView.animate(withDuration: 0.35, delay: 0, options: []) {
            self.walletHeaderView.alpha = 0
        } completion: { success in
            //self.walletHeaderView.lineChart.removeFromSuperview()
            self.loadingLottie.play()
            UIView.animate(withDuration: 0.35) {
                self.loadingLottie.alpha = 1.0
            }
            self.perform(#selector(self.showChart), with: self, afterDelay: 0)
        }
    }
    
    @objc func showChart() {
        //self.walletHeaderView.setUplineChart()
        UIView.animate(withDuration: 0.35, delay: 1.0, options: []) {
            self.loadingLottie.alpha = 0
        } completion: { success in
            self.loadingLottie.stop()
            UIView.animate(withDuration: 0.35) {
                self.walletHeaderView.alpha = 1.0
            }
        }
    }
    */
    
    @objc func pieLineTapped(showTimeSelected: Bool) {
        
        lightImpactGenerator()
        
        /*
        if showLine {
            delegate?.hideShowCandleData(show: false)
            showLine = false
            candleStick = true
            
            UIView.animate(withDuration: 0.2) {
                //Icon
                self.candleStickImageView.alpha = 0
                self.candleStickImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                
                self.walletHeaderView.lineChart.alpha = 0
                self.walletHeaderView.lineChart.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            } completion: { (success) in
                if !showTimeSelected {
                    //self.deselectAll()
                }
            }
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: []) {
                //Icon
                self.lineImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.lineImageView.alpha = 1.0
                
                self.walletHeaderView.candleStickChart.alpha = 1.0
                self.walletHeaderView.candleStickChart.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                                
            } completion: { (sucess) in
                
            }
            
        } else {
            candleStick = false
            showLine = true
            delegate?.hideShowCandleData(show: true)
            UIView.animate(withDuration: 0.2) {
                //Icon
                self.lineImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                self.lineImageView.alpha = 0
                
                self.walletHeaderView.candleStickChart.alpha = 0
                self.walletHeaderView.candleStickChart.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            }
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: []) {
                //Icon
                self.candleStickImageView.alpha = 1.0
                self.candleStickImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
                self.walletHeaderView.lineChart.alpha = 1.0
                self.walletHeaderView.lineChart.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { (sucess) in
                //
            }
        }
        */
        
                                        
    }
    
}
