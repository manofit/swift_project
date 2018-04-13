//
//  InvestDetailViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/11.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class InvestDetailViewController: GJBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var isCompleted = false
    var isPerson = false
    
    var scale = ""
    var userID = ""
    var uuID = ""
    var nID = ""
    var pro_title = ""
    
    var tableView:UITableView?
    var checkPassword = ""
    var investDetailModel = InvestDetailModel()
    var isAlreadySwipeInBottom = false
    var isSecondAlreadySwipeInBottom = false
    
    var blackView:UIView?
    var investView:InvestCommitView?
    
    lazy var avoidLabel:UILabel = {
        let label = GJUtil.createLabelWith(Text: "企业用户请在电脑端开通cunguan账户", Frame: CGRect(x:30, y:SCREEN_HEIGHT/2-80, width:SCREEN_WIDTH-60, height:30), TextColor: UIColor.white, Font: 14, TextAligtment: .center)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.isHidden = true
        self.view.addSubview(label)
        
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isAlreadySwipeInBottom = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        isSecondAlreadySwipeInBottom = false
        setNavigation(Title: pro_title)
        
        createTableView()
        loadData()
    }
    
    func loadData(){
        SVProgressHUD.show()
        
        GJNetWorkTool.tool.getInvestDetailWith(UserID: userID, UUID: uuID, NID: nID) { (result) in
            SVProgressHUD.dismiss()
            
            self.investDetailModel.setValuesForKeys(result.res_data!)
            
            self.tableView?.reloadData()
        }
    }
    
    func createTableView(){
        tableView = UITableView.init(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y), style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }else{
            let view = GJUtil.createViewWith(Frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:10), BackgroundColor: MAIN_WHITE_COLOR)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return isCompleted == true ? 350 : 430
        }else{
            return 260
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! InvestDetailCell
        cell.investAction = {
            () -> Void in
            self.investBtnAction()
        }
        cell.createCellWith(Section: indexPath.section, Row: indexPath.row, Progress: scale, IsCompleted: isCompleted)
        if indexPath.section == 1 {
            cell.createFooterViewWith(IsCompleted: isCompleted)
        }
        cell.configCellWithModel(Model: investDetailModel)
        cell.selectionStyle  = .none
        return cell
    }
    
    func investBtnAction(){
        if investDetailModel.realname_status == "1" {
            if blackView == nil {
                blackView = GJUtil.createViewWith(Frame: self.view.bounds, BackgroundColor: UIColor.black.withAlphaComponent(0.5))
                self.view.addSubview(blackView!)
                
                investView = InvestCommitView.init(Frame: CGRect(x:0, y:SCREEN_HEIGHT, width:SCREEN_WIDTH, height:350), UseMoney: investDetailModel.use_money, Apr: Float(investDetailModel.apr), TimeLimit: investDetailModel.time_limit)
                investView?.closeEvent = {
                    () -> Void in
                    UIView.animate(withDuration: 0.5, animations: {
                        var frame = self.investView?.frame
                        frame?.origin.y = SCREEN_HEIGHT
                        frame?.origin.x = 0
                        self.investView?.frame = frame!
                    }, completion: { (finish) in
                        self.blackView?.removeFromSuperview()
                        self.blackView = nil
                    })
                }
                investView?.commitEvent = {
                    (moneyStr) -> Void in
                    UIView.animate(withDuration: 0.5, animations: {
                        var frame = self.investView?.frame
                        frame?.origin.y = SCREEN_HEIGHT
                        frame?.origin.x = 0
                        self.investView?.frame = frame!
                    }, completion: { (finish) in
                        self.blackView?.removeFromSuperview()
                        self.blackView = nil
                    })
                    
                    if self.investDetailModel.user_type == "1" {
                        if self.investDetailModel.is_directional == "0" {
                            self.investWith(Money: moneyStr)
                        }else{
                            let alert:TYAlertView = TYAlertView(title: "系统提示", message: "请输入定向密码!")
                            alert.buttonDefaultBgColor = TINT_COLOR
                            alert.addTextField(configurationHandler: { (textfield) in
                                textfield?.placeholder = "请输入定向密码"
                            })
                            weak var weakSelf = alert
                            alert.add(TYAlertAction(title: "确定", style: .default, handler: { (action) in
                                for textField in (weakSelf?.textFieldArray)! {
                                    if ((textField as! UITextField).text?.count)! > 0 {
                                        self.checkPassword = (textField as! UITextField).text!
                                        
                                        GJNetWorkTool.tool.checkDirectInvestPass(Password: self.checkPassword, UUID: self.uuID, InvestID: self.nID, Handler: { (result) in
                                            if result.res_code == "1" {
                                                self.investWith(Money: moneyStr)
                                            }else{
                                                SVProgressHUD.showError(withStatus: "定向密码错误!")
                                            }
                                        })
                                    }
                                }
                            }))
                        }
                    }else{
                        let alert:TYAlertView = TYAlertView(title: "系统提示", message: "您还没有登录,请登录!")
                        alert.buttonDefaultBgColor = TINT_COLOR
                        alert.titleLable.textColor = TINT_COLOR
                        alert.add(TYAlertAction(title: "确定", style: .default, handler: { (action) in
                        }))
                        alert.show(in: self, preferredStyle: .alert)
                    }
                    
                }
                self.view.addSubview(investView!)
                
                UIView.animate(withDuration: 0.5, animations: {
                    var frame = self.investView?.frame
                    frame?.origin.y = (self.blackView?.frame.size.height)! - 350
                    self.investView?.frame = frame!
                })
            }
        }else{
            let alert:TYAlertView = TYAlertView(title: "系统提示", message: "您还没有登录,请登录!")
            alert.buttonDefaultBgColor = TINT_COLOR
            alert.add(TYAlertAction(title: "取消", style: .default, handler: { (action) in
            }))
            alert.add(TYAlertAction(title: "确定", style: .default, handler: { (action) in
                if self.investDetailModel.userNature != 1 {
                    self.avoidLabel.isHidden = false
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2), execute: {
                        self.avoidLabel.isHidden = true
                    })
                }else{
                    GJNetWorkTool.tool.getCunguanUrlWith(UserType: "1", Handler: { (result) in
                        let vc = CunguanWebViewController()
                        vc.webTitle = "开通cunguan"
                        vc.link = "\(GJUtil.returnCunguanUrlWith(Url: result.res_data!["requestUrl"] as! String))&requestNo=\(result.res_data!["requestNo"] as! String)"
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                }
            }))
            alert.show(in: self, preferredStyle: .alert)
        }
    }
    
    func investWith(Money money:String){
        if checkPassword == "" {
            checkPassword = GJUtil.encodingBase64(String: checkPassword)
        }
        
        let alert:TYAlertView = TYAlertView(title: "系统提示", message: "您还没有登录,请登录!")
        alert.buttonDefaultBgColor = TINT_COLOR
        alert.add(TYAlertAction(title: "取消", style: .default, handler: { (action) in
        }))
        alert.add(TYAlertAction(title: "确定", style: .default, handler: { (action) in
            SVProgressHUD.show()
           
            GJNetWorkTool.tool.getInvestNoWith(InvestID: self.nID, Money: "\(money).00", RateID: "0", UserID: GJUtil.GET_USER_DEFAULTS(Key: "userID") as! String, UuID: self.uuID, SessionID: "", IsRewardInvest: "F", RedBonusID: "", InterestID: "", UseTaste: "", CheckPass: self.checkPassword, DoubleReturnType: "F", Handler: { (result) in
                SVProgressHUD.dismiss()
                
                let vc = CunguanWebViewController()
                vc.webTitle = "出借"
                vc.link = "\(HOST)\(GJUtil.returnCunguanUrlWith(Url: INVEST_URL))&requestNo=\(result.res_data!["requestNo"] as! String)"
                self.navigationController?.pushViewController(vc, animated: true)
            })
        }))
        alert.show(in: self, preferredStyle: .alert)
    }
    

}
