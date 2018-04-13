//
//  InvestDetailContainerViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/13.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class InvestDetailContainerViewController: GJBaseViewController, UIScrollViewDelegate {

    var isPerson = false
    var productType = ""
    var uuid = ""
    var nid = ""
    var pro_title = ""
    
    var myScrollView = UIScrollView()
    var gjSegment:GJSegment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createNavigationBar()
        
        addSegment()
        addChildViewController()
    }
    
    func createNavigationBar(){
        let backView = GJUtil.createViewWith(Frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:STATUS_NAV_BAR_Y), BackgroundColor: UIColor.white)
        self.view.addSubview(backView)
        
        let imageView = GJUtil.createImageViewWith(Frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:STATUS_NAV_BAR_Y), ImageName: "", CornarRadius: 0)
        backView.addSubview(imageView)
        
        let backBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:15, y:STATUSBAR_HEIGHT + 10 ,width:22 ,height:22), TitleColor: nil, Font: nil, BackgroundColor: nil, Target: self, Action: #selector(backBtnAction), TextAligtment: nil)
        backBtn.setImage(UIImage(named:""), for: .normal)
        backView.addSubview(backBtn)
        
        let label = GJUtil.createLabelWith(Text: pro_title, Frame: CGRect(x:40, y:STATUSBAR_HEIGHT + 8, width:SCREEN_WIDTH - 55, height:30), TextColor: UIColor.white, Font: 17, TextAligtment: .center)
        label.lineBreakMode = .byTruncatingTail
        backView.addSubview(label)
    }
    
    @objc func backBtnAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func addSegment(){
        gjSegment = GJSegment(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:40))
        if isPerson {
            gjSegment?.titleArray = ["借款人详情","出借记录"]
        }else{
            gjSegment?.titleArray = ["借款企业详情","企业专区"]
        }
        
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

        if isPerson {
            let vc_person = PersonInvestDetailViewController()
            vc_person.uuid = uuid
            vc_person.productType = productType
            self.addChildViewController(vc_person)
        }else{
            let vc_company = CompanyInvestDetailViewController()
            self.addChildViewController(vc_company)
        }
        
        let vc_history = InvestHistoryViewController()
        self.addChildViewController(vc_history)
        
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
