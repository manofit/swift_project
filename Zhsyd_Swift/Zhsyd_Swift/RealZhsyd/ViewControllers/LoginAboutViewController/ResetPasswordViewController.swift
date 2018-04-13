//
//  ResetPasswordViewController.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/9.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class ResetPasswordViewController: GJBaseViewController, UITextFieldDelegate{

    var session_id = ""
    var phoneNum = ""
    var whichController = ""
    
    var passwordTF:UITextField?
    var passwordAgainTF:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        setNavigation(Title: "重置密码")
        
        createUI()
    }
    
    func createUI(){
        passwordTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:20, width:SCREEN_WIDTH - 30, height:30), BoardStyle: .none, PlaceHolder: "密码由8~16位字母和数字组成", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: true)
        passwordTF?.delegate = self
        self.view.addSubview(passwordTF!)
        
        let line_1 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(passwordTF?.frame.maxY)! + 5, width:SCREEN_WIDTH - 30, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_1)
        
        passwordAgainTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:line_1.frame.maxY + 20, width:SCREEN_WIDTH - 30, height:30), BoardStyle: .none, PlaceHolder: "请再次输入登录密码", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: true)
        passwordAgainTF?.delegate = self
        self.view.addSubview(passwordAgainTF!)
        
        let line_2 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(passwordAgainTF?.frame.maxY)! + 5, width:SCREEN_WIDTH - 30, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_2)
        
        let commitBtn = GJUtil.createButtonWith(Type: .custom, Title: "完成", Frame: CGRect(x:15, y:line_2.frame.maxY + 40, width:SCREEN_WIDTH - 30, height:50), TitleColor: UIColor.white, Font: 20, BackgroundColor: TINT_COLOR, Target: self, Action: #selector(commitBtnAction), TextAligtment: .center)
        commitBtn.layer.cornerRadius = 5;
        commitBtn.layer.shadowOffset =  CGSize(width:0, height:5);
        commitBtn.layer.shadowOpacity = 0.5;
        commitBtn.layer.shadowColor =  TINT_COLOR.cgColor;
        self.view.addSubview(commitBtn)
    }

    @objc func commitBtnAction(){
        if (passwordAgainTF?.text?.count)! < 8 || (passwordAgainTF?.text?.count)! > 16 || GJUtil.isHaveNumAndLetter(String: (passwordAgainTF?.text)!) != 3 {
            SVProgressHUD.showError(withStatus: "密码由8~16位字母和数字组成!")
        }else if passwordTF?.text != passwordAgainTF?.text{
            SVProgressHUD.showError(withStatus: "请输入相同的密码!")
        }else{
            SVProgressHUD.show()
            GJNetWorkTool.tool.changePasswordWith(PhoneNum: phoneNum, Password: (passwordAgainTF?.text)!, Session_id: session_id, Handler: { (result) in
                SVProgressHUD.dismiss()
                if result.res_code == "1" {
                    let alert:TYAlertView = TYAlertView(title: "系统提示", message: "设置成功!")
                    alert.buttonDefaultBgColor = TINT_COLOR
                    alert.add(TYAlertAction(title: "确定", style: .default, handler: { (action) in
                        if self.whichController == "login" {
                            var target:UIViewController? = nil
                            for vc in (self.navigationController?.viewControllers)! {
                                if vc is LoginViewController {
                                    target = vc
                                }
                            }
                            if target != nil {
                                self.navigationController?.popToViewController(target!, animated: true)
                            }
                        }else{
                            self.navigationController?.popViewController(animated: true)
                        }
                    }))
                    alert.show(in: self, preferredStyle: .alert)
                }
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordAgainTF?.resignFirstResponder()
        passwordTF?.resignFirstResponder()
    }

}
