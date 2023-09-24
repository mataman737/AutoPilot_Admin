//
//  UpdatedMiniLineChart.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/24/23.
//

import UIKit
import Charts

protocol UpdatedMiniLineChartDelegate: AnyObject {
    func didEndLineChartPan()
    func didStartLineChartPan()
}

class UpdatedMiniLineChart: UIView {
        
    var dataToAppend: [Double] = []
    
    weak var lineChartDelegate: UpdatedMiniLineChartDelegate?
    var floatingLabel = UILabel()
    var floatingLabelCenterConstraint: NSLayoutConstraint!
    var floatingContainer = UIView()
    var floatingContainerCenterConstraint: NSLayoutConstraint!
    
    var isOnLeftSide = false
    var isCenter = true
    var isOnRightSide = false
    
    //Line graph properties
    var lineChartView = LineChartView()//LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    
    //Chart Data
    var dateStamp = [String]()
    var coinPrice = [String]()
    var didStartPanning = false
        
    var chartDataSet = LineChartDataSet()
    var isPositive = true
    
    var delegate: GetChartData! {
        didSet {
            print("did this 🧥🧥🧥 222")
            populateData()
            lineChartSetup()
        }
    }
    
    func populateData() {
        dateStamp = delegate.dateStamp
        coinPrice = delegate.coinPrice
    }
    
    func lineChartSetup() {
                        
        for subview in subviews {
            subview.removeFromSuperview()
        }
        lineChartView.isUserInteractionEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        //Line chart population
        setLineChart(dataPoints: dateStamp, values: coinPrice)
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
            //heavyImpactGenerator()
        }
    }
    
    func setLineChart(dataPoints: [String], values: [String]) {
        
        //No data setup
        lineChartView.noDataTextColor = UIColor.white
        lineChartView.noDataText = "No data for the chart."
        lineChartView.backgroundColor = .clear
        
        lineDataEntry = []
        
        guard dataToAppend.count > 0 else { return }
        for i in 0...dataToAppend.count - 1 {
            let dataPoint = ChartDataEntry(x: Double(values[i])!, y: dataToAppend[i])
            lineDataEntry.append(dataPoint)
        }
        
        //let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "BPM")
        chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "BPM")
    
        let chartData = LineChartData()
        //chartData.addDataSet(chartDataSet)
        chartData.append(chartDataSet)
        chartData.setDrawValues(false)
        chartDataSet.drawCirclesEnabled = true
        
        if isPositive {
            chartDataSet.colors = [UIColor(red: 18/255, green: 183/255, blue: 106/255, alpha: 1.0)]
        } else {
            chartDataSet.colors = [UIColor(red: 191/255, green: 107/255, blue: 107/255, alpha: 1.0)]
        }
        
        //chartDataSet.colors = [.orange]//[lineColor]
        //chartDataSet.setCircleColor(lineColor)
        //chartDataSet.circleHoleColor = .yellow
        //chartDataSet.colors = [.neonPurple.withAlphaComponent(0.65)]
        
        
        chartDataSet.mode = .linear//.cubicBezier
        //chartDataSet.circleRadius = 4
        
        chartDataSet.lineWidth = 1
        //chartDataSet.highlightColor = .polar
        
        chartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet.highlightLineDashLengths = [5]
                
        let emptyVals = [Highlight]()
        lineChartView.highlightValues(emptyVals)
        
        chartDataSet.circleRadius = 0
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
        
        lineChartView.data = chartData
        
        //
        
        /*
        floatingContainer.isHidden = true
        floatingContainer.backgroundColor = .clear
        floatingContainer.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.addSubview(floatingContainer)
        floatingContainer.topAnchor.constraint(equalTo: lineChartView.topAnchor, constant: -5).isActive = true
        floatingContainerCenterConstraint = floatingContainer.centerXAnchor.constraint(equalTo: lineChartView.centerXAnchor, constant: -(UIScreen.main.bounds.width/2))
        floatingContainerCenterConstraint.isActive = true
        floatingContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        floatingContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        floatingLabel.text = ""
        floatingLabel.layer.zPosition = 3
        floatingLabel.textAlignment = .center
        floatingLabel.textColor = .black//.polar
        floatingLabel.font = .sofiaProMedium(ofSize: .createAspectRatio(value: 12))//.aeonikMedium(ofSize: .createAspectRatio(value: 12))
        floatingLabel.numberOfLines = 0
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.addSubview(floatingLabel)
        floatingLabel.topAnchor.constraint(equalTo: lineChartView.topAnchor, constant: -5).isActive = true
        floatingLabelCenterConstraint = floatingLabel.centerXAnchor.constraint(equalTo: floatingContainer.centerXAnchor, constant: 0)
        floatingLabelCenterConstraint.isActive = true
        */
    }
}

//MARK: CHARTVIEW DELEGATE

extension UpdatedMiniLineChart: ChartViewDelegate {
    
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
            floatingLabel.textAlignment = .right
            
            if !isOnRightSide {
                isOnRightSide = true
                self.floatingLabelCenterConstraint.constant = -17
                UIView.animate(withDuration: 0.35) {
                    self.layoutIfNeeded()
                }
            }
            
            isCenter = false
            isOnLeftSide = false
            
            //print("\(highlight.xPx) - 🙂🙂🙂")
            
        } else if highlight.xPx < screenWidth * 0.25 {
            //floatingLabelCenterConstraint?.constant = (highlight.xPx - (screenWidth/2)) + 10
            floatingLabel.textAlignment = .left
            
            if !isOnLeftSide {
                isOnLeftSide = true
                self.floatingLabelCenterConstraint.constant = 10
                UIView.animate(withDuration: 0.35) {
                    self.layoutIfNeeded()
                }
            }
            isCenter = false
            isOnRightSide = false
            
            //print("\(highlight.xPx) - 💋💋💋")
        } else {
            //floatingLabelCenterConstraint?.constant = (highlight.xPx - (screenWidth/2)) + 0
            floatingLabel.textAlignment = .center
            
            if !isCenter {
                isCenter = true
                self.floatingLabelCenterConstraint.constant = 0
                UIView.animate(withDuration: 0.35) {
                    self.layoutIfNeeded()
                }
            }
            isOnLeftSide = false
            isOnRightSide = false
            
            //print("\(highlight.xPx) - 🚀🚀🚀")
        }
        
        floatingContainerCenterConstraint.constant = (highlight.xPx - (screenWidth/2))// + .createAspectRatio(value: 40)
                        
        //floatingLabel.text = "Day \(dateStamp[Int(highlight.x)]) - Price \(coinPrice[Int(highlight.x)])"
        floatingLabel.text = "Day \(dateStamp[Int(highlight.x) + 1])"
        
        // Create the nice transition animation
        // fadeIn() and fadeOut() are simple extension methods I wrote
        if floatingLabel.isHidden {
            //floatingLabel.fadeIn()
            //subscripts.fadeOut()
        }
        
        // This gives you the y value of the selected entry
        //greenNumber.text = NSString(format: "%.2f", highlight.y) as String
        
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
