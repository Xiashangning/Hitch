//
//  BlackActivityView.swift
//  Hitch
//
//  Created by ios11 on 2017/8/13.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

@IBDesignable
class BlackActivityView: UIView {

    override func draw(_ rect: CGRect) {
        UI.drawWindowDark(frame: rect, resizing: .center)
    }

}
