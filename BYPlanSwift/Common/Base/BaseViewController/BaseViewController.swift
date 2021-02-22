//
//  BaseViewController.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/5/13.
//  Copyright © 2020 kystar. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .rgbColor(245, 245, 245)
        if self.navigationController?.children.count ?? 0 > 1 {
            let back = UIButton.init(type: .custom)
            back.setImage(R.image.icon_back(), for: .normal)
            back.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
            back.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
            back.contentHorizontalAlignment = .left
            back.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: -8, bottom: 0, right: 0)
            back.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: back)
        }
        
    }
    
    @objc private func backAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
