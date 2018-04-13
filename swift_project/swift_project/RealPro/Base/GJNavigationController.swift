//
//  GJNavigationController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/3.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class GJNavigationController: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem().barButtonItemWith(Target: self, Action: #selector(pressBack), NormalImage: UIImage(named:"")!, HighLightedImage: UIImage(named:"")!)
        }
        
        super.pushViewController(viewController, animated: animated)

    }
    
    @objc func pressBack(){
        self.popViewController(animated: true)
    }
    
}
