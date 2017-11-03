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
    var cellStatus:[Bool]!
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
        cellStatus = Array(repeating: false,count: events.count)
        EventTableCell.cellWidth = self.bounds.width
        
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
        
        if cellStatus[indexPath.row] {
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
        if cellStatus[indexPath.row] {
            cellHeights[indexPath.row] = cell.closedHeight
            cellStatus[indexPath.row] = false
            cell.unfold(false, animated: true)
            duration = 0.8
        } else {
            cellHeights[indexPath.row] = cell.openHeight
            cellStatus[indexPath.row] = true
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
        cell.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleHeight.rawValue | UIViewAutoresizing.flexibleWidth.rawValue)
        cell.eventPhoto.image = nil
        cell.photo = cell.event.photo
        
        if !allContents{
            return
        }
//        //边框
//        let top = UIBezierPath(roundedRect: cell.eventPhoto.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: 10, height: 10))
//        let lt = CAShapeLayer()
//        lt.frame = cell.eventPhoto.bounds
//        lt.path = top.cgPath
//        cell.eventPhoto.layer.mask = lt
//
//        let bottom = UIBezierPath(roundedRect: cell.foregroundView.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue), cornerRadii: CGSize(width: 10, height: 10))
//        let lb = CAShapeLayer()
//        lb.frame = cell.foregroundView.bounds
//        lb.path = bottom.cgPath
//        cell.foregroundView.layer.mask = lb
//
//        let bc = UIBezierPath(roundedRect: cell.containerView.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue), cornerRadii: CGSize(width: 10, height: 10))
//        let b = CAShapeLayer()
//        b.frame = cell.containerView.bounds
//        b.path = bc.cgPath
//        cell.containerView.layer.mask = b
        
        cellHeights[row] = cellStatus[row] ? cell.openHeight : cell.closedHeight
        
        //closed
        let themeColor = UIColor(averageColorFrom: cell.photo).flatten()
        cell.foregroundView.backgroundColor = themeColor
        let foreground = cell.foregroundView as! EventTimeView
        foreground.percentage = 0.43
        foreground.pastColor = themeColor?.lighten(byPercentage: 0.2)
        let basicFontColor = UIColor(contrastingBlackOrWhiteColorOn: themeColor, isFlat: true)!
        cell.dateClosed.textColor = basicFontColor
        cell.timeClosed.textColor = basicFontColor
        cell.statusClosed.textColor = basicFontColor
        cell.title.textColor = basicFontColor
        cell.info.textColor = basicFontColor
        
        //open
        var x:CGFloat = 113
        let y:CGFloat = 12
        let userSize:CGFloat = 35
        let userView = cell.containerView.viewWithTag(2)!
        var imageView:UIImageView!
        while x + userSize + 30 <= self.bounds.width{
            imageView = UIImageView(image: UIImage(named: "contacts_2x"))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: x, y: y, width: userSize, height: userSize)
            userView.addSubview(imageView)
            x += userSize + 8
        }
        imageView.image = UIImage(named: "moreUser")
        
        cell.layer.shadowColor = UIColor.flatGray().cgColor
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.6
        
        cell.detail.text = cell.detail.text.replacingOccurrences(of: "\\n", with: "\n")
    }
}
