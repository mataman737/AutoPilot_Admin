//
//  UpdatedLineChart.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/14/23.
//

import UIKit
import Charts

protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [String])
    var dateStamp: [String] {get set}
    var coinPrice: [String] {get set}
}

protocol GetCandleStickData {
    func getCandleData(with count: Int, range: Int)
    var candleStickCount: Int {get set}
    var candleStickRange: Int {get set}
}

protocol GetPieChartData {
    func getPieChartdata(with dataPoints: [String], values: [Double])
    var pieChartDataPoints: [String] {get set}
    var pieChartValues: [Double] {get set}
}

protocol GetROIChartData {
    func getROIChartdata(with dataPoints: [String], values: [Double])
    var roiDataPoints: [String] {get set}
    var roiChartValues: [Double] {get set}
}

protocol MyWalletChartsDelegate: AnyObject {
    func didEndLinePan()
    func didStartPan()
}

protocol UpdatedLineChartDelegate: AnyObject {
    func didEndLineChartPan()
    func didStartLineChartPan()
}

class UpdatedLineChart: UIView {
    
    var isDarkMode = UserDefaults()
    var usersBrokerHistoricalPrices: [Double] = []
    var priceDates: [String] = []
    var forexExpertsBrokerHistoricalPrices: [Double] = []
    var stopLossToAppend: [Double] = []
    var takeProfitToAppend: [Double] = []
    var takeProfitTwoToAppend: [Double] = []
    var takeProfitThreeToAppend: [Double] = []
    var traderEntryToAppend: [Double] = []
    var userBrokerEntryToAppend: [Double] = []
    
    var userBrokerPricesDates: [String] = []
    
    weak var lineChartDelegate: UpdatedLineChartDelegate?
    var floatingLabel = UILabel()
    var floatingLabelCenterConstraint: NSLayoutConstraint!
    var floatingContainer = UIView()
    var floatingContainerCenterConstraint: NSLayoutConstraint!
    
    var isOnLeftSide = false
    var isCenter = true
    var isOnRightSide = false
    
    var isCoinTokenDetail = false
    
    //Line graph properties
    var lineChartView = LineChartView()//LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    var lineDataEntryTwo: [ChartDataEntry] = []
    var lineDataEntryStopLoss: [ChartDataEntry] = []
    var lineDataEntryTakeProfit: [ChartDataEntry] = []
    var lineDataEntryTakeProfitTwo: [ChartDataEntry] = []
    var lineDataEntryTakeProfitThree: [ChartDataEntry] = []
    var lineDataTraderEntry: [ChartDataEntry] = []
    var lineDataUserBrokerEntry: [ChartDataEntry] = []
    
    //Chart Data
    var dateStamp = [String]()
    var coinPrice = [String]()
    var didStartPanning = false
    
    var chartDataSet = LineChartDataSet()
    var chartDataSetTwo = LineChartDataSet()
    var chartDataSetStopLoss = LineChartDataSet()
    var chartDataSetTakeProfit = LineChartDataSet()
    var chartDataSetTakeProfitTwo = LineChartDataSet()
    var chartDataSetTakeProfitThree = LineChartDataSet()
    var chartDataSetTraderEntry = LineChartDataSet()
    var chartDataSetUserBrokerEntry = LineChartDataSet()
    
    var delegate: GetChartData! {
        didSet {
            populateData()
            lineChartSetup()
        }
    }
    
    func populateData() {
        dateStamp = delegate.dateStamp
        coinPrice = delegate.coinPrice
    }
    
    func lineChartSetup() {
                        
        //lineChartView.leftAxis.axisMinimum = 1.07600  //1.070
        //lineChartView.leftAxis.axisMaximum = 1.08800 //1.09600   //1.100 //1.09900
        lineChartView.delegate = self
        lineChartView.isUserInteractionEnabled = true
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.pinchZoomEnabled = false
        let pan = lineChartView.gestureRecognizers?.first { $0 is UIPanGestureRecognizer }
        let tap = lineChartView.gestureRecognizers?.first { $0 is UITapGestureRecognizer }
        pan?.addTarget(self, action: #selector(gestureRecognized(_:)))
        tap?.addTarget(self, action: #selector(tapGestureRecognized(_:)))
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineChartView)
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        //Line chart animation
        //lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 0, easingOption: .easeInSine)
        //lineChartView.addBigLimeGreenShadow()
        
        //Line chart population
        
        coinPrice.removeAll()
        
        var tradeDates: [String] = []
        
        for i in 0...dateStamp.count - 1 {
            tradeDates.append("\(i)")
        }
        
        //print("\(dateStamp) 🫁🫁🫁")
        //print("\(tradeDates) 🔥🔥🔥")
        
        setLineChart(dataPoints: dateStamp, values: tradeDates) //coinPrice
    }

    
    @objc func gestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .ended || recognizer.state == .cancelled {
            // Pan Ended
            didStartPanning = false
            floatingLabel.isHidden = true
            floatingContainer.isHidden = true
            lineChartView.highlightValue(nil)
            heavyImpactGenerator()
            lineChartDelegate?.didEndLineChartPan()
        }
    }
    
    @objc func tapGestureRecognized(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            floatingLabel.isHidden = true
            floatingContainer.isHidden = true
            lineChartView.highlightValue(nil)
        }
    }
    
    func randomizeArray<T>(_ array: [T]) -> [T] {
        var randomizedArray = array
        for i in stride(from: randomizedArray.count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            if i != j {
                randomizedArray.swapAt(i, j)
            }
        }
        return randomizedArray
    }
    
    func setLineChart(dataPoints: [String], values: [String]) {
        
        //No data setup
        
        lineChartView.noDataTextColor = UIColor.white
        lineChartView.noDataText = "No data for the chart."
        lineChartView.backgroundColor = .clear
        
        lineDataEntry = []
        
        print("📬📬📬 \(usersBrokerHistoricalPrices) 📬📬📬")
                        
        guard usersBrokerHistoricalPrices.count > 0 else { return }
        
        var tradeDates: [String] = []
        
        for i in 0...usersBrokerHistoricalPrices.count - 1 {
            tradeDates.append("\(i)")
        }
        
        //print("❤️❤️❤️ \(tradeDates.count) ❤️❤️❤️ \(usersBrokerHistoricalPrices.count)")
        
        for i in 0...usersBrokerHistoricalPrices.count - 1 {
            //print("\(usersBrokerHistoricalPrices.count) 🤢🤢🤢 \(tradeDates.count)") //values.count
            let dataPoint = ChartDataEntry(x: Double(tradeDates[i])!, y: usersBrokerHistoricalPrices[i])
            
            //print("❤️❤️❤️ \(usersBrokerHistoricalPrices[i]) ❤️❤️❤️")
            lineDataEntry.append(dataPoint)
            
            //print("❤️❤️❤️ \(dataPoint) ❤️❤️❤️")
                        
        }
        
        //print("\(lineDataEntry) ❤️❤️❤️")
        
        chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "BPM")
    
        let chartData = LineChartData()
        chartData.append(chartDataSet)
        
        chartData.setDrawValues(false)
        chartDataSet.drawCirclesEnabled = true
        
        //if let userBrokerColor = hexToUIColor("#3891a6")  {
            createChartDataSet(chartData: chartDataSet, chartColors: [.mainThemeGreen])
        //}
                
        let emptyVals = [Highlight]()
        lineChartView.highlightValues(emptyVals)
        //chartDataSet.highlightColor = .polar
        //chartDataSet.isHorizontalHighlightIndicatorEnabled = false
        
        //Gradient fill
        /*
        let gradietColors = [UIColor.systemPink.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0] // positioning of gradient
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradietColors, locations: colorLocations) else {
            print("gradient error"); return
        }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = false
        */
        
        //Axes setup
        /*
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(values: dataPoints)
        let xaxis: XAxis = XAxis()
        xaxis.valueFormatter = formatter
        */
        
        /*
        //let formatter: AxisValueFormatter = AxisValueFormatter()
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(values: dataPoints)
        let xaxis: XAxis = XAxis()
        //xaxis.vormatt = formatter
        //xaxis.valueFormatter?.stringForValue(dataPoints, axis: xaxis)
        */
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.drawLabelsEnabled = false
        //lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        
        //lineChartView.chartDescription?.enabled = true
        lineChartView.chartDescription.enabled = true
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = false
        
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = false
        lineChartView.leftAxis.drawAxisLineEnabled = false
        
        //print("🥶🥶🥶 \(chartData) 🥶🥶🥶")
        lineChartView.data = chartData
        
        //
        
        floatingContainer.isHidden = false
        floatingContainer.backgroundColor = .white
        floatingContainer.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.addSubview(floatingContainer)
        floatingContainer.topAnchor.constraint(equalTo: lineChartView.topAnchor, constant: -0).isActive = true
        floatingContainerCenterConstraint = floatingContainer.centerXAnchor.constraint(equalTo: lineChartView.centerXAnchor, constant: -(UIScreen.main.bounds.width/2))
        floatingContainerCenterConstraint.isActive = true
        floatingContainer.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 15)).isActive = true
        floatingContainer.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 150)).isActive = true
        
        floatingLabel.text = ""
        floatingLabel.layer.zPosition = 3
        floatingLabel.textAlignment = .center
        floatingLabel.textColor = .black//.polar
        floatingLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 12))//.aeonikMedium(ofSize: .createAspectRatio(value: 12))
        floatingLabel.numberOfLines = 0
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        floatingContainer.addSubview(floatingLabel)
        floatingLabelCenterConstraint = floatingLabel.centerXAnchor.constraint(equalTo: floatingContainer.centerXAnchor, constant: 0)
        floatingLabelCenterConstraint.isActive = true
        floatingLabel.centerYAnchor.constraint(equalTo: floatingContainer.centerYAnchor, constant: 0).isActive = true
    }
    
    func createChartDataSet(chartData: LineChartDataSet, chartColors: [UIColor]) {
        chartData.colors = chartColors
        chartData.mode = .linear
        chartData.lineWidth = 1
        chartData.drawHorizontalHighlightIndicatorEnabled = false
        chartData.highlightLineDashLengths = [5]
        chartData.highlightEnabled = true
        chartData.highlightLineWidth = 1
        chartData.circleRadius = 0
                
    }
}

//MARK: CHARTVIEW DELEGATE

extension UpdatedLineChart: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        lineChartDelegate?.didStartLineChartPan()
        
        if !didStartPanning {
            didStartPanning = true
            heavyImpactGenerator()
        } else {
            if Int(highlight.xPx).isMultiple(of: 2) {
                //lightImpactGenerator()
            }
        }
                
        floatingLabel.isHidden = false
        floatingContainer.isHidden = false
        // I used the x pixel property of the highlight to update the
        // position of the floating label, and set its text to the
        // x value of the selected entry
        
        //print("\(highlight.xPx) - 🙂🙂🙂")
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width - .createAspectRatio(value: 20 * 2) - .createAspectRatio(value: 20 * 2)
        
        if highlight.xPx > screenWidth * 0.75 {
            //floatingLabelCenterConstraint?.constant = (highlight.xPx - (screenWidth/2)) - 10
            //floatingLabel.textAlignment = .right
            
            if !isOnRightSide {
                isOnRightSide = true
                self.floatingLabelCenterConstraint.constant = -.createAspectRatio(value: 100)
                UIView.animate(withDuration: 0.35) {
                    self.layoutIfNeeded()
                }
            }
            
            isCenter = false
            isOnLeftSide = false
            
            //print("\(highlight.xPx) - 🙂🙂🙂")
            
        } else if highlight.xPx < screenWidth * 0.25 {
            //floatingLabelCenterConstraint?.constant = (highlight.xPx - (screenWidth/2)) + 10
            //floatingLabel.textAlignment = .left
            
            if !isOnLeftSide {
                isOnLeftSide = true
                self.floatingLabelCenterConstraint.constant = .createAspectRatio(value: 68)
                UIView.animate(withDuration: 0.35) {
                    self.layoutIfNeeded()
                }
            }
            isCenter = false
            isOnRightSide = false
            
            //print("\(highlight.xPx) - 💋💋💋")
        } else {
            //floatingLabelCenterConstraint?.constant = (highlight.xPx - (screenWidth/2)) + 0
            //floatingLabel.textAlignment = .center
            _ = floatingLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: floatingLabel.frame.size.height)).width
            //print("\(width) 😶‍🌫️😶‍🌫️😶‍🌫️")
            
            if !isCenter {
                isCenter = true
                self.floatingLabelCenterConstraint.constant = 0//0
                UIView.animate(withDuration: 0.35) {
                    self.layoutIfNeeded()
                }
            }
            isOnLeftSide = false
            isOnRightSide = false
            
            //print("\(highlight.xPx) - 🚀🚀🚀")
        }
        
        floatingContainerCenterConstraint.constant = (highlight.xPx - (screenWidth/2)) + -.createAspectRatio(value: 20)// + .createAspectRatio(value: 40)
                        
        //floatingLabel.text = "Day \(dateStamp[Int(highlight.x)]) - Price \(coinPrice[Int(highlight.x)])"
        //floatingLabel.text = "Day \(dateStamp[Int(highlight.x) + 1])"
        let updatedDate = priceDates[Int(highlight.x)].replacingOccurrences(of: "AM", with: "am").replacingOccurrences(of: "PM", with: "pm")
        floatingLabel.text = "🕓\(updatedDate) 🎯\(usersBrokerHistoricalPrices[Int(highlight.x)])"
        
        // Create the nice transition animation
        // fadeIn() and fadeOut() are simple extension methods I wrote
        if floatingLabel.isHidden {
            //floatingLabel.fadeIn()
            //subscripts.fadeOut()
        }
        
        // This gives you the y value of the selected entry
        //greenNumber.text = NSString(format: "%.2f", highlight.y) as String
        
    }
    
    func hexToUIColor(_ hex: String) -> UIColor? {
        var formattedHex = hex
        if formattedHex.hasPrefix("#") {
            formattedHex.removeFirst()
        }
        
        guard formattedHex.count == 6, let hexValue = Int(formattedHex, radix: 16) else {
            return nil
        }
        
        let red = CGFloat((hexValue >> 16) & 0xFF) / 255.0
        let green = CGFloat((hexValue >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hexValue & 0xFF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

/*
//MARK: Chart Formatter required to config xaxis

public class ChartFormatter: NSObject, IAxisValueFormatter {
    
    var dateStamp = [String]()
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        
        return dateStamp[Int(value)]
    }
    
    public func setValues(values: [String]) {
        self.dateStamp = values
    }
    
}
*/
