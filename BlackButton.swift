//
//  BlackButton.swift
//  Hitch
//
//  Created by ios11 on 2017/7/21.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

@IBDesignable
class BlackButton: UIButton {

    private func myInit() {
        self.setImage(UIKit.imageOfButtonBlack(), for: .normal)
        self.setImage(UIKit.imageOfButtonBlackPressed(), for: .focused)
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        self.myInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.myInit()
    }
    
    override func draw(_ rect: CGRect) {
        UIKit.drawButtonBlack(frame: self.bounds, resizing: .center)
    }
}
