//
//  Register.swift
//  Hitch
//
//  Created by Oliver Lau on 8/12/17.
//  Copyright © 2017 geek. All rights reserved.
//

import UIKit

@IBDesignable
class Register: UIButton {
    
    private func myInit() {
        self.setImage(UIKit.imageOfRegister2(), for: .normal)
        self.setImage(UIKit.imageOfRegisterPressed(), for: .focused)
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
        UIKit.drawRegister2(frame: self.bounds, resizing: .center)
    }
}

