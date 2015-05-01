//
//  TableViewCell.swift
//  Hedef.im
//
//  Created by Emre YILMAZ on 1.05.2015.
//  Copyright (c) 2015 AybarsCengaver. All rights reserved.
//

import UIKit
import QuartzCore

protocol TableViewCellDelegate{
    func toDoItemDeleted(todoItem: ToDoItem) 
}

class TableViewCell: UITableViewCell {

    let gradientLayer = CAGradientLayer()
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    var createOnDragRelease = false
    var delegate: TableViewCellDelegate?
    var toDoItem: ToDoItem? {
        didSet {
            label.text = toDoItem!.text
            label.strikeThrough = toDoItem!.completed
            itemCompleteLayer.hidden = !label.strikeThrough
        }
    }
    let label: StrikeThroughText
    var itemCompleteLayer = CALayer()
    var tickLabel: UILabel, crossLabel: UILabel
    required init(coder aDecoder: NSCoder){
        fatalError("NSCoding not supported")
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer){
        if recognizer.state == .Began {
            originalCenter = center
        }
        
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            center = CGPointMake(originalCenter.x + translation.x , originalCenter.y)
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
            createOnDragRelease = frame.origin.x > frame.size.width / 2.0
        }
        
        if recognizer.state == .Ended {
            
            let originalFrame = CGRect(x: 0, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height)
            if !deleteOnDragRelease {
                UIView.animateWithDuration(0.2, animations: {
                    self.frame = originalFrame
                })
            }
            if deleteOnDragRelease {
                if delegate != nil && toDoItem != nil {
                    delegate!.toDoItemDeleted(toDoItem!)
                }
            }
            if createOnDragRelease {
                if  toDoItem != nil {
                    toDoItem!.completed = true
                }
                label.strikeThrough = true
                itemCompleteLayer.hidden = false
                UIView.animateWithDuration(0.2, animations: { self.frame = originalFrame})
            }else{
                UIView.animateWithDuration(0.2, animations: { self.frame = originalFrame})
            }
        }
    }
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer{
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        func createCueLabel() -> UILabel{
            let label = UILabel(frame: CGRect.nullRect)
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.boldSystemFontOfSize(32.0)
            label.backgroundColor = UIColor.clearColor()
            return label
        }
        
        label = StrikeThroughText(frame: CGRect.nullRect)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(16)
        label.backgroundColor = UIColor.clearColor()
        
        tickLabel = createCueLabel()
        tickLabel.text = "\u{2713}"
        tickLabel.textAlignment = .Right
        
        crossLabel = createCueLabel()
        crossLabel.text = "\u{2717}"
        crossLabel.textAlignment = .Left
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        selectionStyle = .None
        addSubview(tickLabel)
        addSubview(crossLabel)
        itemCompleteLayer = CALayer(layer: layer)
        itemCompleteLayer.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0).CGColor
        itemCompleteLayer.hidden = true
        layer.insertSublayer(itemCompleteLayer, atIndex: 0)
        var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
        
        gradientLayer.frame=bounds
        let color1 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
        let color2 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
        let color3 = UIColor.clearColor().CGColor as CGColorRef
        let color4 = UIColor(white: 0.0, alpha: 0.1).CGColor as CGColorRef
        
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0,0.01,0.95,1.0]
        layer.insertSublayer(gradientLayer,atIndex: 0)
    }
    let kLabelLeftMargin: CGFloat = 15.0
    let kUICuesMargin: CGFloat = 10.0
    let kUICuesWidth: CGFloat = 50.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        itemCompleteLayer.frame = bounds
        label.frame = CGRect(x: kLabelLeftMargin, y: 0, width: bounds.size.width, height: bounds.size.height)
        let cueAlpha = fabs(frame.origin.x) / (frame.size.width / 2)
        tickLabel.alpha = cueAlpha
        crossLabel.alpha = cueAlpha
        tickLabel.textColor = createOnDragRelease ? UIColor.greenColor() : UIColor.whiteColor()
        crossLabel.textColor = deleteOnDragRelease ? UIColor.redColor() : UIColor.whiteColor()
    }

}
