//
//  ForgetPasswordViewController.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/9.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: GJBaseViewController {

    var phoneNumTF:UITextField?
    var picCodeTF:UITextField?
    var smsCodeTF:UITextField?
    
    var picCodeBtn:UIButton?
    var smsCodeBtn:UIButton?
    
    var captchaToken = ""
    var second = 60
    var timer:Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        second = 60
        
        photoCodeChoose()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        setNavigation(Title: "忘记密码")
        
        createUI()
        
    }
    
    func createUI(){
        phoneNumTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:20, width:SCREEN_WIDTH - 30, height:30), BoardStyle: .none, PlaceHolder: "请输入手机号", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: false)
        self.view.addSubview(phoneNumTF!)
        
        let line_1 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(phoneNumTF?.frame.maxY)! + 5, width:SCREEN_WIDTH - 30, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_1)
        
        picCodeTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:line_1.frame.maxY + 20, width:SCREEN_WIDTH - 145, height:30), BoardStyle: .none, PlaceHolder: "请输入图片验证码", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: false)
        self.view.addSubview(picCodeTF!)
        
        let line_2 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(picCodeTF?.frame.maxY)! + 5, width:SCREEN_WIDTH - 145, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_2)
        
        picCodeBtn = GJUtil.createButtonWith(Type: .custom, Title: nil, Frame: CGRect(x:SCREEN_WIDTH - 115, y:line_2.frame.maxY - 47, width:100, height:44), TitleColor: nil, Font: nil, BackgroundColor: UIColor.clear, Target: self, Action: #selector(photoCodeChoose), TextAligtment: nil)
        picCodeBtn?.setImage(UIImage(named:"yanzhengma"), for: .normal)
        self.view.addSubview(picCodeBtn!)
        
        smsCodeTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:line_2.frame.maxY + 20, width:SCREEN_WIDTH - 145, height:30), BoardStyle: .none, PlaceHolder: "请输入短信验证码", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: false)
        self.view.addSubview(smsCodeTF!)
        
        let line_3 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(smsCodeTF?.frame.maxY)! + 5, width:SCREEN_WIDTH - 145, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_3)
        
        smsCodeBtn = GJUtil.createButtonWith(Type: .custom, Title: "获取验证码", Frame: CGRect(x:SCREEN_WIDTH - 115, y:line_3.frame.maxY - 47, width:100, height:44), TitleColor: UIColor.white, Font: 14.0, BackgroundColor: UIColor(red: 27.0/255, green: 166.0/255, blue: 228.0/255, alpha: 1.0), Target: self, Action: #selector(smsCodeChoose), TextAligtment: .center)
        self.view.addSubview(smsCodeBtn!)
        
        let commitBtn = GJUtil.createButtonWith(Type: .custom, Title: "下一步", Frame: CGRect(x:15, y:line_3.frame.maxY + 50, width:SCREEN_WIDTH - 30, height:50), TitleColor: UIColor.white, Font: 20, BackgroundColor: TINT_COLOR, Target: self, Action: #selector(commitBtnAction), TextAligtment: .center)
        commitBtn.layer.cornerRadius = 5;
        commitBtn.layer.shadowOffset =  CGSize(width:0, height:5);
        commitBtn.layer.shadowOpacity = 0.5;
        commitBtn.layer.shadowColor =  TINT_COLOR.cgColor;
        self.view.addSubview(commitBtn)
    }
    
    @objc func photoCodeChoose(){
        GJNetWorkTool.tool.getRegisterPicCode { (string, data) in
            self.captchaToken = string
            
            self.picCodeBtn?.setImage(UIImage(data: data), for: .normal)
        }
        
    }
    
    @objc func smsCodeChoose(){
        if (phoneNumTF?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "手机号码不能为空")
        }else if (picCodeTF?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "图片验证码不能为空")
        }else if !GJUtil.isValid(MobilePhone: (phoneNumTF?.text)!) {
            SVProgressHUD.showError(withStatus: "手机号码格式不正确")
        }else{
            guard second < 60 else {
                let dic  = ["phone":phoneNumTF?.text, "captchaToken":captchaToken, "captcha":picCodeTF?.text]
                GJNetWorkTool.tool.codeType = .forgetPass
                GJNetWorkTool.tool.getSmsCodeWith(Dic: dic as! Dictionary<String, String>, Handler: { (result) in
                    if result.res_code == "1" {
                        self.addTimer()
                    }else{
                        self.photoCodeChoose()
                    }
                })
                
                return
            }
        }
    }

    @objc func commitBtnAction(){
        if (smsCodeTF?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "短信验证码不能为空")
        }else{
            SVProgressHUD.show()
            GJNetWorkTool.tool.checkMobilePhoneWhenForgetPassword(PhoneNum: (phoneNumTF?.text)!, SmsCode: (smsCodeTF?.text)!, Handler: { (result) in
                SVProgressHUD.dismiss()
                if result.res_code == "1"{
                    let vc = ResetPasswordViewController()
                    vc.session_id = result.res_data!["session_id"] as! String
                    vc.phoneNum = (self.phoneNumTF?.text)!
                    vc.whichController = "login"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
        }
    }
    
    func addTimer(){
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    @objc func countTime(){
        second  = second - 1
        if second > 0 {
            smsCodeBtn?.setTitle("\(second)", for: .normal)
        }else{
            removeTimer()
            smsCodeBtn?.setTitle("获取验证码", for: .normal)
            second = 60
        }
    }
    
    func removeTimer(){
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
}
