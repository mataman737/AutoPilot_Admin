//
//  PickOptionViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit

protocol PickOptionViewControllerDelegate: AnyObject {
    func didPickOption(optionSelected: String)
}

class PickOptionViewController: UIViewController {
    
    var mainScrollView = UIScrollView()
    var wrapper = UIView()
    var mainContainer = UIView()
    var navTitleLabel = UILabel()
    var keyLine = UIView()
    var isDismissing = false
    
    weak var delegate: PickOptionViewControllerDelegate?
    var opacityLayer = UIView()    
    var cardHeight: NSLayoutConstraint!
    var titleLabel = UILabel()
    var downArrow = UIImageView()
    var downButton = UIButton()
    var copyButton = UIButton()
    var linkLabel = UILabel()
    
    var purpGradientBG = UIImageView()
    var qrImageView = UIImageView()
    var shareURLButton = ContinueButton()
    var copyURLButton = UIButton()

    var timePickerView = UIPickerView()
    //var options: [String] = ["English", "Spanish", "Portuguese", "Japanese", "Korean", "French", "Russian", "Chinese"]
    var options = ["ADAUSD", "ALUMINIUM", "AUDCAD", "AUDCHF", "AUDJPY", "AUDNZD", "AUDUSD", "AUS200", "AUS200.spot", "AVEUSD", "BCHUSD", "BNBUSD", "BRAIND", "BRENT", "BRENT.spot", "BSVUSD", "BTCEUR", "BTCUSD", "BUND", "CADCHF", "CADJPY", "CHFJPY", "CHNIND", "CHNIND.spot", "COCOA", "COFFEE", "COPPER", "CORN", "COTTON", "DOGUSD", "DOTUSD", "DSHUSD", "EOSUSD", "ETHBTC", "ETHUSD", "EU50", "EU50.spot", "EURAUD", "EURCAD", "EURCHF", "EURCZK", "EURGBP", "EURHUF", "EURJPY", "EURNOK", "EURNZD", "EURPLN", "EURSEK", "EURTRY", "EURUSD", "FRA40", "FRA40.spot", "GAUTRY", "GAUUSD", "GBPAUD", "GBPCAD", "GBPCHF", "GBPJPY", "GBPNZD", "GBPUSD", "GER30", "GER30.spot", "HKIND", "HKIND.spot", "IND50", "ITA40", "ITA40.spot", "JAP225", "JAP225.spot", "KOSP200", "LNKUSD", "LTCUSD", "MEXIND", "NGAS", "NGAS.spot", "NZDCAD", "NZDCHF", "NZDJPY", "NZDUSD", "RUS50", "SA40", "SCHATZ", "SGDJPY", "SOYBEAN", "SPA35", "SPA35.spot", "SUGAR", "SUI20", "THTUSD", "TNOTE", "TRXUSD", "UK100", "UK100.spot", "UNIUSD", "US100", "US100.spot", "US2000", "US30", "US30.spot", "US500", "US500.spot", "USCUSD", "USDBIT", "USDCAD", "USDCHF", "USDCZK", "USDHKD", "USDHUF", "USDIDX", "USDINR", "USDJPY", "USDMXN", "USDNOK", "USDPLN", "USDRUB", "USDSEK", "USDTRY", "USDZAR", "VETUSD", "VIX", "W20", "WHEAT", "WTI", "WTI.spot", "XAGUSD", "XAUEUR", "XAUTRY", "XAUUSD", "XEMUSD", "XLMUSD", "XMRUSD", "XPDUSD", "XPTUSD", "XRPEUR", "XRPUSD", "XTZUSD", "ZINC"]
    var rowSelected = 0
    
    var optionSelected = false
    var fromSplash = false
    var isDarkMode = false
    var textColor: UIColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLaunchTransition()
        perform(#selector(presentViews), with: self, afterDelay: 0.05)
        
        let opacityTapped = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        opacityLayer.addGestureRecognizer(opacityTapped)
        downButton.addTarget(self, action: #selector(dismissViews), for: .touchUpInside)
    }

}

//MARK: ACTIONS

extension PickOptionViewController {
    @objc func presentViews() {
        mainContainer.presentAndBounce()
        UIView.animate(withDuration: 0.2, animations: {
            self.opacityLayer.alpha = 0.4
        }) { (success) in
            //
        }
    }
    
    @objc func dismissViews() {
        lightImpactGenerator()
        UIView.animate(withDuration: 0.2, animations: {
            self.opacityLayer.alpha = 0
            self.mainContainer.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { (success) in
            self.dismiss(animated: true) {
                if self.optionSelected {
                    self.delegate?.didPickOption(optionSelected: self.options[self.rowSelected])
                }
            }
        }
    }
    
    @objc func updateTapped() {
        lightImpactGenerator()
        self.optionSelected = true
        dismissViews()
    }
}

//MARK: PICKER DELEGATE & DATASOURCE

extension PickOptionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        return NSAttributedString(string: options[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
                
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return view.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
    }
    
}

//MARK: SCROLLVIEW DELEGATE

extension PickOptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 1 {
            let yOffset = scrollView.contentOffset.y// + 44
            if yOffset > 0 {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
            
            if yOffset < -45 {
                if !isDismissing {
                    dismissViews()
                    isDismissing = true
                }
            }
        }
                
    }
}
