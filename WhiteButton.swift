//
//  WhiteButton.swift
//  Hitch
//
//  Created by ios11 on 2017/7/21.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

@IBDesignable
class WhiteButton: UIButton {
    
    private func myInit() {
        self.setImage(UI.imageOfButtonWhite(), for: .normal)
        self.setImage(UI.imageOfButtonWhitePressed(), for: .focused)
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
        UI.drawButtonWhite(frame: self.bounds, resizing: .center)
    }
}
