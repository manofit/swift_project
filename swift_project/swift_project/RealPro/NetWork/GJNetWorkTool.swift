//
//  GJNetWorkTool.swift
//  swift_project
//
//  Created by 高军 on 2018/4/2.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit
import SwiftyJSON

enum SmsCodeType{
    case register
    case forgetPass
}

class GJNetWorkTool: NSObject {

    static let tool = GJNetWorkTool()
    
    var codeType = SmsCodeType.register
    
    struct result {
        var succ:Bool = false
        var mesg:String?
        var res_data:[String:Any]?
        var res_code:String?
    }
    
    
    var localPara:[String:Any] = ["devicetype":DEVICE_TYPE,"versioncode":VERSION,"user_id":GJUtil.GET_USER_DEFAULTS(Key: "userID")!,"appkey":APP_KEY,"ts":"\(GJUtil.changeNowDateToTimeStamp())","oauth_token":GJUtil.GET_USER_DEFAULTS(Key: "oauth_token")!,"signa":GJUtil.md5(Str: "\(GJUtil.md5(Str: "\(FRONT_SALT)\(GJUtil.changeNowDateToTimeStamp())"))\(BEHIND_SALT)".uppercased())]
    
    func handleResponse(JSON json:JSON) -> result{
        if GJUtil.isBlankString(String: json["res_msg"].string) != "" {
            SVProgressHUD.show(withStatus: json["res_msg"].string)
        }
        
        return result(succ:true, mesg:json["res_msg"].string, res_data:json["res_data"].dictionary, res_code:json["res_code"].string)
    }
    
    //登录
    func loginWith(MobileNum num:String, Password pass:String, Handler comp:@escaping ((result) -> Void)){
        localPara["id"] = num
        localPara["pwd"] = GJUtil.encodingBase64(String: pass)
        GJNetwork.requestWith(Method: .post, URL: HOST + LOGIN_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //首页
    func requestMainViewControllerData(_ comp:@escaping ((result) -> Void)){
        GJNetwork.requestWith(Method: .post, URL: HOST + MAIN_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            } catch {}
        }
    }
    
    //获取注册,忘记密码图片验证码
    func getRegisterPicCode(_ comp:@escaping ((String, Data) -> Void)){
        GJNetwork.requestWith(Method: .post, URL: HOST + REGISTER_PIC_CODE_API, Parameter: localPara, Token: nil) { (res) in
            let dic:Dictionary = (res.response?.allHeaderFields)!
            if dic.keys.contains("captchaToken") {
                comp(dic["captchaToken"] as! String, res.data!)
            }
        }
    }
    
    //注册，忘记密码获取文字验证码
    func getSmsCodeWith(Dic dic:Dictionary<String, String>, Handler comp:@escaping ((result) -> Void)){
        var localDic = localPara as [String : Any]
        for (key,value) in dic {
            localDic[key] = value
        }
        
        var urlStr = ""
        switch codeType {
        case .forgetPass:
            urlStr = HOST + FORGER_PASS_SMS_CODE_API
            break
        case .register:
            urlStr = HOST + REGISTER_SMS_CODE_API
            break
        }
        
        GJNetwork.requestWith(Method: .post, URL: urlStr, Parameter: localDic, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            } catch {}
        }
    }
    
    //注册
    func registerWith(PhoneNum phoneNum:String, InvestCode investCode:String?, SmsCode smscode:String, UserType type:String, Password password:String, Handler comp:@escaping ((result) -> Void)){
        localPara["phone"] = phoneNum
        localPara["invite_code"] = investCode
        localPara["code"] = smscode
        localPara["userNature"] = type
        localPara["pwd"] = password
        GJNetwork.requestWith(Method: .post, URL: HOST + REGISTER_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //忘记密码第一步验证手机号码
    func checkMobilePhoneWhenForgetPassword(PhoneNum phoneNum:String, SmsCode smscode:String, Handler comp:@escaping ((result) -> Void)){
        localPara["phone_or_email"] = phoneNum
        localPara["code"] = smscode
        GJNetwork.requestWith(Method: .post, URL: HOST + FORGET_PASS_FIRST_STEP_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            } catch {}
        }
    }
    
    //忘记密码后修改密码
    func changePasswordWith(PhoneNum phoneNum:String, Password password:String, Session_id session_id:String, Handler comp:@escaping((result) -> Void)){
        localPara["phone_or_email"] = phoneNum
        localPara["pwd"] = GJUtil.encodingBase64(String: password)
        localPara["session_id"] = session_id
        GJNetwork.requestWith(Method: .post, URL: HOST + CHANGE_PASSWROD_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //出借列表
    func getInvestListWith(Category cate:String, Page page:String, Handle comp:@escaping((result) -> Void)){
        localPara["page"] = page
        localPara["productCategory"] = cate
        localPara["pagesize"] = "10"
        GJNetwork.requestWith(Method: .post, URL: HOST + INVEST_LIST_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //cunguan，获取cunguan连接
    func getCunguanUrlWith(UserType type:String, Handler comp:@escaping((result) -> Void)) {
        localPara["userRole"] = type
        GJNetwork.requestWith(Method: .post, URL: HOST + CUNGUAN_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //获取出借订单号
    func getInvestNoWith(InvestID investId:String, Money money:String, RateID rateId:String, UserID userId:String = GJUtil.GET_USER_DEFAULTS(Key: "userID") as! String, UuID uuid:String, SessionID session_id:String, IsRewardInvest isRewardInvest:String, RedBonusID bonusId:String, InterestID interestId:String, UseTaste useTaste:String, CheckPass checkPass:String, DoubleReturnType doubleReturnType:String, Handler comp:@escaping((result) -> Void)) {
        localPara["pwd"] = checkPass
        localPara["experienceId"] = useTaste
        localPara["rateId"] = rateId
        localPara["redId"] = bonusId
        localPara["id"] = investId
        localPara["money"] = money
        localPara["paypwd"] = ""
        localPara["user_id"] = userId
        localPara["uuid"] = uuid
        localPara["up_rate_id"] = rateId
        localPara["isRewardInvest"] = isRewardInvest
        localPara["doInvestAgain"] = "F"
        localPara["doubleReturnType"] = doubleReturnType
        GJNetwork.requestWith(Method: .post, URL: HOST + GET_INVEST_NO, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //检查定向标密码是否正确
    func checkDirectInvestPass(Password pass:String, UUID uuid:String, InvestID investId:String, Handler comp:@escaping((result) -> Void)){
        localPara["uuid"] = uuid
        localPara["id"] = investId
        localPara["pwd"] = pass
        GJNetwork.requestWith(Method: .post, URL: HOST + CHECK_PWD, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //出借详情
    func getInvestDetailWith(UserID userId:String, UUID uuid:String, NID nid:String, Handler comp:@escaping((result) -> Void)) {
        localPara["id"] = nid
        localPara["uuid"] = uuid
        GJNetwork.requestWith(Method: .post, URL: HOST + INVEST_DETAIL, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //上划后出借详情
    func getInvestDetailAfterUpSwipeWith(UUID uuid:String, TypeID typeId:String, Handler comp:@escaping((result) -> Void)) {
        localPara["uuid"] = uuid
        localPara["borrowType"] = typeId
        GJNetwork.requestWith(Method: .post, URL: HOST + INVEST_DETAIL_DEATIL, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //出借记录
    func getInvestHistoryWith(UUID uuid:String, NID nid:String, Page page:String, Handler comp:@escaping((result) -> Void)) {
        localPara["page"] = page
        localPara["pagesize"] = 20
        localPara["id"] = nid
        GJNetwork.requestWith(Method: .post, URL: HOST + INVEST_HISTORY, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
    
    //我，个人中心
    func getMineData(Handler comp:@escaping((result) -> Void)) {
        GJNetwork.requestWith(Method: .post, URL: HOST + MINE_CENTER_API, Parameter: localPara, Token: nil) { (res) in
            do {
                let json = try JSON(data:res.data!)
                if JSON.null != json {
                    let aResult = self.handleResponse(JSON: json)
                    comp(aResult)
                }
            }catch{}
        }
    }
}
