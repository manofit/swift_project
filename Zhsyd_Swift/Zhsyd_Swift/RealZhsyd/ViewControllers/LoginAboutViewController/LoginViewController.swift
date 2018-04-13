//
//  LoginViewController.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/4.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit
import TYAlertController

class LoginViewController: GJBaseViewController, UITextFieldDelegate{

    var mobileTextField:UITextField?
    var passwordTextField:UITextField?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        createUI()
        
    }
    
    func createUI(){
        let cancelBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:20, y:Int(STATUSBAR_HEIGHT) + 5, width:30, height:30), TitleColor: nil, Font: nil, BackgroundColor: UIColor.clear, Target: self, Action: #selector(cancelBtnAction), TextAligtment: nil)
        cancelBtn.setImage(UIImage(named:"closetu"), for: .normal)
        self.view.addSubview(cancelBtn)
        
        let headImageView = GJUtil.createImageViewWith(Frame: CGRect(x:(SCREEN_WIDTH-160)/2, y:100, width:160, height:54), ImageName: "矢量智能对象", CornarRadius: 0.0)
        self.view.addSubview(headImageView)
        
        let mobileImageView = GJUtil.createImageViewWith(Frame: CGRect(x:30, y:headImageView.frame.maxY + 50, width:26, height:26), ImageName: "shouji", CornarRadius: 0.0)
        self.view.addSubview(mobileImageView)
        
        mobileTextField = GJUtil.createTextFieldWith(Frame: CGRect(x:mobileImageView.frame.maxX + 20, y:headImageView.frame.maxY + 42, width:SCREEN_WIDTH - 114, height:45), BoardStyle: .none, PlaceHolder: " 请输入手机号", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: false)
        mobileTextField?.delegate = self
        self.view.addSubview(mobileTextField!)
        
        let line_view_one = GJUtil.createViewWith(Frame: CGRect(x:10, y:(mobileTextField?.frame.maxY)! + 5, width:SCREEN_WIDTH - 20, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_view_one)
        
        let passImageView = GJUtil.createImageViewWith(Frame: CGRect(x:30, y:line_view_one.frame.maxY + 15, width:26, height:26), ImageName: "mimatu", CornarRadius: 0.0)
        self.view.addSubview(passImageView)
        
        passwordTextField = GJUtil.createTextFieldWith(Frame: CGRect(x:passImageView.frame.maxX + 20, y:line_view_one.frame.maxY + 7, width:SCREEN_WIDTH - 114, height:45), BoardStyle: .none, PlaceHolder: " 请输入登录密码", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: true)
        passwordTextField?.delegate = self
        self.view.addSubview(passwordTextField!)
        
        let line_view_two = GJUtil.createViewWith(Frame: CGRect(x:10, y:(passwordTextField?.frame.maxY)! + 5, width:SCREEN_WIDTH - 20, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_view_two)
        
        let loginBtn = GJUtil.createButtonWith(Type: .custom, Title: "登录", Frame: CGRect(x:15, y:line_view_two.frame.maxY + 40, width:SCREEN_WIDTH - 30, height:50), TitleColor: UIColor.white, Font: 20.0, BackgroundColor: TINT_COLOR, Target: self, Action: #selector(login), TextAligtment: .center)
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.shadowOffset = CGSize(width:0, height:5)
        loginBtn.layer.shadowOpacity = 0.5
        loginBtn.layer.shadowColor = TINT_COLOR.cgColor
        self.view.addSubview(loginBtn)
        
        let registerBtn = GJUtil.createButtonWith(Type: .custom, Title: "注册", Frame: CGRect(x:15, y:loginBtn.frame.maxY + 20, width:50, height:30), TitleColor: LABEL_TEXT_COLOR, Font: 15, BackgroundColor: UIColor.clear, Target: self, Action: #selector(pushRegisterVC), TextAligtment: .left)
        self.view.addSubview(registerBtn)
        
        let forgetPasswordBtn = GJUtil.createButtonWith(Type: .custom, Title: "忘记密码?", Frame: CGRect(x:SCREEN_WIDTH-115, y:loginBtn.frame.maxY + 20, width:100, height:30), TitleColor: LABEL_TEXT_COLOR, Font: 15, BackgroundColor: UIColor.clear, Target: self, Action: #selector(pushForgetPasswordVC), TextAligtment: .right)
        self.view.addSubview(forgetPasswordBtn)
    }

    @objc func cancelBtnAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func login(){
        if (mobileTextField?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "请输入账号!")
        }else if (passwordTextField?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "请输入密码!")
        }else {
            SVProgressHUD.show()
            GJNetWorkTool.tool.loginWith(MobileNum: (mobileTextField?.text)!, Password: (passwordTextField?.text)!) { (result) in
                SVProgressHUD.dismiss()
                if result.res_code == "1" {
                    let tabVC = GJTabbarController()
                    UIApplication.shared.keyWindow?.rootViewController = tabVC
                }else{
                    var alertStr = result.mesg
                    if result.mesg == "" {
                        alertStr = "登录失败!"
                    }
                    
                    let alert:TYAlertView = TYAlertView(title: "系统提示", message: alertStr! + ",或者联系客服:400-021-2010")
                    alert.buttonDefaultBgColor = TINT_COLOR
                    alert.add(TYAlertAction(title: "确定", style: .default, handler: { (action) in
                    }))
                    alert.show(in: self, preferredStyle: .alert)
                }
            }
        }
    }
    
    @objc func pushRegisterVC(){
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushForgetPasswordVC(){
        self.navigationController?.pushViewController(ForgetPasswordViewController(), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mobileTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
    }

}
