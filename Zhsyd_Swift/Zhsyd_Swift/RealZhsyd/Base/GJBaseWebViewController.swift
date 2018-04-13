//
//  GJBaseWebViewController.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/10.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit
import WebKit

class GJBaseWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var webView:WKWebView?
    var link = ""
    var webTitle = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = webTitle
        
        createToolBar()
        createUI()
    }

    func createToolBar(){
        let toolBar  = UIToolbar()
        toolBar.tintColor = TINT_COLOR
        toolBar.backgroundColor = UIColor.white
        
        let h = SCREEN_HEIGHT - TABBAR_HEIGHT
        toolBar.frame = CGRect(x:0, y:h, width:SCREEN_WIDTH, height:TABBAR_HEIGHT)
        self.view.addSubview(toolBar)
        
        let backItem = UIBarButtonItem.init(image: UIImage(named:"BtnImagPreChapterNormal"), style: .plain, target: self, action: #selector(goBack))
        let forwardItem = UIBarButtonItem.init(image: UIImage(named:"BtnImagNextChapterNormal"), style: .plain, target: self, action: #selector(goForward))
        let refreshItem = UIBarButtonItem.init(image: UIImage(named:"chapterRefreshBtn"), style: .plain, target: self, action: #selector(refreash))
        
        toolBar.items = [backItem, forwardItem, refreshItem]
    }
    
    func createUI(){
        webView = WKWebView(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y - TABBAR_HEIGHT))
        self.view.addSubview(webView!)
        
        let url = URL(string: link)
        let request = URLRequest(url: url!)
        webView?.load(request)
    }
    
    @objc func goBack(){
        webView?.goBack()
    }
    
    @objc func goForward(){
        webView?.goForward()
    }
    
    @objc func refreash(){
        webView?.reload()
    }


}
