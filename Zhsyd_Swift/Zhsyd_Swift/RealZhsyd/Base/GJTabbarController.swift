//
//  GJTabbarController.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/3.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit
import TYAlertController

class GJTabbarController: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addChildController(ChildController: MainViewController(), Title: "首页", DefaultImage: UIImage(named:"tab_home_normal")!, SelectedImage: UIImage(named:"tab_home_selected")!)
        self.addChildController(ChildController: InvestViewController(), Title: "出借", DefaultImage: UIImage(named:"tab_product_normal")!, SelectedImage: UIImage(named:"tab_product_selected")!)
        self.addChildController(ChildController: MineViewController(), Title: "我的账户", DefaultImage: UIImage(named:"tab_account_normal")!, SelectedImage: UIImage(named:"tab_account_selected")!)
        
        self.delegate = self
        self.tabBar.backgroundImage = GJUtil.createImageFrom(Color: UIColor.white)
    }
    
    func addChildController(ChildController child:UIViewController, Title title:String, DefaultImage defaultImage:UIImage, SelectedImage selectedImage:UIImage){
        child.tabBarItem = UITabBarItem(title: title, image: defaultImage.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        child.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:TABBAR_TINT_COLOR], for: .selected)
        
        let nav = GJNavigationController(rootViewController: child)
        self.addChildViewController(nav)
        
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.title == "我的账户" {
            if !((GJUtil.GET_USER_DEFAULTS(Key: "userID") as! String).isEmpty) && !((GJUtil.GET_USER_DEFAULTS(Key: "oauth_token") as! String).isEmpty) && !((GJUtil.GET_USER_DEFAULTS(Key: "refresh_token") as! String).isEmpty) && !((GJUtil.GET_USER_DEFAULTS(Key: "isLogin") as! String).isEmpty) {
                return true
            }else{
                
                let alert:TYAlertView = TYAlertView(title: "系统提示", message: "您还没有登录,请登录!")
                alert.buttonDefaultBgColor = TINT_COLOR
                alert.add(TYAlertAction(title: "取消", style: .default, handler: { (action) in
                }))
                alert.add(TYAlertAction(title: "确定", style: .default, handler: { (action) in
                    let loginVC  = LoginViewController()
                    loginVC.hidesBottomBarWhenPushed = true
                    let nav = tabBarController.selectedViewController as! UINavigationController
                    nav.pushViewController(loginVC, animated: true)
                }))
                alert.show(in: self, preferredStyle: .alert)
                
                return false
            }
        }else{
            return true
        }
    }
}
