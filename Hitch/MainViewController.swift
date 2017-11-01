//
//  ViewController.swift
//  Hitch
//
//  Created by ios11 on 2017/7/19.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, EventViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mode: UIButton!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var eventView: EventView!
    @IBOutlet weak var photo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.setImage(HitchManager.manager.user.photo, for: .normal)
        eventView.delegate = self
        mode.setImage(UIImage(named: "mostviewed_2x"), for: .selected)
        mode.isSelected = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventView.myinit()
    }

    @IBAction func touchBackground(_ sender: Any) {
        searchBar.resignFirstResponder()
    }
    @IBAction func changeMode(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func eventView(_ eventView: EventView, updateLocation loc: AMapAddressComponent) {
        self.location.text = loc.city + loc.district
    }
}

