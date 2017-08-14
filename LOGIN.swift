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
        self.setImage(UI.imageOfLOGIN(frame: self.bounds, resizing: .aspectFill, scale: 0.85), for: .normal)
        self.setImage(UI.imageOfLOGINPressed(frame: self.bounds, resizing: .aspectFill, scale: 0.85), for: .focused)
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
//        UI.drawLOGIN(frame: self.bounds * 0.85, resizing: .aspectFill)
    }
}
