//
//  EventTableCell.swift
//  Hitch
//
//  Created by ios11 on 2017/10/22.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit
import FoldingCell
import ChainableAnimations
import IBAnimatable
import ChameleonFramework

class EventTableCell: FoldingCell {
    
    var photo: UIImage?{
        get{
            return eventPhoto.image
        }
        set{
            if var i = newValue{
                let viewHeight = Int(i.size.height*(EventTableCell.cellWidth-16)/i.size.width)
                photoHeight.constant = CGFloat(viewHeight)
                i = i.imageScaled(to: CGSize(width: EventTableCell.cellWidth-16, height: CGFloat(viewHeight)))
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
    
    @IBOutlet weak var eventPhoto: AnimatableImageView!
    
    @IBOutlet weak var regist: ImageButton!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var _rView: UIView!
    @IBOutlet weak var bigUserPhoto: UIImageView!
    @IBOutlet weak var userNameDetail: UILabel!
    @IBOutlet weak var welcomingLabel: UILabel!
    @IBOutlet weak var attendButton: ImageButton!
    @IBOutlet weak var notice: UITextView!
    
    var registingView: UIView!
    var detailView: AnimatableView!
    let closeButton = ImageButton(type: .custom)
    var effectView: UIView!
    
    override func commonInit() {
        super.commonInit()
        eventPhoto.layer.masksToBounds = true
        foregroundView.layer.masksToBounds = true
        containerView.layer.masksToBounds = true
        registingView = _rView
        _rView.removeFromSuperview()
        let viewWidth = EventTableCell.cellWidth - 16
        let viewHeight = 40 + viewWidth * 0.8 + registingView.frame.height
        detailView = AnimatableView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        detailView.layer.cornerRadius = 10
        detailView.layer.masksToBounds = true
        notice.text = notice.text.replacingOccurrences(of: "\\n", with: "\n")
        let map = UIView(frame: CGRect(x: 0, y: 40, width: viewWidth, height: viewWidth * 0.8))
        map.backgroundColor = .flatBlack()
        detailView.addSubview(map)
        registingView.frame = CGRect(x: 0, y: 40 + viewWidth * 0.8, width: viewWidth, height: registingView.frame.height)
        let newTop = NSLayoutConstraint(item: registingView, attribute: .leading, relatedBy: .equal, toItem: detailView, attribute: .leading, multiplier: 1, constant: 0)
        let newLeft = NSLayoutConstraint(item: registingView, attribute: .trailing, relatedBy: .equal, toItem: detailView, attribute: .trailing, multiplier: 1, constant: 0)
        let newRight = NSLayoutConstraint(item: registingView, attribute: .top, relatedBy: .equal, toItem: detailView, attribute: .top, multiplier: 1, constant: 40 + viewWidth * 0.8)
        detailView.addSubview(registingView)
        detailView.addConstraints([newTop, newLeft, newRight])
        registingView.updateConstraints()
        detailView.layer.shadowColor = UIColor.flatGray().cgColor
        detailView.layer.shadowOffset = CGSize(width: 4, height: 4)
        detailView.layer.shadowRadius = 10
        detailView.layer.shadowOpacity = 0.6
    }
    
    @IBAction func wouldLikeRegist(_ sender: Any) {
        let ev = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        let rootView = (self.superview?.superview?.superview)!
        ev.frame = rootView.frame
        rootView.addSubview(ev)
        let view = ev.contentView
        effectView = ev
        let photoFrame = eventPhoto.convert(eventPhoto.bounds, to: view)
        let titleView = AnimatableView(frame: photoFrame)
        let color = self.themeColor.darken(byPercentage: 0.1)
        titleView.backgroundColor = color
        titleView.alpha = 0
        titleView.layer.masksToBounds = true
        titleView.cornerRadius = 10
        titleView.cornerSides = [.topLeft,.topRight]
        let photoView = UIImageView(image: eventPhoto.image)
        photoView.frame = photoFrame
        photoView.contentMode = .scaleToFill
        photoView.layer.masksToBounds = true
        view.addSubview(photoView)
        view.addSubview(titleView)

        let restFrame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height - containerView.viewWithTag(3)!.frame.height)
        let restView = UIImageView(image: containerView.pb_takeSnapshot(restFrame))
        restView.frame = containerView.convert(restFrame, to: view)
        restView.contentMode = .top
        restView.layer.masksToBounds = true
        view.addSubview(restView)
        let animatedView = self.animationItemViews?.last?.subviews.first(where: { (view) -> Bool in
            if case _ as UIImageView = view{
                return true
            }else{
                return false
            }
        }) as! UIImageView
        let buttonView = AnimatableImageView(image: animatedView.image)
        buttonView.frame = animatedView.convert(animatedView.frame, to: view)
        buttonView.cornerRadius = 10
        buttonView.cornerSides = [.bottomLeft,.bottomRight]
        buttonView.contentMode = .top
        buttonView.layer.masksToBounds = true
        view.addSubview(buttonView)
        
        let t = UILabel()
        t.text = self.title.text
        t.textColor = title.textColor
        t.font = title.font.withSize(17)
        t.alpha = 0
        t.sizeToFit()
        titleView.addSubview(t)
        t.center = CGPoint(x: titleView.center.x,y: 20)
        
        let viewWidth = EventTableCell.cellWidth - 16
        let viewHeight = 40 + viewWidth * 0.8 + registingView.frame.height
        self.eventPhoto.isHidden = true
        self.containerView.isHidden = true
        self.superview?.bringSubview(toFront: self)
        let destinationY = photoView.frame.origin.y + 40
        detailView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        detailView.center = view.center
        detailView.alpha = 1
        view.addSubview(detailView)
        let upperHeight = CGFloat(destinationY) - detailView.frame.origin.y - 40
        let upperView = UIImageView(image: detailView.pb_takeSnapshot(CGRect(x: 0, y: 40, width: viewWidth, height: upperHeight)))
        upperView.contentMode = .bottom
        upperView.frame = CGRect(x: detailView.frame.origin.x, y: CGFloat(destinationY), width: viewWidth, height: 0)
        upperView.layer.masksToBounds = true
        let lowerView = UIImageView(image: detailView.pb_takeSnapshot(CGRect(x: 0, y: upperHeight + 40, width: viewWidth, height: viewHeight - upperHeight - 40)))
        lowerView.contentMode = .top
        lowerView.frame = CGRect(x: detailView.frame.origin.x, y: CGFloat(destinationY), width: viewWidth, height: 0)
        lowerView.layer.masksToBounds = true
        detailView.alpha = 0
        view.addSubview(upperView)
        view.addSubview(lowerView)
        if UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: false).cgColor.components![0] == 1 {
            //white
            closeButton.normal = UIImage(named: "Button-Light")
            closeButton.select = UIImage(named: "Button-Light-Pressed")
        }else{
            closeButton.normal = UIImage(named: "Button-Dark")
            closeButton.select = UIImage(named: "Button-Dark-Pressed")
        }
        closeButton.contentMode = .scaleAspectFit
        closeButton.frame = CGRect(x: viewWidth + 1, y: 5, width: 30, height: 30)
        titleView.addSubview(closeButton)
        
        //start animate
        //image part
        ChainableAnimator(view: titleView).move(height: 8).anchor(.top).easeOutCubic.thenAfter(t: 0.4).make(alpha: 1).make(height: 40).easeInCubic.thenAfter(t: 0.8).preAnimationBlock {
            ChainableAnimator(view: upperView).make(height: upperHeight).anchor(.bottom).easeOutQuint.animate(t: 0.8)
            }.make(y: detailView.frame.origin.y).easeOutQuint.animate(t: 0.8)
        ChainableAnimator(view: photoView).move(height: 16).anchor(.top).easeOutCubic.thenAfter(t: 0.4).make(height: 40).easeInCubic.animate(t: 0.8) {
            photoView.isHidden = true
            photoView.removeFromSuperview()
        }
        ChainableAnimator(view: t).make(alpha: 1).easeInExpo.delay(t: 0.4).animate(t: 0.8)
        ChainableAnimator(view: closeButton).make(x: viewWidth - 35).spring.wait(t: 1.4).animate(t: 0.6)
        //view part
        ChainableAnimator(view: restView).move(y: 8).easeOutCubic.thenAfter(t: 0.4).make(y: destinationY).make(height: 1).anchor(.top).easeInCubic.animate(t: 0.8){
            restView.isHidden = true
            restView.removeFromSuperview()
        }
        ChainableAnimator(view: buttonView).move(y: 8).easeOutCubic.thenAfter(t: 0.4).make(y: destinationY).move(height: -20).anchor(.top).easeInCubic.thenAfter(t: 0.8).preAnimationBlock {
            ChainableAnimator(view: lowerView).make(height: viewHeight - upperHeight - 40).anchor(.top).easeOutQuint.animate(t: 0.8)
            }.make(y: detailView.frame.maxY - 35).easeOutQuint.thenAfter(t: 0.8).wait(t: 0.1).animate(t: 0){
                titleView.removeFromSuperview()
                titleView.frame.origin = CGPoint(x: 0, y: 0)
                self.detailView.addSubview(titleView)
                buttonView.removeFromSuperview()
                self.detailView.alpha = 1
                upperView.removeFromSuperview()
                lowerView.removeFromSuperview()
                view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.close)))
                self.closeButton.addTarget(self, action: #selector(self.close(_:)), for: .touchUpInside)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.26]
        return durations[itemIndex]
    }
    
    @objc
    func close(_ sender: Any){
        if case let gesture as UITapGestureRecognizer = sender{
            if detailView.point(inside: gesture.location(in: detailView), with: nil){
                return
            }
        }
        self.eventPhoto.isHidden = false
        self.containerView.isHidden = false
        ChainableAnimator(view: detailView).make(scale: 0.4).make(alpha: 0).animate(t: 0.5)
        ChainableAnimator(view: effectView).make(alpha: 0).animate(t: 0.5){
            self.effectView.removeFromSuperview()
        }
    }

}
