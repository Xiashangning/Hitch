//
//  TimeLineView.swift
//  Hitch
//
//  Created by ios11 on 2017/8/14.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

@IBDesignable
class TimeLineView: UIView {
    
    override func draw(_ rect: CGRect) {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.locations = [0,0.1,1]
        l.colors = [UIColor.clear, UIColor.blue, UIColor.clear]
        self.layer.addSublayer(l)
    }

}
