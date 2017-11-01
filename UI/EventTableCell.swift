//
//  EventTableCell.swift
//  Hitch
//
//  Created by ios11 on 2017/10/22.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit
import FoldingCell

class EventTableCell: FoldingCell {
    
    var photo: UIImage?{
        get{
            return eventPhoto.image
        }
        set{
            if let i = newValue{
                let viewHieght = eventPhoto.frame.width/i.size.width*i.size.height
                let offest = Int(viewHieght -  eventPhoto.frame.height)
                photoHeight.constant += CGFloat(offest)
                eventPhoto.frame = CGRect(x: eventPhoto.frame.origin.x, y: eventPhoto.frame.origin.y, width: eventPhoto.frame.width, height: photoHeight.constant)
                eventPhoto.image = i
            }
        }
    }
    var closedHeight: CGFloat{
        get{
            return closedEventHeight.constant + photoHeight.constant + 16
        }
    }
    var openHeight: CGFloat{
        get{
            return openEventHeight.constant + photoHeight.constant + 16
        }
    }
    var event: Event!
    
    @IBOutlet weak var closedEventHeight: NSLayoutConstraint!
    @IBOutlet weak var openEventHeight: NSLayoutConstraint!
    @IBOutlet weak var photoHeight: NSLayoutConstraint!
    
    @IBOutlet weak var dateClosed: UILabel!
    @IBOutlet weak var timeClosed: UILabel!
    @IBOutlet weak var statusClosed: UILabel!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var detail: UITextView!
    
    @IBOutlet weak var dateOpen: UILabel!
    @IBOutlet weak var timeOpen: UILabel!
    @IBOutlet weak var statusOpen: UILabel!
    
    @IBOutlet weak var eventKind: UILabel!
    @IBOutlet weak var attendNumber: UILabel!
    @IBOutlet weak var sponsor: UIImageView!
    
    @IBOutlet weak var eventPhoto: UIImageView!
    
    @IBOutlet weak var regist: LargeButton!
    @IBOutlet weak var address: UILabel!
    
    override func commonInit() {
        super.commonInit()
    }
    
    @IBAction func wouldLikeRegist(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            
        }) { (flag) in
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.26]
        return durations[itemIndex]
    }

}
