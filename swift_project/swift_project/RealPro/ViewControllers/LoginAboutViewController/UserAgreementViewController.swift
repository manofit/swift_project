//
//  UserAgreementViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/9.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class UserAgreementViewController: GJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavigation(Title: "用户服务协议")
        
        let webView = UIWebView.init(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y))
        self.view.addSubview(webView)
        
        let url = Bundle.main.url(forResource: "UserAgreement", withExtension: "html")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
        
    }


}
