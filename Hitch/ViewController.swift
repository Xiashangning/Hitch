//
//  ViewController.swift
//  Hitch
//
//  Created by ios11 on 2017/7/19.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MAMapViewDelegate,AMapSearchDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mode: UIButton!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var mapview: UIView!
    @IBOutlet weak var photo: UIButton!
    private var map: MAMapView!
    private var searchAPI: AMapSearchAPI!
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.setImage(HitchManager.manager.user.photo, for: .normal)
        AMapServices.shared().apiKey = "8e66eff3b2c3569745b18d667680a7f2"
        map = MyMapView(frame: self.mapview.bounds)
        map.delegate = self
        mapview.addSubview(map)
        mode.setImage(UIImage(named: "mostviewed_2x"), for: .selected)
        mode.isSelected = false
        searchAPI = AMapSearchAPI()
        searchAPI.delegate = self
    }

    @IBAction func touchBackground(_ sender: Any) {
        searchBar.resignFirstResponder()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        map.zoomLevel = 14
    }
    @IBAction func changeMode(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation{
            let request = AMapReGeocodeSearchRequest()
            request.location = AMapGeoPoint.location(withLatitude: CGFloat(map.userLocation.location.coordinate.latitude), longitude: CGFloat(map.userLocation.location.coordinate.longitude))
            request.requireExtension = true
            searchAPI.aMapReGoecodeSearch(request)
        }
    }
    
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        if response.regeocode != nil{
            let address = response.regeocode.addressComponent!
            self.location.text = address.city + address.district
            print("1")
        }
    }
}

