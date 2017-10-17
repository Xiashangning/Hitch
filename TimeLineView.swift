//
//  TimeLineView.swift
//  Hitch
//
//  Created by ios11 on 2017/10/11.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit

@IBDesignable
class TimeLineView: UIView {

    private let date = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
    private var dateLabel:UILabel! = nil
    private let widthOfDay:CGFloat = 2
    private let heightOfDate:CGFloat = 13
    private let bigHeight:CGFloat = 22
    private let smallHeight:CGFloat = 15
    private func myinit(){
        dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: heightOfDate))
        dateLabel.font = UIFont.systemFont(ofSize: 10)
        dateLabel.textColor = UIColor.darkGray
        dateLabel.textAlignment = .center
        dateLabel.text = String(describing: date.year!)+"年"+String(describing: date.month!)+"月"+String(describing: date.day!)+"日"
        addSubview(dateLabel)
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        myinit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        myinit()
    }
    
    private func drawDay(number: Int, at x: CGFloat, choosed: Bool){
        let height:CGFloat
        let context = UIGraphicsGetCurrentContext()
        let flag = (number - Int(number/7)*7 == 1) || (number == Int(number/7)*7)
        if flag {//周六周日
            height = bigHeight
        }else{
            height = smallHeight
        }
        if choosed{
            UIColor(red: 0, green: 151/255, blue: 1, alpha: 1).setFill()
        }else{
            UIColor.lightGray.setFill()
        }
        context?.fill(CGRect(x: x - widthOfDay/2,
                             y: self.frame.height - height,
                             width: widthOfDay, height: height))
    }
    
    override func draw(_ rect: CGRect) {
        drawDay(number: date.weekday!, at: self.frame.width/2, choosed: true)
        for i in 1 ... Int(self.frame.width/2/widthOfDay/3){
            drawDay(number: date.weekday!, at: self.frame.width/2+CGFloat(3*i)*widthOfDay, choosed: false)
        }
    }

}
