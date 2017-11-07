//
//  LargeButton.swift
//  Hitch
//
//  Created by ios11 on 2017/10/10.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

@IBDesignable
class ImageButton: UIButton {
    @IBInspectable
    public var normal:UIImage? = nil{
        didSet{
            self.setBackgroundImage(normal, for: .normal)
        }
    }
    @IBInspectable
    public var select:UIImage? = nil{
        didSet{
            self.setBackgroundImage(select, for: .selected)
        }
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
