//
//  CANCEL.swift
//  Hitch
//
//  Created by Oliver Lau on 8/12/17.
//  Copyright © 2017 geek. All rights reserved.
//

import UIKit

@IBDesignable
class CANCEL: UIButton {
    
    private func myInit() {
        self.setImage(UI.imageOfCancel(), for: .normal)
        self.setImage(UI.imageOfCancelPressed(), for: .focused)
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
        UI.drawCancel(frame: self.bounds, resizing: .center)
    }
}
