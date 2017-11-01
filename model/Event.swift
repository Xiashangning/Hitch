//
//  Event.swift
//  Hitch
//
//  Created by Oliver Lau on 8/12/17.
//  Copyright © 2017 geek. All rights reserved.
//

import UIKit

class Event: NSObject {
    var id:Int!
    var name:String!
    var info:String!
    var createDate: Date!
    var time:Date!
    private var photoCache:UIImage? = nil
    var photo:UIImage!{
        get{
            if let cache = photoCache{
                return cache
            }else{
                //请求图片
                return UIImage(named: "defaultBg.png")
            }
        }
        set{
            photoCache = newValue
            cell?.photo = newValue
        }
    }
    var location:CLLocation!
    var sponser:[User]!
    var participant:[User]!
    var cell: EventTableCell?
}
