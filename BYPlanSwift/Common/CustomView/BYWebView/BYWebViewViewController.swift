//
//  KMWebViewViewController.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/6/11.
//  Copyright © 2020 hd. All rights reserved.
//

import WebKit

class KMWebViewViewController: BaseViewController {
    
    static func webViewController(urlString: String) -> KMWebViewViewController {
        let vc = KMWebViewViewController()
        vc.urlString = urlString
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(webView)
        guard let url = URL.init(string: urlString) else { return }
        let request = URLRequest.init(url: url)
        webView.load(request)
    }
    
    // MARK: - ---- Property
    var urlString: String = ""
    lazy var webView : WKWebView = {
        let v = WKWebView.init(frame: self.view.bounds)
        return v
    }()
}
