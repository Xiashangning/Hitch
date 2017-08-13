//
//  ViewController.swift
//  Hitch
//
//  Created by ios11 on 2017/7/19.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MAMapViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mode: UIButton!
    @IBOutlet weak var profile: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nibhello
        AMapServices.shared().apiKey = "8e66eff3b2c3569745b18d667680a7f2"
        let map = MAMapView(frame: mainView.bounds)
        map.delegate = self
        mainView.addSubview(map)
        mode.setImage(UIImage(named: "map_2x"), for: .normal)
        mode.setImage(UIImage(named: "mostviewed_2x"), for: .selected)
        mode.isSelected = false
        profile.setImage(UIImage(named: "contacts_2x"), for: .normal)
    }

    @IBAction func changeMode(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

