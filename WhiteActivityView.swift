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
        UI.drawWindowLight(frame: rect, resizing: .center)
    }

}
