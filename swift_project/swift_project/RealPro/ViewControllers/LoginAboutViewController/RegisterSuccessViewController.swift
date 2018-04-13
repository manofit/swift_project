//
//  RegisterSuccessViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/9.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class RegisterSuccessViewController: GJBaseViewController {
    
    var userName = ""
    var password = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem().barButtonItemWith(Target: nil, Action: nil, NormalImage: nil, HighLightedImage: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        setNavigation(Title: "注册成功")
        
        let imageView = GJUtil.createImageViewWith(Frame: CGRect(x:(SCREEN_WIDTH-142)/2, y:40, width:142, height:135), ImageName: "注册成功(1)", CornarRadius: 0.0)
        self.view.addSubview(imageView)
        
        let label = GJUtil.createLabelWith(Text: "注册成功", Frame: CGRect(x:15, y:imageView.frame.maxY + 10, width:SCREEN_WIDTH-30, height:30), TextColor: LABEL_TEXT_COLOR, Font: 16.0, TextAligtment: .center)
        self.view.addSubview(label)
        
        let sureBtn = GJUtil.createButtonWith(Type: .custom, Title: "确定", Frame: CGRect(x:15, y:label.frame.maxY + 50, width:SCREEN_WIDTH-30, height:50), TitleColor: UIColor.white, Font: 20, BackgroundColor: TINT_COLOR, Target: self, Action: #selector(sureBtnAction), TextAligtment: .center)
        sureBtn.layer.cornerRadius = 5
        sureBtn.layer.shadowOffset = CGSize(width:0, height:5)
        sureBtn.layer.shadowOpacity = 0.5
        sureBtn.layer.shadowColor = TINT_COLOR.cgColor
        self.view.addSubview(sureBtn)
        
    }
    
    @objc func sureBtnAction(){
        GJNetWorkTool.tool.loginWith(MobileNum: userName, Password: password) { (result) in
            
        }
    }


}
