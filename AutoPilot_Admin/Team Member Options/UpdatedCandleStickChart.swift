//
//  UpdatedCandleStickChart.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/14/23.
//

import Charts

protocol UpdatedCandleStickChartDelegate: AnyObject {
    func didEndCandleStickChartPan()
    func didStartCandleStickChartPan()
}

class UpdatedCandleStickChart: UIView {
    
    weak var candleStickDelegate: UpdatedCandleStickChartDelegate?
    
    var floatingLabel = UILabel()
    var floatingLabelCenterConstraint: NSLayoutConstraint!
    var floatingContainer = UIView()
    var floatingContainerCenterConstraint: NSLayoutConstraint!
    
    var isOnLeftSide = false
    var isCenter = true
    var isOnRightSide = false
    var didStartPanning = false
    var opacityLayer = UIView()
    
    //Candlestick properties
    var candleStickChart = CandleStickChartView()
    var candleStickValues: [[Double]] = []
    
    //Candlestick Data
    var candleCount = Int()
    var candleRange = Int()
    
    var dateStamp = [String]()
    
    var delegate: GetCandleStickData! {
        didSet {
            populateData()
            setCandleStickDataCount()
        }
    }
    
    func populateData() {
        candleCount = delegate.candleStickCount
        candleRange = delegate.candleStickRange
    }
    
    func setCandleStickDataCount() {
        
        candleStickChart.delegate = self
        let pan = candleStickChart.gestureRecognizers?.first { $0 is UIPanGestureRecognizer }
        let tap = candleStickChart.gestureRecognizers?.first { $0 is UITapGestureRecognizer }
        pan?.addTarget(self, action: #selector(gestureRecognized(_:)))
        tap?.addTarget(self, action: #selector(tapGestureRecognized(_:)))
        
        candleStickChart.backgroundColor = .clear
        candleStickChart.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(candleStickChart)
        candleStickChart.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        candleStickChart.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        candleStickChart.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        candleStickChart.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        candleStickChart.chartDescription.enabled = false
        candleStickChart.dragEnabled = true
        candleStickChart.setScaleEnabled(false)
        candleStickChart.maxVisibleCount = 1000
        candleStickChart.pinchZoomEnabled = false
        
        candleStickChart.legend.enabled = false
        candleStickChart.legend.horizontalAlignment = .right
        candleStickChart.legend.verticalAlignment = .top
        candleStickChart.legend.orientation = .vertical
        candleStickChart.legend.drawInside = false
                
        candleStickChart.leftAxis.spaceTop = 0.3
        candleStickChart.leftAxis.spaceBottom = 0.3
        candleStickChart.leftAxis.axisMinimum = 0
        candleStickChart.leftAxis.enabled = false
        candleStickChart.xAxis.drawAxisLineEnabled = false
        
        candleStickChart.rightAxis.enabled = false
        
        candleStickChart.xAxis.labelPosition = .bottom
        candleStickChart.xAxis.enabled = false
        
        //
                    
        floatingContainer.isHidden = true
        floatingContainer.backgroundColor = .clear
        floatingContainer.translatesAutoresizingMaskIntoConstraints = false
        candleStickChart.addSubview(floatingContainer)
        floatingContainer.topAnchor.constraint(equalTo: candleStickChart.topAnchor, constant: -5).isActive = true
        floatingContainerCenterConstraint = floatingContainer.centerXAnchor.constraint(equalTo: candleStickChart.centerXAnchor, constant: -(375/2))
        floatingContainerCenterConstraint.isActive = true
        floatingContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        floatingContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
                
        floatingLabel.text = ""
        floatingLabel.layer.zPosition = 3
        floatingLabel.textAlignment = .center
        floatingLabel.textColor = .black
        floatingLabel.font = .poppinsMedium(ofSize: 12)//.aeonikMedium(ofSize: 12)
        floatingLabel.numberOfLines = 0
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        candleStickChart.addSubview(floatingLabel)
        floatingLabel.topAnchor.constraint(equalTo: candleStickChart.topAnchor, constant: -5).isActive = true
        //floatingLabelCenterConstraint = floatingLabel.centerXAnchor.constraint(equalTo: lineChartView.centerXAnchor, constant: -(375/2))
        floatingLabelCenterConstraint = floatingLabel.centerXAnchor.constraint(equalTo: floatingContainer.centerXAnchor, constant: 0)
        floatingLabelCenterConstraint.isActive = true
        
        opacityLayer.isHidden = true
        opacityLayer.backgroundColor = UIColor(red: 17/255, green: 17/255, blue: 19/255, alpha: 0.75)
        opacityLayer.translatesAutoresizingMaskIntoConstraints = false
        candleStickChart.addSubview(opacityLayer)
        opacityLayer.trailingAnchor.constraint(equalTo: candleStickChart.trailingAnchor).isActive = true
        opacityLayer.topAnchor.constraint(equalTo: candleStickChart.topAnchor, constant: 0).isActive = true
        opacityLayer.leadingAnchor.constraint(equalTo: floatingContainer.centerXAnchor).isActive = true
        opacityLayer.bottomAnchor.constraint(equalTo: candleStickChart.bottomAnchor).isActive = true
        
        //Candle Stick population
        setDataCount(Int(candleCount), range: UInt32(candleRange))
        
    }
    
    @objc func gestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .ended || recognizer.state == .cancelled {
            // Pan Ended
            didStartPanning = false
            floatingLabel.isHidden = true
            floatingContainer.isHidden = true
            opacityLayer.isHidden = true
            candleStickChart.highlightValue(nil)
            candleStickDelegate?.didEndCandleStickChartPan()
        }
    }
    
    @objc func tapGestureRecognized(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            floatingLabel.isHidden = true
            floatingContainer.isHidden = true
            candleStickChart.highlightValue(nil)
        }
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> CandleChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(40) + mult)
            let high = Double(arc4random_uniform(9) + 8)
            let low = Double(arc4random_uniform(9) + 8)
            let open = Double(arc4random_uniform(6) + 1)
            let close = Double(arc4random_uniform(6) + 1)
            let even = i % 2 == 0
                        
            candleStickValues.append([
                                        //X Value [0]
                                        Double(i),
                                        //Shadow High [1]
                                        val + high,
                                        //Shadow Low [2]
                                        val - low,
                                        //Open [3]
                                        even ? val + open : val - open,
                                        //Close [4]
                                        even ? val - close : val + close])
            
            return CandleChartDataEntry(x: Double(i), shadowH: val + high, shadowL: val - low, open: even ? val + open : val - open, close: even ? val - close : val + close)
        }
        
        print("\(candleStickValues[0][0]) - 😅😅😅 \(dateStamp) 😅😅😅")
        
        let set1 = CandleChartDataSet(entries: yVals1, label: "Data Set")
        set1.axisDependency = .left
        set1.setColor(UIColor(white: 80/255, alpha: 1))
        set1.drawIconsEnabled = false
        set1.drawHorizontalHighlightIndicatorEnabled = false
        //set1.highlightLineDashLengths = [5]
        set1.highlightColor = .black
        set1.highlightColor = .black.withAlphaComponent(0.25)
        set1.shadowColor = UIColor.black.withAlphaComponent(0.5)
        set1.shadowWidth = 1.0
        set1.decreasingColor = .purple
        set1.decreasingFilled = true
        set1.increasingColor = .green
        set1.increasingFilled = true
        set1.neutralColor = .green
        set1.drawValuesEnabled = false
        set1.barSpace = 0.3
        
        
        let data = CandleChartData(dataSet: set1)
        candleStickChart.data = data
    }

}

//MARK: CHARTVIEW DELEGATE

extension UpdatedCandleStickChart: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        candleStickDelegate?.didStartCandleStickChartPan()
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
                
        let screenWidth: CGFloat = UIScreen.main.bounds.width - .createAspectRatio(value: 20 * 2)
        
        if highlight.xPx > screenWidth * 0.75 {
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
                        
        } else if highlight.xPx < screenWidth * 0.25 {
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
            
        } else {
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
            
        }
        
        floatingContainerCenterConstraint.constant = (highlight.xPx - (screenWidth/2))// + .createAspectRatio(value: 40)
                        
        //floatingLabel.text = "Day \(dateStamp[Int(highlight.x)]) - Price \(coinPrice[Int(highlight.x)])"
        //floatingLabel.text = "Day \(dateStamp[Int(highlight.x) + 1])"
        //candleStickValues[0][0]
        
        floatingLabel.text = "Day \(Float(candleStickValues[Int(highlight.x)][0] + 1).clean)"
        print("Day \(Float(candleStickValues[Int(highlight.x)][0] + 1).clean)")
        
        //floatingLabel.text = "Day 10"
        
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



