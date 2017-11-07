//
//  EventTableCell.swift
//  Hitch
//
//  Created by ios11 on 2017/10/22.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit
import FoldingCell
import Spring
import ChainableAnimations

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
                themeColor = UIColor(averageColorFrom: i).flatten()
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
    var themeColor: UIColor!
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
    
    @IBOutlet weak var regist: ImageButton!
    @IBOutlet weak var address: UILabel!
    
    override func commonInit() {
        super.commonInit()
        eventPhoto.layer.masksToBounds = true
        containerView.layer.masksToBounds = true
    }
    
    @IBAction func wouldLikeRegist(_ sender: Any) {
        let titleView = UIView(frame: eventPhoto.frame)
        let color = self.themeColor.darken(byPercentage: 0.1)
        titleView.backgroundColor = color
        titleView.alpha = 0
        let photoView = UIImageView(image: eventPhoto.image)
        photoView.frame = eventPhoto.frame
        photoView.contentMode = .scaleAspectFill
        photoView.layer.masksToBounds = true
        self.contentView.addSubview(photoView)
        self.contentView.addSubview(titleView)

        let restFrame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height - containerView.viewWithTag(3)!.frame.height)
        let restView = UIImageView(image: containerView.pb_takeSnapshot(restFrame))
        restView.frame = containerView.convert(restFrame, to: self.contentView)
        restView.contentMode = .top
        restView.layer.masksToBounds = true
        self.contentView.addSubview(restView)
        let animatedView = self.animationItemViews?.last?.subviews.first(where: { (view) -> Bool in
            if case _ as UIImageView = view{
                return true
            }else{
                return false
            }
        }) as! UIImageView
        let buttonView = UIImageView(image: animatedView.image)
        buttonView.frame = animatedView.convert(animatedView.frame, to: self.contentView)
        buttonView.contentMode = .top
        buttonView.layer.masksToBounds = true
        self.contentView.addSubview(buttonView)
        
        let t = UILabel()
        t.text = self.title.text
        t.textColor = title.textColor
        t.font = title.font.withSize(17)
        t.alpha = 0
        t.sizeToFit()
        titleView.addSubview(t)
        t.center = CGPoint(x: titleView.center.x,y: 20)
        
        //start animate
        self.eventPhoto.isHidden = true
        self.containerView.isHidden = true
        self.foregroundView.isHidden = true
        let destinationY = Float(eventPhoto.frame.origin.y + 40)
        //image part
        ChainableAnimator(view: titleView).move(height: 16).anchor(.top).easeOutCubic.thenAfter(t: 0.4).make(alpha: 1).make(height: 40).anchor(.top).easeInCubic.animate(t: 0.8)
        ChainableAnimator(view: photoView).move(height: 16).anchor(.top).easeOutCubic.thenAfter(t: 0.4).make(height: 40).anchor(.top).easeInCubic.animate(t: 0.8) {
            photoView.removeFromSuperview()
        }
        ChainableAnimator(view: t).make(alpha: 1).easeInExpo.delay(t: 0.4).animate(t: 0.8)
        //view part
        ChainableAnimator(view: restView).move(y: 16).easeOutCubic.thenAfter(t: 0.4).make(y: destinationY).make(height: 0).anchor(.top).easeInCubic.animate(t: 0.8){
            restView.removeFromSuperview()
        }
        ChainableAnimator(view: buttonView).move(y: 16).easeOutCubic.thenAfter(t: 0.4).make(y: destinationY).move(height: -20).anchor(.top).easeInCubic.animate(t: 0.8) {
            
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
