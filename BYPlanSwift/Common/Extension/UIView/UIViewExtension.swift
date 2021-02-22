//
//  UIViewExtension.swift
//  KommanderTouPing
//
//  Created by Kystar's Mac Book Pro on 2020/3/13.
//  Copyright © 2020 kystar. All rights reserved.
//

import UIKit

extension UIView {
    func setRoundCorners(corner:UIRectCorner, cornerRadii size:CGSize) {
        self.setRoundCorners(corner:corner, cornerRadii:size,frame:self.bounds)
    }

    func setRoundCorners(corner:UIRectCorner, cornerRadii size:CGSize, frame:CGRect) {
        let maskPath : UIBezierPath = UIBezierPath.init(roundedRect: frame, byRoundingCorners: corner, cornerRadii: size)
        let maskLayer : CAShapeLayer = CAShapeLayer.init()
        maskLayer.frame = frame;
        maskLayer.path = maskPath.cgPath;
        self.layer.mask=maskLayer
    }
}

extension UIView {
    
    // MARK: - ---- size / frame
    var x: CGFloat{
        get {frame.origin.x}
        set {
            frame.origin.x = newValue
        }
    }
    
    var y: CGFloat{
        get {frame.origin.y}
        set {
            frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {frame.size.width}
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {frame.size.height}
        set {
            frame.size.height = newValue
        }
    }
    
    var size: CGSize{
        get {frame.size}
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    var origin: CGPoint{
        get {frame.origin}
        set {
            x = newValue.x
            y = newValue.y
        }
    }
    
    var centerX: CGFloat{
        get {center.x}
        set {
            center = CGPoint.init(x: newValue, y: centerY)
        }
    }
    
    var centerY: CGFloat {
        get {center.y}
        set {
            center = CGPoint.init(x:centerX, y:newValue)
        }
    }

    var left: CGFloat{
        get {frame.origin.x}
        set {
            x = newValue
        }
    }

    var top: CGFloat{
        get{frame.origin.y}
        set {
            y = newValue
        }
    }

    var bottom: CGFloat{
        get{frame.size.height + frame.origin.y}
        set {
            y = newValue - height
        }
    }

    var right: CGFloat{
        get{frame.size.width + frame.origin.x}
        set {
            x = newValue - width
        }
    }

    // MARK: - ---- Refer to other views
    func fillSuperView(){
        if let sv = superview {
            frame = sv.bounds
        }
    }
    
    func setBoundsEqual(view : UIView){
        bounds = view.bounds
    }
    
    func setFrameEqual(view : UIView){
        frame = view.frame
    }

    func setSizeEqual(view: UIView){
        width = view.width
        height = view.height
    }

    func setLeftEqual(view: UIView, offset: CGFloat? = 0) {
        x = view.x - (offset ?? 0)
    }
    
    func setRightEqual(view: UIView, offset: CGFloat? = 0) {
        x = view.right - width - (offset ?? 0)
    }
    
    func setTopEqual(view: UIView, offset: CGFloat? = 0) {
        y = view.y - (offset ?? 0)
    }
    
    func setBottomeEqual(view: UIView, offset: CGFloat? = 0) {
        y = view.bottom - height - (offset ?? 0)
    }
}

