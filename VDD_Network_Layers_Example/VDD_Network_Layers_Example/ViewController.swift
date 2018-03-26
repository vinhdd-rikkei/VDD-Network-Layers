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
        
        LoginAPI(id: "bibi@gmail.com", password: "qwerty").execute().then(in: .main, { output, apiError in
            // Get error responded from api data
            if let error = apiError {
                print(error.text ?? "")
            }
            // Get response data from api
            output?.printInfo()
        }).catch(in: .main, { error in
            // Get error while requesting api
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
}

