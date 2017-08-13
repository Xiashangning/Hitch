//
//  TakeATour.swift
//  Hitch
//
//  Created by Oliver Lau on 8/12/17.
//  Copyright © 2017 geek. All rights reserved.
//

import UIKit

@IBDesignable
class TakeATour: UIButton {
    
    private func myInit() {
        self.setImage(UI.imageOfTAKEATOUR(), for: .normal)
        self.setImage(UI.imageOfTAKEATOURPressed(), for: .focused)
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
        UI.drawTAKEATOUR(frame: self.bounds, resizing: .center)
    }
}
