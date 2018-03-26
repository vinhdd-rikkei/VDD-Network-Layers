//
//  ViewController.swift
//  VDD_Network_Layers_Example
//
//  Created by vinhdd on 3/22/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Test Login API
        LoginAPI(id: "bibi@gmail.com", password: "qwerty").execute(success: { result in
            // Get response data from api
            result.printInfo()
        }, apiError: { apiError in
            // Get error responded from api data
            print(apiError.text ?? "")
        }, requestError: { error in
            // Get error while requesting api
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
        
        // Test Female List API
        FemaleListAPI(id: "bibi@gmail.com", password: "qwerty").execute(success: { result in
            // Get response data from api
            result.printInfo()
        }, apiError: { apiError in
            // Get error responded from api data
            let alert = UIAlertController(title: "API error", message: apiError.text ?? "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }, requestError: { error in
            // Get error while requesting api
            let alert = UIAlertController(title: "Request error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
}

