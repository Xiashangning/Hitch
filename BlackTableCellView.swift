//
//  BlackTableCellView.swift
//  Hitch
//
//  Created by ios11 on 2017/8/13.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

@IBDesignable
class BlackTableCellView: UIView {

    override func draw(_ rect: CGRect) {
        UI.drawWindowLight2(frame: rect, resizing: .center)
    }

}
