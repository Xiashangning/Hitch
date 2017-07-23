//
//  WhiteActivityView.swift
//  Hitch
//
//  Created by ios11 on 2017/7/21.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

@IBDesignable
class WhiteActivityView: UIView {

    override func draw(_ rect: CGRect) {
        TestWindowDark.drawCanvas1(frame: rect, resizing: .center)
        //SelfDesignedUI.drawWindowLight(frame: rect, resizing: .center)
    }

}
