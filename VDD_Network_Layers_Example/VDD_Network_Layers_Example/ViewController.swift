//
//  ViewController.swift
//  VDD_Network_Layers_Example
//
//  Created by vinhdd on 3/22/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LoginAPI(id: "bibi@gmail.com", password: "qwerty").execute().then(in: .main, { response in
            
        }).catch(in: .main, { error in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

