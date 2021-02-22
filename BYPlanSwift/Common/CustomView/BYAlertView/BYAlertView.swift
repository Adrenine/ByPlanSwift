//
//  KMAlertView.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/5/28.
//  Copyright © 2020 kystar. All rights reserved.
//

import UIKit

enum KMAlertActionStyle : Int {
    case `default`
    case cancel
    case destructive
}

enum KMAlertViewStyle : Int {
    case info
    case error
    case success
}

typealias KMActionCompleteHandler = (_ action: KMAlertAction) -> ()

class KMAlertAction: NSObject {
    static func action(title: String? = "", style: KMAlertActionStyle, complete: KMActionCompleteHandler? = nil) -> KMAlertAction{
        return KMAlertAction.init(title: title, style: style, complete: complete)
    }
    
    init(title: String? = "", style: KMAlertActionStyle, complete: KMActionCompleteHandler? = nil) {
        self.enabled = true
        self.title = title
        self.style = style
        self.completeHandler = complete
    }

    private(set) var title: String?
    private(set) var style: KMAlertActionStyle
    private(set) var completeHandler: KMActionCompleteHandler?
    var enabled = false
    //该属性有值时，优先使用该属性值作为标题
    var attributeTitle: NSAttributedString?
    var bgColor: UIColor?
    
    func performCurrentAction() {
        if let b = self.completeHandler {
            b(self)
        }
    }
}

class KMAlertView: UIView {
    
    static func alert(title: String?, messageIconName: String? = "", message: String?, actions: [KMAlertAction]?, style: KMAlertViewStyle) -> KMAlertView {
        let alert = KMAlertView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.width(), height: UIScreen.height()))
        alert.set(title: title, message: message, actions: actions, style: style)
        if let array = actions {
            for act in array {
                alert.add(action: act)
            }
        }
        return alert
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .hexColor("0x000000", alpha: 0.3)
        contentViewTop = 195.0 / 667.0 * self.height + 20
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnWidth : CGFloat = 100
        let btnHeight : CGFloat = 36
        let cornerRadius : CGFloat = 4
        let btnDistance : CGFloat = 30
        let topOffset : CGFloat = 30
        let bottomOffset : CGFloat = 30
        let yOffset : CGFloat = (btnHeight + bottomOffset)
        
        contentViewHeight += (btnHeight + topOffset + bottomOffset)
        contentView.height = contentViewHeight
        let btnY = contentView.height - yOffset
        if actionBtnMutArray.count == 1 {
            let btn = actionBtnMutArray.first
            btn?.frame = CGRect.init(x: 0.5 * (contentView.width - btnWidth), y:btnY , width: btnWidth, height: btnHeight)
            btn?.layer.cornerRadius = cornerRadius
        } else if actionBtnMutArray.count == 2 {
            let leftBtn = actionBtnMutArray.first
            leftBtn?.frame = CGRect.init(x: (0.5 * contentView.width - btnWidth - 0.5 * btnDistance), y: btnY, width: btnWidth, height: btnHeight)
            
            let rightBtn = self.actionBtnMutArray.last
            rightBtn?.frame = CGRect.init(x: 0.5*contentView.width+0.5 * btnDistance, y: btnY, width: btnWidth, height: btnHeight)
            leftBtn?.layer.cornerRadius = cornerRadius
            rightBtn?.layer.cornerRadius = cornerRadius
        }
        
    }
    
    private func set(title: String?, message: String?, messageIconName: String? = "", actions: [KMAlertAction]?, style: KMAlertViewStyle) {
        self.preferredStyle = style
        addSubview(contentView)
        let titleTop: CGFloat = 16
        var msgTop = titleTop
        contentViewHeight += titleTop
        if let t = title {
            contentView.addSubview(titleContentView)
            titleContentView.addSubview(titleLabel)
//            titleContentView.addSubview(closeButton)
            titleLabel.text = t
            let size = titleLabel.sizeThatFits(CGSize.init(width: contentView.width - 34, height: CGFloat(MAXFLOAT)))
            let titleHeight = size.height
            titleContentView.frame = CGRect.init(x: 0, y: titleTop, width: contentView.width, height: titleHeight + 20)
            let xOffset : CGFloat = 20
            let yOffset : CGFloat = 20
            titleLabel.frame = CGRect.init(x: xOffset, y: 0, width: contentView.width - 2*xOffset, height: titleHeight + yOffset)
            titleContentView.height = titleLabel.height
//            closeButton.frame = CGRect.init(x: titleContentView.width-12-20, y: 0, width: 20, height: 20)
//            closeButton.centerY = titleContentView.centerY
//            let differH = titleLabel.font.lineHeight - titleLabel.font.pointSize
            msgTop = titleContentView.bottom + 20
            contentViewHeight += titleContentView.height
//            contentViewHeight += differH
        }
        
        if let msg = message {
//            contentView.addSubview(msgImageView)
            contentView.addSubview(msgLabel)
            let differH = msgLabel.font.lineHeight - msgLabel.font.pointSize
            msgTop -= differH * 0.5
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.lineSpacing = 16 //行间距
            let attriString = NSMutableAttributedString.init(string: msg)
            attriString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: msg.count))
            msgLabel.attributedText = attriString
            let width = contentView.width - 28*2
            let size = msgLabel.sizeThatFits(CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
            msgLabel.frame = CGRect.init(x: 28, y: msgTop, width: width, height: size.height)
            contentViewHeight += 20
            contentViewHeight += msgLabel.height
//            contentViewHeight += differH
//            msgImageView.frame = CGRect.init(x: 25, y: msgTop, width: 25, height: 25)
        }
        contentView.height = contentViewHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(action: KMAlertAction) {
        if actionMutArray.count >= 2 {
            return
        }
        
        actionMutArray.append(action)
        let btn = actionButtonWithAction(action: action)
        contentView.addSubview(btn)
        actionBtnMutArray.append(btn)
        if actionBtnMutArray.count == 1 {
            btn.backgroundColor = .hexColor("0x000000")
        } else if actionBtnMutArray.count == 2 {
            btn.backgroundColor = .hexColor("0xc6b250")
        } else {
            
        }
    }

    func show(in view: UIView) {
        view.addSubview(self)
        top = 0
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn], animations: {
            self.contentView.top = self.contentViewTop
        })
    }

    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        top = 0
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn], animations: {
            self.contentView.top = self.contentViewTop
        })
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn], animations: {
            self.contentView.top = self.contentViewTop
        },completion: { finish in
            self.top = UIScreen.height()
            self.removeFromSuperview()
        })
    }
    
    func actionButtonWithAction(action : KMAlertAction) -> UIButton {
        let actionBtn = UIButton()
        actionBtn.layer.cornerRadius = 12
        actionBtn.layer.masksToBounds = true
        if let attri = action.attributeTitle {
            actionBtn.setAttributedTitle(attri, for: .normal)
        } else{
            actionBtn.setTitle(action.title, for: .normal)
            actionBtn.setTitleColor(.white, for: .normal)
            actionBtn.titleLabel?.font = .systemFont(ofSize: 14)
        }
        
        if let color = action.bgColor {
            actionBtn.backgroundColor = color;
        }
        
        actionBtn.tag = actionBtnMutArray.count;
        
        actionBtn.addTarget(self, action:#selector(clickAction(button:)), for:.touchUpInside)
        
        return actionBtn;
    }

    @objc private func clickAction(button: UIButton) {
        let index = button.tag;
        let action = actionMutArray[index];
        action.performCurrentAction()
        hide()
    }
    
    @objc private func closeAction(button: UIButton) {
        hide()
    }
    
    var actions: [KMAlertAction] {
        return [] + actionMutArray
    }
    
    private var contentViewTop: CGFloat = 0

    private var contentViewHeight: CGFloat = 0
    private(set) var preferredStyle: KMAlertViewStyle = .info
    private(set) var actionBtnMutArray: [UIButton] = []
    private(set) var actionMutArray: [KMAlertAction] = []
    
    private lazy var contentView: UIView = {
        let width : CGFloat = 300
        let v = UIView.init(frame: CGRect.init(x: 0.5*(self.width - width), y: self.height, width: width, height: 0))
        v.backgroundColor = .white
        v.layer.borderColor = UIColor.hexColor("0x1b1E2A", alpha: 0.4).cgColor
        v.layer.borderWidth = 0.5
        v.layer.cornerRadius = 4
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var titleContentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 22)
        l.textColor = .black
        l.numberOfLines = 0
        l.backgroundColor = .white
        l.textAlignment = .center
        return l
    }()
    private lazy var closeButton: UIButton = {
        let b = UIButton.init(type: .custom)
        b.setImage(R.image.icon_close_nor(), for: .normal)
        b.setImage(R.image.icon_close_pre(), for: .highlighted)
        b.setImage(R.image.icon_close_hover(), for: .selected)
        
        b.addTarget(self, action: #selector(closeAction(button:)), for: .touchUpInside)
        return b
    }()

    private lazy var msgImageView: UIImageView = {
        
        let v = UIImageView.init(image: R.image.icon_info())
        return v
    }()
    
    private lazy var msgLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .left;
        l.textColor = .rgbColor(51, 51, 51)
        l.font = .systemFont(ofSize: 16)
        l.backgroundColor = .white
        l.numberOfLines = 0
        return l
    }()
}
