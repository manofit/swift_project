//
//  RegisterViewController.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/4.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class RegisterViewController: GJBaseViewController, UITextFieldDelegate{
    
    var captchaToken = ""
    var second = 60
    var timer:Timer?
    
    var personUserBtn:UIButton?
    var companyUserBtn:UIButton?
    
    var phoneNumTF:UITextField?
    var passwordTF:UITextField?
    var picSmsTF:UITextField?
    var codeSmsTF:UITextField?
    var inviteCodeTF:UITextField?
    
    var getPicSmsBtn:UIButton?
    var getCodeSmsBtn:UIButton?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        second = 60
        
        getPicSms()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.setNavigation(Title: "注册")
        
        createUI()
    }

    func createUI(){
        personUserBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:15, y:17, width:20, height:20), TitleColor: nil, Font: nil, BackgroundColor: UIColor.clear, Target: self, Action: #selector(personUserBtnAction), TextAligtment: nil)
        personUserBtn?.isSelected = false
        personUserBtn?.setImage(UIImage(named:"未选中"), for: .normal)
        personUserBtn?.setImage(UIImage(named:"选中"), for: .selected)
        self.view.addSubview(personUserBtn!)
        
        let personLabel = GJUtil.createLabelWith(Text: "个人用户", Frame: CGRect(x:(personUserBtn?.frame.maxX)! + 5, y:12, width:70, height:30), TextColor: LABEL_TEXT_COLOR, Font: 17, TextAligtment: .left)
        self.view.addSubview(personLabel)
        
        companyUserBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:SCREEN_WIDTH/2, y:17, width:20, height:20), TitleColor: nil, Font: nil, BackgroundColor: UIColor.clear, Target: self, Action: #selector(companyUserBtnAction), TextAligtment: nil)
        companyUserBtn?.isSelected = false
        companyUserBtn?.setImage(UIImage(named:"未选中"), for: .normal)
        companyUserBtn?.setImage(UIImage(named:"选中"), for: .selected)
        self.view.addSubview(companyUserBtn!)
        
        let companyLabel = GJUtil.createLabelWith(Text: "企业用户", Frame: CGRect(x:(companyUserBtn?.frame.maxX)! + 5, y:12, width:70, height:30), TextColor: LABEL_TEXT_COLOR, Font: 17, TextAligtment: .left)
        self.view.addSubview(companyLabel)
        
        phoneNumTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:(companyUserBtn?.frame.maxY)! + 30, width:SCREEN_WIDTH-30, height:30), BoardStyle: .none, PlaceHolder: "请输入手机号码", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: false)
        phoneNumTF?.delegate = self
        self.view.addSubview(phoneNumTF!)
        
        let line_1 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(phoneNumTF?.frame.maxY)! + 5, width:SCREEN_WIDTH-30, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_1)
        
        passwordTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:line_1.frame.maxY + 20, width:SCREEN_WIDTH - 30, height:30), BoardStyle: .none, PlaceHolder: "密码由8~16位字母和数字组成", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: true)
        passwordTF?.delegate = self
        self.view.addSubview(passwordTF!)
        
        let line_2 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(passwordTF?.frame.maxY)! + 5, width:SCREEN_WIDTH-30, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_2)
        
        picSmsTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:line_2.frame.maxY + 20, width:SCREEN_WIDTH - 145, height:30), BoardStyle: .none, PlaceHolder: "请输入图片验证码", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: false)
        picSmsTF?.delegate = self
        self.view.addSubview(picSmsTF!)
        
        let line_3 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(picSmsTF?.frame.maxY)! + 5, width:SCREEN_WIDTH-145, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_3)
        
        getPicSmsBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:SCREEN_WIDTH - 115, y:line_3.frame.maxY - 47, width:100, height:44), TitleColor: nil, Font: nil, BackgroundColor: UIColor.white, Target: self, Action: #selector(getPicSms), TextAligtment: nil)
        getPicSmsBtn?.setImage(UIImage(named:"yanzhengma"), for: .normal)
        self.view.addSubview(getPicSmsBtn!)
        
        codeSmsTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:line_3.frame.maxY + 20, width:SCREEN_WIDTH - 145, height:30), BoardStyle: .none, PlaceHolder: "请输入短信验证码", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: false)
        codeSmsTF?.delegate = self
        self.view.addSubview(codeSmsTF!)
        
        let line_4 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(codeSmsTF?.frame.maxY)! + 5, width:SCREEN_WIDTH-145, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_4)
        
        getCodeSmsBtn = GJUtil.createButtonWith(Type: .custom, Title: "获取验证码", Frame: CGRect(x:SCREEN_WIDTH - 115, y:line_4.frame.maxY - 47, width:100, height:44), TitleColor: UIColor.white, Font: 14, BackgroundColor: UIColor(red: 27.0/255, green: 166.0/255, blue: 228.0/255, alpha: 1.0), Target: self, Action: #selector(getCodeSms), TextAligtment: .center)
        self.view.addSubview(getCodeSmsBtn!)
        
        inviteCodeTF = GJUtil.createTextFieldWith(Frame: CGRect(x:15, y:line_4.frame.maxY + 20, width:SCREEN_WIDTH - 30, height:30), BoardStyle: .none, PlaceHolder: "请输入邀请码(选填)", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: false)
        inviteCodeTF?.delegate = self
        self.view.addSubview(inviteCodeTF!)
        
        let line_5 = GJUtil.createViewWith(Frame: CGRect(x:15, y:(inviteCodeTF?.frame.maxY)! + 5, width:SCREEN_WIDTH-30, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.view.addSubview(line_5)
        
        let labelBackView = GJUtil.createViewWith(Frame: CGRect(x:(SCREEN_WIDTH-300)/2, y:line_5.frame.maxY + 40, width:300, height:30), BackgroundColor: UIColor.clear)
        self.view.addSubview(labelBackView)
        
        let label_1 = GJUtil.createLabelWith(Text: "注册即视为同意", Frame: CGRect(x:0, y:0, width:110, height:30), TextColor: LABEL_TEXT_COLOR, Font: 15, TextAligtment: .right)
        labelBackView.addSubview(label_1)
        
        let agreementBtn = GJUtil.createButtonWith(Type: .custom, Title: "《服务协议》", Frame: CGRect(x:label_1.frame.maxX, y:0, width:190, height:30), TitleColor: TINT_COLOR, Font: 14, BackgroundColor: UIColor.white, Target: self, Action: #selector(pushAgreementVC), TextAligtment: .left)
        agreementBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        labelBackView.addSubview(agreementBtn)
        
        let commitBtn = GJUtil.createButtonWith(Type: .custom, Title: "完成注册", Frame: CGRect(x:15, y:labelBackView.frame.maxY + 10, width:SCREEN_WIDTH - 30, height:50), TitleColor: UIColor.white, Font: 20, BackgroundColor: TINT_COLOR, Target: self, Action: #selector(commitBtnAction), TextAligtment: .center)
        commitBtn.layer.cornerRadius = 5;
        commitBtn.layer.shadowOffset =  CGSize(width:0, height:5);
        commitBtn.layer.shadowOpacity = 0.5;
        commitBtn.layer.shadowColor =  TINT_COLOR.cgColor;
        self.view.addSubview(commitBtn)
    }
    
    @objc func personUserBtnAction(){
        personUserBtn?.isSelected = true
        companyUserBtn?.isSelected = false
    }
    
    @objc func companyUserBtnAction(){
        personUserBtn?.isSelected = false
        companyUserBtn?.isSelected  = true
    }
    
    @objc func getPicSms(){
        
        GJNetWorkTool.tool.getRegisterPicCode { (string, data) in
            self.captchaToken = string
            
            self.getPicSmsBtn?.setImage(UIImage(data: data), for: .normal)
        }
        
    }
    
    @objc func getCodeSms(){
        if !(personUserBtn?.isSelected)! && !(companyUserBtn?.isSelected)! {
            SVProgressHUD.showError(withStatus: "用户类型不能为空")
            return
        }
        
        if (phoneNumTF?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "手机号码不能为空")
            return
        }
        
        if (passwordTF?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "登录密码不能为空")
            return
        }
        
        if (picSmsTF?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "图片验证码不能为空")
            return
        }
        
        if !(GJUtil.isValid(MobilePhone: (phoneNumTF?.text)!)) {
            SVProgressHUD.showError(withStatus: "手机号码格式不正确")
            return
        }
        
        guard second < 60 else {
            let dic  = ["phone":phoneNumTF?.text, "captchaToken":captchaToken, "captcha":picSmsTF?.text]
            GJNetWorkTool.tool.codeType = .register
            GJNetWorkTool.tool.getSmsCodeWith(Dic: dic as! Dictionary<String, String>, Handler: { (result) in
                if result.res_code == "1" {
                    self.addTimer()
                }else{
                    self.getPicSms()
                }
            })
            
            return
        }
    }
    
    @objc func pushAgreementVC(){
        self.navigationController?.pushViewController(UserAgreementViewController(), animated: true)
    }
    
    @objc func commitBtnAction(){
        if isValidInputs() {
            var type = ""
            if (personUserBtn?.isSelected)! {
                type = "1"
            }else{
                type = "2"
            }
            
            SVProgressHUD.show()
            GJNetWorkTool.tool.registerWith(PhoneNum: (phoneNumTF?.text)!, InvestCode: inviteCodeTF?.text, SmsCode: (codeSmsTF?.text)!, UserType: type, Password: (passwordTF?.text)!, Handler: { (result) in
                SVProgressHUD.dismiss()
                if result.res_code == "1" {
                    let vc = RegisterSuccessViewController()
                    vc.userName = (self.phoneNumTF?.text)!
                    vc.password = (self.passwordTF?.text)!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
        }
    }
    
    func isValidInputs() -> Bool{
        if (codeSmsTF?.text?.isEmpty)! {
            SVProgressHUD.showError(withStatus: "短信验证码不能为空")
            return false
        }
        
        if (passwordTF?.text?.count)! < 8 || (passwordTF?.text?.count)! > 16 {
            SVProgressHUD.showError(withStatus: "密码由8~16位数字和字母组成")
            return false
        }
        
        if GJUtil.isHaveNumAndLetter(String: (passwordTF?.text)!) != 3 {
            SVProgressHUD.showError(withStatus: "密码由8~16位数字和字母组成")
            return false
        }
        
        return true
    }
    
    func addTimer(){
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    @objc func countTime(){
        second  = second - 1
        if second > 0 {
            getCodeSmsBtn?.setTitle("\(second)", for: .normal)
        }else{
            removeTimer()
            getCodeSmsBtn?.setTitle("获取验证码", for: .normal)
            second = 60
        }
    }
    
    func removeTimer(){
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNumTF?.resignFirstResponder()
        passwordTF?.resignFirstResponder()
        picSmsTF?.resignFirstResponder()
        codeSmsTF?.resignFirstResponder()
        inviteCodeTF?.resignFirstResponder()
    }

}
