//
//  InvestViewController.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/3.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class InvestViewController: GJBaseViewController, UIScrollViewDelegate{

    var myScrollView = UIScrollView()
    var gjSegment:GJSegment?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigation(Title: "出借")
        
        addSegment()
        addChildViewController()
    }

    func addSegment(){
        gjSegment = GJSegment(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:40))
        gjSegment?.titleArray = ["个人专区","企业专区"]
        gjSegment?.buttonClickEvent = {
            (index) -> Void in
            var point = self.myScrollView.contentOffset
            point.x = SCREEN_WIDTH * CGFloat(index)
            UIView.animate(withDuration: 0.3, animations: {
                self.myScrollView.contentOffset = point
            })
        }
        self.view.addSubview(gjSegment!)
    }

    func addChildViewController(){
        //个人
        let vc_person = InvestListViewController()
        vc_person.isPerson = true
        self.addChildViewController(vc_person)
        
        //企业
        let vc_company = InvestListViewController()
        vc_company.isPerson = false
        self.addChildViewController(vc_company)
        
        addScrollView()
    }
    
    func addScrollView(){
        let scrollView = UIScrollView.init(frame: CGRect(x:0, y:40, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y - TABBAR_HEIGHT - 40))
        scrollView.bounces = false
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView.contentOffset = CGPoint(x:0, y:0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.delegate = self
        for i in 0..<self.childViewControllers.count {
            let vc = self.childViewControllers[i] as UIViewController
            vc.view.frame = CGRect(x:CGFloat(i) * SCREEN_WIDTH, y:0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y - TABBAR_HEIGHT - 40)
            scrollView.addSubview(vc.view)
        }
        scrollView.contentSize = CGSize(width:2 * SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y - TABBAR_HEIGHT - 40)
        myScrollView = scrollView
        self.view.addSubview(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let index = offsetX / SCREEN_WIDTH + 1
        gjSegment?.changeButtonAndLineStatus(Int(index))
    }
    
}
