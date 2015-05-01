//
//  StrikeThroughText.swift
//  Hedef.im
//
//  Created by Emre YILMAZ on 1.05.2015.
//  Copyright (c) 2015 AybarsCengaver. All rights reserved.
//

import UIKit
import QuartzCore

class StrikeThroughText: UILabel {
    let strikeThroughLayer: CALayer
    var strikeThrough: Bool {
        didSet {
            strikeThroughLayer.hidden = !strikeThrough
            if strikeThrough {
                resizeStrikeThrough()
            }
        }
    }
    required init(coder aCoder: NSCoder){
        fatalError("NSCoding not supported")
    }
    
    override init(frame: CGRect) {
        strikeThroughLayer = CALayer()
        strikeThroughLayer.backgroundColor = UIColor.whiteColor().CGColor
        strikeThroughLayer.hidden = true
        strikeThrough = false
        
        super.init(frame: frame)
        layer.addSublayer(strikeThroughLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resizeStrikeThrough()
    }
    
    let kStrikeOutThickness: CGFloat = 2.0
    
    func resizeStrikeThrough(){
        let textSize = text!.sizeWithAttributes([NSFontAttributeName:font])
        strikeThroughLayer.frame = CGRect(x: 0, y: bounds.size.height/2, width: textSize.width, height: kStrikeOutThickness)
    }
}
