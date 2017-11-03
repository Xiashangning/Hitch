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
                let viewHeight = Int((EventTableCell.cellWidth-16)/i.size.width*i.size.height)
                photoHeight.constant = CGFloat(viewHeight)
                eventPhoto.frame = CGRect(x: eventPhoto.frame.origin.x, y: eventPhoto.frame.origin.y, width: EventTableCell.cellWidth-16, height: photoHeight.constant)
                if eventPhoto.image != nil,let tableView = self.superview as? UITableView {
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                        self.eventPhoto.image = i
                        tableView.beginUpdates()
                        tableView.endUpdates()
                    }, completion: nil)
                }else{
                    eventPhoto.image = i
                }
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
    static var cellWidth: CGFloat!
    
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
        print("1")
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
