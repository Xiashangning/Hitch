//
//  HitchManager.swift
//  Hitch
//
//  Created by ios11 on 2017/10/14.
//  Copyright © 2017年 geek. All rights reserved.
//

import Foundation

typealias Result = (result: Bool, description: String)

class HitchManager{
    var user: User!
    //按照距离user位置远近
    var events: [Event]!
    static let manager:HitchManager = HitchManager()
    private init(){
    }
    
}
