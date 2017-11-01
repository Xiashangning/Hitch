

//
//  EventTimeView.swift
//  Hitch
//
//  Created by ios11 on 2017/10/30.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit
import FoldingCell

class EventTimeView: RotatedView {
    
    var percentage: CGFloat = 0.0
    var pastColor: UIColor?
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        pastColor?.setFill()
        context.fill(CGRect(x: 0, y: 0, width: self.frame.width * percentage, height: self.frame.height))
    }

}
