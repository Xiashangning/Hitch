//
//  EventViewDelegate.swift
//  Hitch
//
//  Created by ios11 on 2017/10/18.
//  Copyright © 2017年 geek. All rights reserved.
//

import Foundation

@objc
protocol EventViewDelegate {
    @objc optional func eventView(_ eventView: EventView, updateLocation loc: AMapAddressComponent)
}
