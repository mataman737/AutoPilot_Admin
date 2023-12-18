//
//  SignalResultsViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 11/7/23.
//

import UIKit

class SignalResultsViewController: UIViewController {
    
    var results = [SignalResult]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    func getResults() {
        API.sharedInstance.getSignalResults { success, results, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard success, let results = results else {
                print("error getting signal results")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.results = results
            }
        }
    }

}
