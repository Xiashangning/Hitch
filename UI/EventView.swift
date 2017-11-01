//
//  MyMapView.swift
//  Hitch
//
//  Created by ios11 on 2017/10/17.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit
import FoldingCell
import ChameleonFramework

class EventView: UIView,MAMapViewDelegate,AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var events:[Event]!
    var cellHeights:[CGFloat]!
    var map: MAMapView!
    var list: UITableView!
    var delegate: EventViewDelegate?
    
    private var searchAPI: AMapSearchAPI!
    
    @IBInspectable
    var apiKey: String!{
        get{
            return AMapServices.shared().apiKey
        }
        set{
            AMapServices.shared().apiKey = newValue
        }
    }
    
    func myinit(){
        events = []
        let e = Event()
        events.append(e)
        events.append(e)
        events.append(e)
        events.append(e)
        events.append(e)
        events.append(e)
        cellHeights = Array(repeating: -1,count: events.count)
        
        self.map = MAMapView(frame: self.bounds)
        map.delegate = self
        searchAPI = AMapSearchAPI()
        searchAPI.delegate = self
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        map.zoomLevel = 14
        
//        self.addSubview(map)
        
        self.list = UITableView(frame: self.bounds, style: .plain)
        list.dataSource = self
        list.register(UINib(nibName: "EventTableCell", bundle: nil), forCellReuseIdentifier: "eventCell")
        list.delegate = self
        list.tableFooterView = UIView()
        list.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
//        list.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleHeight.rawValue | UIViewAutoresizing.flexibleWidth.rawValue)
//        list.backgroundView = map
        
        self.addSubview(list)
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
            self.delegate?.eventView?(self, updateLocation: response.regeocode.addressComponent!)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as EventTableCell = cell else {
            return
        }
        cell.backgroundColor = .clear
        initCell(cell,row :indexPath.row, allContents: true)
        
        if cellHeights[indexPath.row] == cell.openHeight {
            cell.unfold(true, animated: false)
        } else {
            cell.unfold(false, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as EventTableCell = cell else {
            return
        }
        //取消绑定
        cell.event.cell = nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if cellHeights[indexPath.row] == -1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventTableCell
            initCell(cell, row: indexPath.row, allContents: false)
            cellHeights[indexPath.row] = cell.closedHeight
        }
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EventTableCell
        
        if cell.isAnimating() {
            return
        }
        var duration = 0.0
        if cellHeights[indexPath.row] == cell.openHeight {
            cellHeights[indexPath.row] = cell.closedHeight
            cell.unfold(false, animated: true)
            duration = 0.8
        } else {
            cellHeights[indexPath.row] = cell.openHeight
            cell.unfold(true, animated: true)
            duration = 0.5
        }
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    
    private func initCell(_ cell: EventTableCell, row: Int, allContents: Bool){
        cell.event = events[row]
        cell.event.cell = cell
        let rate = self.bounds.width / cell.frame.width
        cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: self.bounds.width, height: cell.frame.height * rate)
        cell.photo = UIImage(named: "defaultBg.png")
        
        if !allContents{
            return
        }
        //边框
        let top = UIBezierPath(roundedRect: cell.eventPhoto.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: 10, height: 10))
        let lt = CAShapeLayer()
        lt.frame = cell.eventPhoto.bounds
        lt.path = top.cgPath
        cell.eventPhoto.layer.mask = lt
        
        let bottom = UIBezierPath(roundedRect: cell.foregroundView.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue), cornerRadii: CGSize(width: 10, height: 10))
        let lb = CAShapeLayer()
        lb.frame = cell.foregroundView.bounds
        lb.path = bottom.cgPath
        cell.foregroundView.layer.mask = lb
        
        let bc = UIBezierPath(roundedRect: cell.containerView.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue), cornerRadii: CGSize(width: 10, height: 10))
        let b = CAShapeLayer()
        b.frame = cell.containerView.bounds
        b.path = bc.cgPath
        cell.containerView.layer.mask = b
        
        //颜色
        let themeColor = UIColor(averageColorFrom: cell.photo).flatten()
        cell.foregroundView.backgroundColor = themeColor
        let view = cell.foregroundView as! EventTimeView
        view.percentage = 0.43
        view.pastColor = themeColor?.lighten(byPercentage: 0.2)
    }
}
