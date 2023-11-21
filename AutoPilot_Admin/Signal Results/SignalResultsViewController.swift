//
//  SignalResultsViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 11/7/23.
//

import UIKit

class SignalResultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    func getResults() {
        API.sharedInstance.getTradeResults { success, trades, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let trades = trades else {
                print("error getting trade results")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                
            }
        }
    }

}
