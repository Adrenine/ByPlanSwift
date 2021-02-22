//
//  BYProgressHUD.swift
//  BYPlanSwift
//
//  Created by Kystar on 2020/5/29.
//  Copyright © 2020 hd. All rights reserved.
//

import Foundation

enum BYProgressHUDTopComponentStyle {
    case None
    case ActivityIndicator
    case StatusIV
}

enum BYProgressHUDSatusStyle {
    case None
    case Success
    case Fail
    case NormalInfo
}

class BYProgressHUD: UIControl {
    private static var hudTargetMapTable: NSMapTable<UIView, BYProgressHUD> = NSMapTable.weakToStrongObjects()
    
    var topComponentStyle: BYProgressHUDTopComponentStyle = .ActivityIndicator
    var statusStyle: BYProgressHUDSatusStyle = .None
    var showInfoLabel: Bool = false
    var stayTimes: Float = 0.0//停留时间，<=0表示一直停留
    var infoStr: String?
    
    
    
    var activityIndicator : UIActivityIndicatorView?
    var statusIV: UIImageView?
    var infoLabel: UILabel?
    lazy var mainContainer : UIView = {
        let tmp = UIView.init()
        tmp.layer.cornerRadius = 5
        tmp.backgroundColor = .black
        return tmp
    }()
    
    //MARK:Class Method
    //MARK:一：ActivityIndicator
    ///加载指示器+info标签?
    ///参数：1.targetView（UIView?-HUD的父视图）；2.info?（String?-文本信息）；3.offInteractive（Bool-阻断targetView的交互，默认true）；4.stayTimes（Float-展示停留时间，默认为0）
    class func showActivityIndicatorHUD(_ targetView: UIView? = nil, info: String? = nil, offInteractive: Bool = true, stayTimes: Float = 0.0) {
        showProgressHUD(targetView, info: info, offInteractive: offInteractive, topComponentStyle: .ActivityIndicator, statusStyle: .None, stayTimes: stayTimes)
    }
    
    //MARK:二：StatusIV
    ///成功image + info标签?
    ///参数：1.targetView（UIView?-HUD的父视图）；2.info?（String?-文本信息）；3.offInteractive（Bool-阻断targetView的交互，默认true）；4.stayTimes（Float-展示停留时间，默认为2.0）
    class func showSuccessStatusHUD(_ targetView: UIView? = nil, info: String? = nil, offInteractive: Bool = true, stayTimes: Float = 2.0) {
        showStatusHUD(targetView, info: info, offInteractive: offInteractive, statusStyle: .Success, stayTimes: stayTimes)
    }
    ///失败image + info标签?
    ///参数：1.targetView（UIView?-HUD的父视图）；2.info?（String?-文本信息）；3.offInteractive（Bool-阻断targetView的交互，默认true）；4.stayTimes（Float-展示停留时间，默认为2.0）
    class func showFailStatusHUD(_ targetView: UIView? = nil, info: String? = nil, offInteractive: Bool = true, stayTimes: Float = 2.0) {
        showStatusHUD(targetView, info: info, offInteractive: offInteractive, statusStyle: .Fail, stayTimes: stayTimes)
    }
    ///常规信息image + info标签?
    ///参数：1.targetView（UIView?-HUD的父视图）；2.info?（String?-文本信息）；3.offInteractive（Bool-阻断targetView的交互，默认true）；4.stayTimes（Float-展示停留时间，默认为2.0）
    class func showNormalInfoStatusHUD(_ targetView: UIView? = nil, info: String? = nil, offInteractive: Bool = true, stayTimes: Float = 2.0) {
        showStatusHUD(targetView, info: info, offInteractive: offInteractive, statusStyle: .NormalInfo, stayTimes: stayTimes)
    }
    private class func showStatusHUD(_ targetView: UIView? = nil, info: String? = nil, offInteractive: Bool = true, statusStyle: BYProgressHUDSatusStyle = .Success, stayTimes: Float = 2.0) {
        showProgressHUD(targetView, info: info, offInteractive: offInteractive, topComponentStyle: .StatusIV, statusStyle: statusStyle, stayTimes: stayTimes)
    }
    
    //MARK:三：纯文本标签
    ///纯文本标签
    ///参数：1.targetView（UIView?-HUD的父视图）；2.info（String-文本信息）；3.offInteractive（Bool-阻断targetView的交互，默认false）；4.stayTimes（Float-展示停留时间，默认为2.0）
    class func showSingleTextStatusHUD(_ targetView: UIView? = nil, info: String, offInteractive: Bool = false, stayTimes: Float = 2.0) {
        showProgressHUD(targetView, info: info, offInteractive: offInteractive, topComponentStyle: .None, statusStyle: .None, stayTimes: stayTimes)
    }
    
    private class func showProgressHUD(_ targetView: UIView? = nil, info: String? = nil, offInteractive: Bool = true, topComponentStyle: BYProgressHUDTopComponentStyle = .ActivityIndicator, statusStyle: BYProgressHUDSatusStyle = .None, stayTimes: Float = 2.0) {
        let view = targetView != nil ? targetView! : UIApplication.shared.keyWindow;
        
        hideProgressHUD(view)
        let hud = BYProgressHUD.init(info: info, offInteractive: offInteractive, topComponentStyle: topComponentStyle, statusStyle: statusStyle, stayTimes: stayTimes)
        hud.showInView(view)
        
        mappingHudTargetView(view, hud: hud)
        
    }
    class func hideProgressHUD(_ targetView: UIView? = nil) {
        let view = targetView != nil ? targetView! : UIApplication.shared.keyWindow;
        hideExistHud(view)
    }
    
    private class func hideExistHud(_ targetView: UIView?) {
        let hud = BYProgressHUD.hudTargetMapTable.object(forKey: targetView)
        if let tmp = hud {
            tmp.hide()
            BYProgressHUD.hudTargetMapTable.removeObject(forKey: targetView)
        }
    }
    private class func mappingHudTargetView(_ targetView: UIView?, hud: BYProgressHUD?) {
        if let view = targetView {
            BYProgressHUD.hudTargetMapTable.setObject(hud, forKey: view)
        }
    }
    
    //MARK:------------------------------------boundary--------------------------------------
    //MARK:Instance Method
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    convenience init(info: String? = nil, offInteractive: Bool = true, topComponentStyle: BYProgressHUDTopComponentStyle = .ActivityIndicator, statusStyle: BYProgressHUDSatusStyle = .None, stayTimes: Float = 0.0) {
        self.init(frame: CGRect.zero)
        self.isUserInteractionEnabled = offInteractive
        self.stayTimes = stayTimes
        self.infoStr = info
        self.showInfoLabel = (info != nil)
        self.topComponentStyle = topComponentStyle
        self.statusStyle = statusStyle
        self.p_addSubViews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let heading: CGFloat = 10
        let leading: CGFloat = 15
        let spacingV: CGFloat = -10
        
        let topComponentWH: CGFloat = 60
        let top: CGFloat = heading
        let maxContainerW: CGFloat = UIScreen.main.bounds.width - leading * 2
        var containerW: CGFloat = top + topComponentWH + heading
        var containerH: CGFloat = containerW
        
        if showInfoLabel {
            if let label = infoLabel {
                 let fitedSize = label.sizeThatFits(CGSize.init(width: maxContainerW - leading * 2, height: CGFloat.greatestFiniteMagnitude))
                if fitedSize.width + 2 * leading > containerW {
                    containerW = fitedSize.width + 2 * leading
                }
                if topComponentStyle == .None {
                    label.frame = CGRect.init(x: leading, y: top, width: containerW - 2 * leading, height: fitedSize.height)
                }
                else {
                    label.frame = CGRect.init(x: leading, y: top + topComponentWH + spacingV, width: containerW - 2 * leading, height: fitedSize.height)
                }
                containerH = label.frame.maxY + heading
                if containerH > containerW {
                    containerW = min(containerH, maxContainerW)
                    label.frame.size.width = containerW - leading * 2
                }
            }
           
        }
        
        
        if topComponentStyle == .ActivityIndicator {
            activityIndicator?.frame = CGRect.init(x: (containerW - topComponentWH) / 2, y: top, width: topComponentWH, height: topComponentWH)
        }
        else if topComponentStyle == .StatusIV {
            statusIV?.frame = CGRect.init(x: (containerW - topComponentWH) / 2, y: top, width: topComponentWH, height: topComponentWH)
        }
        
        
        mainContainer.frame  = CGRect.init(x: (self.frame.width - containerW) / 2, y: (self.frame.height - containerH) / 2, width: containerW, height: containerH)
        
    }
    
    
    //MARK:Public Method
    func showInView(_ targetView: UIView? = nil) {
        if let tmpTargetView = targetView {
            self.frame = tmpTargetView.bounds
            tmpTargetView.addSubview(self)
        }
        
        if self.stayTimes > 0 {
            self.perform(#selector(p_hide), with: nil, afterDelay: TimeInterval(self.stayTimes), inModes: [.common])
        }
        
        
    }
    func hide() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(p_hide), object: nil)
        p_hide()
    }
    
    
    //MARK: - Private Method
    private func p_addActivityIndicator() {
        let tmpIndicator = UIActivityIndicatorView.init()
        tmpIndicator.style = .whiteLarge
        tmpIndicator.startAnimating()
        mainContainer.addSubview(tmpIndicator)
        activityIndicator = tmpIndicator
    }
    private func p_addStatusIV() {
        let tmpInfoIV = UIImageView.init()
        tmpInfoIV.contentMode = .center
        tmpInfoIV.tintColor = .white
        switch self.statusStyle {
            case .Success:
                do {
                    tmpInfoIV.image = UIImage.init(named: "success")?.withRenderingMode(.alwaysTemplate)
                }
            case .Fail:
                do {
                   tmpInfoIV.image = UIImage.init(named: "error")?.withRenderingMode(.alwaysTemplate)
                }
            case .NormalInfo:
                do {
                    tmpInfoIV.image = UIImage.init(named: "info")?.withRenderingMode(.alwaysTemplate)
                }
            default:
                 tmpInfoIV.image = UIImage.init(named: "success")?.withRenderingMode(.alwaysTemplate)
                break;
        }
        mainContainer.addSubview(tmpInfoIV)
        statusIV = tmpInfoIV
    }
    private func p_addTopComponent() {
        switch topComponentStyle {
        case .ActivityIndicator:
            do {
                p_addActivityIndicator()
            }
        case .StatusIV:
            do {
               p_addStatusIV()
            }
        default:
            break
        }
    }
    private func p_addInfoLabel(_ info: String?) {
        let tmpInfoLabel = UILabel.init()
        tmpInfoLabel.textColor = .white
        tmpInfoLabel.font = .systemFont(ofSize: 14)
        tmpInfoLabel.backgroundColor = .clear
        tmpInfoLabel.adjustsFontSizeToFitWidth = true
        tmpInfoLabel.textAlignment = .center
        tmpInfoLabel.baselineAdjustment = .alignCenters
        tmpInfoLabel.numberOfLines = 0
        tmpInfoLabel.text = info
        mainContainer.addSubview(tmpInfoLabel)
        infoLabel = tmpInfoLabel
    }
    private func p_addSubViews() {
        addSubview(mainContainer)
        switch self.topComponentStyle {
        case .ActivityIndicator:
            do {
                self.p_addActivityIndicator()
            }
        case .StatusIV:
            do {
                self.p_addStatusIV()
            }
        default:
            break;
        }
        if self.showInfoLabel {
            self.p_addInfoLabel(self.infoStr)
        }
    }
    
    @objc private func p_hide() {
        if let tmp = activityIndicator {
            tmp.stopAnimating()
        }
        self.removeFromSuperview()
    }
    
    
}
