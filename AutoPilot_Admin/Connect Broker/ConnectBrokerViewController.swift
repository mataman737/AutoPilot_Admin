//
//  ConnectBrokerViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/11/23.
//

import UIKit
import Lottie

protocol ConnectBrokerViewControllerDelegate: AnyObject {
    func didAddBrokerAccount()
    func cantConnectBroker()
}

class ConnectBrokerViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var isNVUDemo = UserDefaults()
    var cantConnect = false
    var isDarkMode = UserDefaults()
    var varBlackColor: UIColor = UIColor.black
    var varWhiteColor: UIColor = UIColor.white
    weak var delegate: ConnectBrokerViewControllerDelegate?
    var opacityLayer = UIView()
    var mainScrollView = UIScrollView()
    var wrapper = UIView()
    var mainContainer = UIView()
    var navView = UIView()
    var navTitleLabel = UILabel()
    var keyLine = UIView()
    var isDismissing = false
    var isFirstStep = true
    var titleLabel = UILabel()
    var detailLabelZero = UILabel()
    var detailLabelOne = UILabel()
    var skipLabel = UILabel()
    var skipButton = UIButton()
    var nextButton = ContinueButton()
    var mainContainerHeight: NSLayoutConstraint!
    var serverTop: NSLayoutConstraint!
    var noBrokerLabel = UILabel()
    var noBrokerButton = UIButton()
    var usernameEmailContainer = UIView()
    var usernameEmailTextField = UITextField()
    var passwordContainer = UIView()
    var passwordTextField = UITextField()
    var eyeOffImageView = UIImageView()
    var secureEntryButton = UIButton()
    var eyeLottie = LottieAnimationView()
    var dividerLine = UIView()
    var connectingLottie = LottieAnimationView()
    var connectingLabel = UILabel()
    var checkmarkLottie = LottieAnimationView()
    var showSecureEntry = true
    var checkmarkOneLottie = LottieAnimationView()
    var orderPlaced = UILabel()
    var checkBackOfficeLabel = UILabel()
    var accountName = "Bloop"
    var serverContainer = UIView()
    var serverusernameEmailTextField = UITextField()
    var accountusernameEmailContainer = UIView()
    var accountusernameEmailTextField = UITextField()
    var accountNameCharacterCountLabel = UILabel()
    var accountNameCharacterCount: Int = 0
    var serverOptionsPickerView = UIPickerView()
    var brokerOptionsPickerView = UIPickerView()
    var brokers = [String]()
    var didPickBroker = false
    var rowSelected = 0
    var pickServerMode = false
    var doneButton = ContinueButton()
    var servers = [MTServerBroker]()
    var selectedBrokerServers: [String] = []
    var brokersTableContainer = UIView()
    var availableBrokersTableView = UITableView()
    var brokerServersTableView = UITableView()
    var connectBrokerTableViewCell = "connectBrokerTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        setupViews()
        setupTableView()
        setupLoader()
        getServers()
        perform(#selector(animateViewsIn), with: self, afterDelay: 0.01)
    }
    
    func getServers() {
        API.sharedInstance.getMTServers { success, servers, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let servers = servers else {
                print("error getting servers")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.servers = servers
                if let unwrappedServers = self?.servers {
                    self?.servers = unwrappedServers.sorted { $0.broker < $1.broker }
                    self?.serverOptionsPickerView.reloadAllComponents()
                    self?.brokerOptionsPickerView.reloadAllComponents()
                    self?.availableBrokersTableView.reloadData()
                    
                                        
                    /*
                    print("🫁🫁🫁 000")
                    for server in servers {
                        print("\(server.broker)")
                    }
                    print("🫁🫁🫁 111")
                    */
                    //🫁🫁🫁
                    //print("\(self?.servers.count) ⚡️⚡️⚡️")
                }
            }
        }
    }
}

//MARK: ACTIONS ------------------------------------------------------------------------------------------------------------------------------------

extension ConnectBrokerViewController {
    @objc func didTapServer() {
        lightImpactGenerator()
        pickServerMode = true
        didPickBroker = false
        mainContainerHeight.constant = .createAspectRatio(value: .createAspectRatio(value: 640)) //self.view.frame.height - .createAspectRatio(value: 100)
        serverTop.constant = -.createAspectRatio(value: 120)
        availableBrokersTableView.isUserInteractionEnabled = true
        brokersTableContainer.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.35) {
            self.usernameEmailContainer.alpha = 0
            self.passwordContainer.alpha = 0
            self.dividerLine.alpha = 0
            self.serverOptionsPickerView.alpha = 1.0
            self.view.endEditing(true)
            self.view.layoutIfNeeded()
            
            self.brokersTableContainer.alpha = 1.0
            
        } completion: { (success) in
            self.serverOptionsPickerView.isUserInteractionEnabled = true
        }
        
        nextButton.continueLabel.text = "Pick Server"//.localiz()
        nextButton.showOriginalLabel()
    }
    
    @objc func didTapSecureEntry() {
        lightImpactGenerator()
        if !showSecureEntry {
            eyeOffImageView.image = UIImage(named: "eye-off")
            passwordTextField.isSecureTextEntry = true
            showSecureEntry = true
            eyeLottie.play(fromFrame: 0, toFrame: 8, loopMode: .playOnce, completion: nil)
        } else {
            eyeOffImageView.image = UIImage(named: "eye-on")
            passwordTextField.isSecureTextEntry = false
            showSecureEntry = false
            eyeLottie.play(fromFrame: 16, toFrame: 23, loopMode: .playOnce, completion: nil)
        }
    }
    
    @objc func showSuccess() {
        self.checkmarkOneLottie.alpha = 1.0
        self.checkmarkOneLottie.play()
        UIView.animate(withDuration: 0.28) {
            self.connectingLabel.alpha = 0
            self.connectingLottie.alpha = 0
            self.connectingLabel.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
            self.connectingLottie.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
            
        } completion: { (success) in
            self.doneButton.isUserInteractionEnabled = true
            self.checkmarkOneLottie.play()
            UIView.animate(withDuration: 0.35) {
                self.orderPlaced.alpha = 1.0
                self.checkBackOfficeLabel.alpha = 1.0

                self.connectingLottie.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.connectingLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
                self.doneButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
    }
    
    @objc func showConnectingAnimation() {
        self.skipButton.isHidden = true
        self.skipButton.isUserInteractionEnabled = false
        self.nextButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.28) {
            self.detailLabelOne.alpha = 0
            self.usernameEmailContainer.alpha = 0
            self.passwordContainer.alpha = 0
            self.dividerLine.alpha = 0
            self.serverContainer.alpha = 0
            self.nextButton.alpha = 0
            self.skipLabel.alpha = 0
            self.navTitleLabel.alpha = 0
            
            self.detailLabelOne.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
            self.usernameEmailContainer.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
            self.passwordContainer.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
            self.dividerLine.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
            self.serverContainer.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
            self.nextButton.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
            self.skipLabel.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
        } completion: { (success) in
            self.connectingLottie.isHidden = false
            self.connectingLabel.isHidden = false
            self.connectingLottie.play()
            
            UIView.animate(withDuration: 0.28) {
                self.connectingLottie.alpha = 1.0
                self.connectingLabel.alpha = 1.0
                
                self.connectingLottie.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.connectingLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { [weak self] (success) in
                if let s = self {
                    s.submitBrokerDetails()
                }
            }
        }
    }
    
    @objc func goToNextStep() {
        if isFirstStep {
            if accountusernameEmailTextField.text != "" {
                if self.brokers.count > 0 {
                    for broker in brokers {
                        if broker.slice(from: "~", to: "~") == accountusernameEmailTextField.text {
                            ToastNotificationView().present(withMessage: "Name already taken!")
                            accountusernameEmailContainer.badWiggle()
                            errorImpactGenerator()
                            return
                        }
                    }
                }
                                
                isFirstStep = false
                self.nextButton.showNewLabel()
                self.noBrokerButton.isHidden = true
                self.noBrokerButton.isUserInteractionEnabled = false
                UIView.animate(withDuration: 0.28) {
                    self.detailLabelZero.alpha = 0
                    self.accountusernameEmailContainer.alpha = 0
                    self.detailLabelZero.transform = CGAffineTransform(translationX: -50, y: 0)
                    self.accountusernameEmailContainer.transform = CGAffineTransform(translationX: -50, y: 0)
                    self.noBrokerLabel.alpha = 0
                    self.noBrokerLabel.transform = CGAffineTransform(translationX: -50, y: 0)
                } completion: { (success) in
                    self.detailLabelZero.isHidden = true
                    self.accountusernameEmailContainer.isHidden = true
                    self.detailLabelOne.isHidden = false
                    self.usernameEmailContainer.isHidden = false
                    self.passwordContainer.isHidden = false
                    self.dividerLine.isHidden = false
                    self.serverContainer.isHidden = false
                    UIView.animate(withDuration: 0.35) {
                        self.detailLabelOne.alpha = 1.0
                        self.usernameEmailContainer.alpha = 1.0
                        self.passwordContainer.alpha = 1.0
                        self.dividerLine.alpha = 1.0
                        self.serverContainer.alpha = 1.0
                        
                        self.detailLabelOne.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.usernameEmailContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.passwordContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.dividerLine.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.serverContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                }
            } else {
                accountusernameEmailContainer.badWiggle()
                errorImpactGenerator()
            }
        } else {
            if pickServerMode {
                if !didPickBroker {
                    hideBrokersShowServers()
                } else {
                    lightImpactGenerator()
                    pickServerMode = false
                    serverOptionsPickerView.isUserInteractionEnabled = false
                    brokerOptionsPickerView.isUserInteractionEnabled = false
                    mainContainerHeight.constant = .createAspectRatio(value: .createAspectRatio(value: 617))
                    serverTop.constant = .createAspectRatio(value: 16)
                    UIView.animate(withDuration: 0.35) {
                        self.usernameEmailContainer.alpha = 1.0
                        self.passwordContainer.alpha = 1.0
                        self.dividerLine.alpha = 1.0
                        self.serverOptionsPickerView.alpha = 0
                        self.brokerOptionsPickerView.alpha = 0
                        self.view.layoutIfNeeded()
                    } completion: { (success) in
                        
                    }
                    serverusernameEmailTextField.text = selectedBrokerServers[rowSelected]//servers[rowSelected].broker
                    nextButton.showNewLabel()
                }
            } else {
                if passwordTextField.text != "" && usernameEmailTextField.text != "" && serverusernameEmailTextField.text != "" {
                    if let text = usernameEmailTextField.text {
                        if text.contains(" ") {
                            ToastNotificationView().present(withMessage: "Remove spaces from account #!")
                            usernameEmailContainer.badWiggle()
                            errorImpactGenerator()
                            return
                        } else {
                            //Good to go
                        }
                    }
                    
                    if let ptext = passwordTextField.text {
                        if ptext.contains(" ") {
                            ToastNotificationView().present(withMessage: "Remove spaces from password!")
                            passwordContainer.badWiggle()
                            errorImpactGenerator()
                            return
                        } else {
                            //Good to go
                        }
                    }
                    
                    showConnectingAnimation()
                                        
                } else {
                    if passwordTextField.text == "" {
                        passwordContainer.badWiggle()
                    }
                    
                    if usernameEmailTextField.text == "" {
                        usernameEmailContainer.badWiggle()
                    }
                    
                    if serverusernameEmailTextField.text == "" {
                        serverContainer.badWiggle()
                    }
                    
                    errorImpactGenerator()
                }
            }
        }
    }
    
    @objc func animateViewsIn() {
        UIView.animate(withDuration: 0.35) {
            self.accountusernameEmailTextField.becomeFirstResponder()
            self.opacityLayer.alpha = 0.75
            self.mainContainer.transform = CGAffineTransform(translationX: 0, y: 0)
            self.keyLine.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc func dimissVC() {
        UIView.animate(withDuration: 0.28) {
            self.mainScrollView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.opacityLayer.alpha = 0
            self.view.endEditing(true)
        } completion: { (success) in
            self.dismiss(animated: false)
            if self.cantConnect {
                self.delegate?.cantConnectBroker()
            }
        }
    }
    
    func submitBrokerDetails() {
        print("\(usernameEmailTextField.text) 🥶 \(passwordTextField.text) 🥶 \(accountusernameEmailTextField.text) 🥶 \(serverusernameEmailTextField.text) 🥶")
        guard let login = usernameEmailTextField.text, let password = passwordTextField.text, let name = accountusernameEmailTextField.text, let server = serverusernameEmailTextField.text else {
            print("missing fields 👕👕👕 000")
            return
        }
        
        API.sharedInstance.submitMTBrokerDetails(details: ConnectBrokerRequest(login: login, password: password, name: name, server: server, platform: "mt4", magic: 0)) { success, error in
            guard error == nil else {
                print("👕👕👕 \(error!) 👕👕👕 111")
                
                DispatchQueue.main.async { [weak self] in
                    ToastNotificationView().present(withMessage: "Error connecting account!")
                    self?.errorImpactGenerator()
                    self?.cantConnect = true
                    self?.dimissVC()
                }
                
                return
            }
            
            guard success else {
                print("error submitting broker details 👕👕👕 222")
                
                DispatchQueue.main.async { [weak self] in
                    ToastNotificationView().present(withMessage: "Error connecting account!")
                    self?.errorImpactGenerator()
                    self?.cantConnect = true
                    self?.dimissVC()
                }
                
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("success 👕👕👕 \(login) 🥶 \(password) 🥶 \(name) 🥶 \(server) 👕👕👕")
                NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil, userInfo: nil)
                self?.delegate?.didAddBrokerAccount()
                self?.perform(#selector(self?.showSuccess), with: self, afterDelay: 1.5)
            }
        }
    }
    
    func submitAutopilotBrokerDetails() {
        /*
        print("\(usernameEmailTextField.text) 🥶 \(passwordTextField.text) 🥶 \(accountusernameEmailTextField.text) 🥶 \(serverusernameEmailTextField.text) 🥶")
        guard let login = usernameEmailTextField.text, let password = passwordTextField.text, let name = accountusernameEmailTextField.text, let server = serverusernameEmailTextField.text else {
            print("missing fields 👕👕👕 000")
            return
        }
        
        API.sharedInstance.submitAutotraderBrokerDetails(details: AutotradeCreateAccountRequest(login: login, password: password, name: name, server: server, platform: "mt4", magic: 0, trailingStopLoss: 0.0)) { success, error in
            guard error == nil else {
                print("👕👕👕 \(error!) 👕👕👕 111")
                
                DispatchQueue.main.async { [weak self] in
                    ToastNotificationView().present(withMessage: "Error connecting account!")
                    self?.errorImpactGenerator()
                    self?.cantConnect = true
                    self?.dimissVC()
                }
                
                return
            }
            
            guard success else {
                print("error submitting broker details 👕👕👕 222")
                
                DispatchQueue.main.async { [weak self] in
                    ToastNotificationView().present(withMessage: "Error connecting account!")
                    self?.errorImpactGenerator()
                    self?.cantConnect = true
                    self?.dimissVC()
                }
                
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                print("success 👕👕👕 \(login) 🥶 \(password) 🥶 \(name) 🥶 \(server) 👕👕👕")
                NotificationCenter.default.post(name: NSNotification.Name("refresh"), object: nil, userInfo: nil)
                self?.delegate?.didAddBrokerAccount()
                self?.perform(#selector(self?.showSuccess), with: self, afterDelay: 1.5)
            }
        }
        */
    }
    
    @objc func noBrokerClicked() {
        lightImpactGenerator()
        /*
        let pickBrokerVC = PickBrokerViewController()
        self.present(pickBrokerVC, animated: true)
        
        
        //ForexVox
        //https://client.forexvox.com/live_signup
        
        //Tradeview
        //https://www.tradeviewforex.com/accounts/open-trading
        */
    }
}

//MARK: SCROLLVIEW DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension ConnectBrokerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 3 {
            let yOffset = scrollView.contentOffset.y
            if yOffset > -44 {
                scrollView.setContentOffset(CGPoint(x: 0, y: -44), animated: false)
            }
            
            if yOffset < -85 {
                if !isDismissing {
                    dimissVC()
                    isDismissing = true
                }
            }
        }
                
    }
}

//MARK: TEXTFIELD DELEGATE ------------------------------------------------------------------------------------------------------------------------------------

extension ConnectBrokerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag != 3 {
            mainContainerHeight.constant = .createAspectRatio(value: 617 + 110)
            UIView.animate(withDuration: 0.35) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 4 {
            if let tfThree = textField.text {
                accountName = tfThree
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 3 {
            accountName = textField.text ?? "Nada"
            let checkBackOfficeLabelText = "You have connected your broker and your \(accountName) account has been created!"
            checkBackOfficeLabel.setupLineHeight(myText: checkBackOfficeLabelText, myLineSpacing: 4)
            checkBackOfficeLabel.textAlignment = .center
            self.view.endEditing(true)
        } else {
            if textField.tag == 1 {
                passwordTextField.becomeFirstResponder()
            } else if textField.tag == 2 || textField.tag == 4 {
                self.view.endEditing(true)
                mainContainerHeight.constant = .createAspectRatio(value: 617)
                UIView.animate(withDuration: 0.35) {
                    self.view.layoutIfNeeded()
                }
            } else {
                self.view.endEditing(true)
            }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 3 {
            let strLength = textField.text?.count ?? 0
            let lngthToAdd = string.count
            let lengthCount = strLength + lngthToAdd
            
            accountNameCharacterCountLabel.text = "\(lengthCount)/25"
            
            return lengthCount <= 24
        } else {
            return true
        }
    }
}

//MARK: PICKER DELEGATE & DATASOURCE ------------------------------------------------------------------------------------------------------------------------------------

extension ConnectBrokerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return servers.count
            //return 1
        } else {
            return selectedBrokerServers.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            //return servers[row].broker
            return "Test 123"
        } else {
            return selectedBrokerServers[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView.tag == 1 {
            //return NSAttributedString(string: servers[row].broker, attributes: [NSAttributedString.Key.foregroundColor: varBlackColor])
            return NSAttributedString(string: "server", attributes: [NSAttributedString.Key.foregroundColor: varBlackColor])
        } else {
            return NSAttributedString(string: selectedBrokerServers[row], attributes: [NSAttributedString.Key.foregroundColor: varBlackColor])
        }
                
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return view.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            rowSelected = row
        } else {
            rowSelected = row
        }
    }
    
    @objc func hideBrokersShowServers() {
        didPickBroker = true
        UIView.animate(withDuration: 0.35) {
            self.availableBrokersTableView.alpha = 0
        } completion: { (success) in
            UIView.animate(withDuration: 0.35) {
                self.brokerServersTableView.alpha = 1.0
            } completion: { (success) in
                self.brokerServersTableView.isUserInteractionEnabled = true
            }
        }
    }
}

//MARK: TABLEVIEW DELEGATE & DATASOURCE ------------------------------------------------------------------------------------------------------------------------------------

extension ConnectBrokerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return servers.count
            //return 1
        } else {
            return selectedBrokerServers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: connectBrokerTableViewCell, for: indexPath) as! ConnectBrokerTableViewCell
        
        if tableView.tag == 1 {
            cell.brokerLabel.text = servers[indexPath.row].broker
            cell.brokerHealth.isHidden = true
            cell.arrowImageView.isHidden = false
        } else {
            cell.brokerHealth.isHidden = false
            cell.arrowImageView.isHidden = true
            
            cell.brokerLabel.text = selectedBrokerServers[indexPath.row]
            
            /*
            if let serverStatus = servers[indexPath.row].isServerConnected(server: selectedBrokerServers[indexPath.row]) {
                if serverStatus {
                    cell.brokerHealth.backgroundColor = .liveGreen
                } else {
                    cell.brokerHealth.backgroundColor = .liveDataRed
                }
            } else {
                cell.brokerHealth.backgroundColor = UIColor(red: 255/255, green: 245/255, blue: 0/255, alpha: 1.0)
            }
            */
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .createAspectRatio(value: 56)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lightImpactGenerator()
        if tableView.tag == 1 {
            selectedBrokerServers.removeAll()
            selectedBrokerServers = servers[indexPath.row].servers
            brokerServersTableView.reloadData()
            hideBrokersShowServers()
        } else {
            serverusernameEmailTextField.text = selectedBrokerServers[indexPath.row]
            print("\(selectedBrokerServers[rowSelected]) 🤢🤢🤢 \(indexPath.row)")
            pickServerMode = false
            mainContainerHeight.constant = .createAspectRatio(value: .createAspectRatio(value: 617))
            serverTop.constant = .createAspectRatio(value: 16)
            brokersTableContainer.isUserInteractionEnabled = false
            brokerServersTableView.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.35) {
                self.brokersTableContainer.alpha = 0
                self.usernameEmailContainer.alpha = 1.0
                self.passwordContainer.alpha = 1.0
                self.dividerLine.alpha = 1.0
                self.serverOptionsPickerView.alpha = 0
                self.brokerOptionsPickerView.alpha = 0
                self.view.layoutIfNeeded()
            } completion: { (success) in
                self.brokerServersTableView.alpha = 0
                self.availableBrokersTableView.alpha = 1.0
            }
            nextButton.showNewLabel()
        }
        
    }
}
