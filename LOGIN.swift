//
//  LOGIN.swift
//  Hitch
//
//  Created by Oliver Lau on 8/12/17.
//  Copyright © 2017 geek. All rights reserved.
//


import UIKit

@IBDesignable
class LOGIN: UIButton {
    
    private func myInit() {
        self.setImage(UIKit.imageOfLOGIN(), for: .normal)
        self.setImage(UIKit.imageOfLOGINPressed(), for: .focused)
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
        UIKit.drawLOGIN(frame: self.bounds, resizing: .center)
    }
}
