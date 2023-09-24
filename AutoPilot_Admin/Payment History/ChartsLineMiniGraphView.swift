//
//  ChartsLineMiniGraphView.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/24/23.
//

import UIKit
import Charts

protocol ChartsLineMiniGraphViewwDelegate: AnyObject {
    func didEndPanning()
    func didStartPanning()
}

class ChartsLineMiniGraphView: UIView, GetChartData {
    
    var dataToAppend: [Double] = [] // [30, 45, 40, 55, 50, 43, 48, 50, 30, 38, 42, 58, 34, 45, 48, 30, 33, 15, 18, 16, 19, 14, 25, 22, 23, 21, 22, 40, 42, 50, 45, 38, 33, 35, 30, 26, 25, 20, 19, 23, 20, 20, 30, 35, 38, 37, 36, 80, 70, 75, 72, 68, 67, 68, 62, 70, 63, 59, 62, 70, 71, 73, 74, 70, 63, 64, 65, 57, 55, 53, 52, 60, 61, 62, 69, 70, 72, 71, 65, 60, 61, 62, 59, 60, 62, 63, 58, 67, 68, 63]
    weak var delegate: ChartsLineGraphViewDelegate?
    
    //Line Chart
    let lineChart = UpdatedMiniLineChart()
    var dateStamp = [String]()
    var coinPrice = [String]()
    var lineColor: UIColor = .blue
        
    override init(frame: CGRect) {
       super.init(frame: frame)
       self.backgroundColor = .clear
        // Line Chart
        print("did this 🧥🧥🧥 111 \(dataToAppend.count)")
//        lineChart.dataToAppend = dataToAppend
        populateChartData()
        setUplineChart()
   }
    
    required init(dataToAppend: [Double]){
        super.init(frame: CGRect.zero)
        // Can't call super.init() here because it's a convenience initializer not a desginated initializer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Line Chart
    
    func getChartData(with dataPoints: [String], values: [String]) {
        self.dateStamp = dataPoints
        self.coinPrice = values
    }
    
    func populateChartData() {
        dateStamp = []
        coinPrice = []
        for i in 0...90 {
        //for i in 0...48 {
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
        lineChart.fillSuperview()
        
    }
}


//MARK: LINE CHART DELEGATE

extension ChartsLineMiniGraphView: UpdatedMiniLineChartDelegate {
    func didEndLineChartPan() {
        delegate?.didEndPanning()
    }
    
    func didStartLineChartPan() {
        delegate?.didStartPanning()
    }
}

