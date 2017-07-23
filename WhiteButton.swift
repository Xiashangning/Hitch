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

    override init(frame:CGRect){
        super.init(frame: frame)
        self.setImage(SelfDesignedUI.imageOfButtonBlack(), for: .normal)
        self.setImage(SelfDesignedUI.imageOfButtonBlackPressed(), for: .focused)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
