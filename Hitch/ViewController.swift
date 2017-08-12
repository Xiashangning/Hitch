//
//  ViewController.swift
//  Hitch
//
//  Created by ios11 on 2017/7/19.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MAMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AMapServices.shared().apiKey = "8e66eff3b2c3569745b18d667680a7f2"
        let map = MAMapView(frame: self.view.bounds)
        map.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

