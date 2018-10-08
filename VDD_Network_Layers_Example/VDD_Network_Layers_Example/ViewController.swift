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
        LoginAPI(id: "", password: "").execute(success: { response in
            
        }, apiError: { apiError in
            
        }, requestError: { requestError in
            
        })
    }
}

