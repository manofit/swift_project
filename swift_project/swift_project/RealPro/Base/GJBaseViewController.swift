//
//  GJBaseViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/3.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class GJBaseViewController: UIViewController {

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = MAIN_WHITE_COLOR
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 232.0/255, green: 55.0/255, blue: 64.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:""), for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.shadowImage = GJUtil.createImageFrom(Color: UIColor.clear)
    }

    func setNavigation(Title title:String){
        self.navigationItem.title = title
    }
    
}
