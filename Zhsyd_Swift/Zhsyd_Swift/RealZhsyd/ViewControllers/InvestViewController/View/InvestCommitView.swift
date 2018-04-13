//
//  InvestCommitView.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/11.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class InvestCommitView: UIView, UITextFieldDelegate{

    var moneyTextField:UITextField?
    var freeMoneyLabel:UILabel?
    var shouyiLabel:UILabel?
    var commitBtn:UIButton?
    
    var isHaveDot = false
    
    var use_money = ""
    var apr:Float = 0.0
    var timeLimit = 1
    
    var closeEvent: (() -> Void)?
    var commitEvent: ((String) -> Void)?
    
    convenience init(Frame frame:CGRect, UseMoney money:String, Apr apr:Float, TimeLimit time:Int){
        self.init(frame: frame)
        
        use_money = money
        self.apr = apr
        timeLimit = time
        
        createUI()
    }
    
    func createUI(){
        self.backgroundColor = UIColor.white
        
        let titleLabel = GJUtil.createLabelWith(Text: "出借确认", Frame: CGRect(x:(SCREEN_WIDTH-92)/2, y:15, width:90, height:20), TextColor: UIColor.black, Font: 20, TextAligtment: nil)
        self.addSubview(titleLabel)
        
        let closeBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:SCREEN_WIDTH - 40, y:15, width:25, height:25), TitleColor: UIColor.clear, Font: nil, BackgroundColor: UIColor.clear, Target: self, Action: #selector(closeBtnAction), TextAligtment: nil)
        self.addSubview(closeBtn)
        
        let lineView = GJUtil.createViewWith(Frame: CGRect(x:0, y:titleLabel.frame.maxY + 15, width:SCREEN_WIDTH, height:1), BackgroundColor: MAIN_WHITE_COLOR)
        self.addSubview(lineView)
        
        let keyongLabel = GJUtil.createLabelWith(Text: "可用余额:", Frame: CGRect(x:15, y:lineView.frame.maxY + 15, width:90, height:20), TextColor: LABEL_TEXT_COLOR, Font: 17, TextAligtment: nil)
        self.addSubview(keyongLabel)
        
        freeMoneyLabel = GJUtil.createLabelWith(Text: use_money, Frame: CGRect(x:keyongLabel.frame.maxX + 5, y:lineView.frame.maxY + 15, width:SCREEN_WIDTH - 110, height:20), TextColor: UIColor.black, Font: 17, TextAligtment: .left)
        self.addSubview(freeMoneyLabel!)
        
        let chujiejineLabel = GJUtil.createLabelWith(Text: "出借余额:", Frame: CGRect(x:15, y:keyongLabel.frame.maxY + 30, width:90, height:20), TextColor: LABEL_TEXT_COLOR, Font: 17, TextAligtment: nil)
        self.addSubview(chujiejineLabel)
        
        let renmingbiLabel = GJUtil.createLabelWith(Text: "¥", Frame: CGRect(x:SCREEN_WIDTH/4 - 20, y:chujiejineLabel.frame.maxY + 20, width:40, height:40), TextColor: LABEL_BLACK_COLOR, Font: 36, TextAligtment: nil)
        self.addSubview(renmingbiLabel)
        
        moneyTextField = GJUtil.createTextFieldWith(Frame: CGRect(x:SCREEN_WIDTH/4 + 20, y:chujiejineLabel.frame.maxY + 20, width:SCREEN_WIDTH/2, height:40), BoardStyle: .none, PlaceHolder: "最低100元起投", BackgroundColor: UIColor.clear, TintColor: TINT_COLOR, IsPWD: false)
        moneyTextField?.font = UIFont.systemFont(ofSize: 15)
        moneyTextField?.delegate = self
        moneyTextField?.textAlignment = .center
        moneyTextField?.keyboardType = .decimalPad
        moneyTextField?.addTarget(self, action: #selector(moneyTFDidChanged(_:)), for: .editingChanged)
        self.addSubview(moneyTextField!)
        
        let yuanLabel = GJUtil.createLabelWith(Text: "元", Frame: CGRect(x:(moneyTextField?.frame.maxX)!, y:chujiejineLabel.frame.maxY + 20, width:40, height:40), TextColor: LABEL_BLACK_COLOR, Font: 15, TextAligtment: nil)
        self.addSubview(yuanLabel)
        
        let bottomLineView = GJUtil.createViewWith(Frame: CGRect(x:SCREEN_WIDTH/4 - 20, y:renmingbiLabel.frame.maxY, width:SCREEN_WIDTH/2 + 40, height:0.8), BackgroundColor: MAIN_WHITE_COLOR)
        self.addSubview(bottomLineView)
        
        let yujishouyiLabel = GJUtil.createLabelWith(Text: "预计收益:", Frame: CGRect(x:15, y:bottomLineView.frame.maxY + 30, width:90, height:20), TextColor: LABEL_TEXT_COLOR, Font: 17, TextAligtment: nil)
        self.addSubview(yujishouyiLabel)
        
        shouyiLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:yujishouyiLabel.frame.maxX + 5, y:bottomLineView.frame.maxY + 30, width:SCREEN_WIDTH - 110, height:20), TextColor: UIColor.black, Font: 17, TextAligtment: .left)
        self.addSubview(shouyiLabel!)
        
        commitBtn = GJUtil.createButtonWith(Type: .custom, Title: "确定", Frame: CGRect(x:15, y:yujishouyiLabel.frame.maxY + 40, width:SCREEN_WIDTH - 30, height:50), TitleColor: UIColor.white, Font: 20, BackgroundColor: UIColor.lightGray, Target: self, Action: #selector(commitBtnAction), TextAligtment: .center)
        commitBtn?.isEnabled = false
        commitBtn?.layer.cornerRadius = 5;
        commitBtn?.layer.shadowOffset =  CGSize(width:0, height:5);
        commitBtn?.layer.shadowOpacity = 0.5;
        self.addSubview(commitBtn!)
    }
    
    @objc func closeBtnAction(){
        if closeEvent != nil {
            closeEvent!()
        }
    }
    
    @objc func moneyTFDidChanged(_ textfield:UITextField){
        if Int((moneyTextField?.text)!)! >= 100 {
            commitBtn?.backgroundColor = TINT_COLOR
            
            commitBtn?.layer.shadowColor = TINT_COLOR.cgColor
            commitBtn?.isEnabled = true
            
            shouyiLabel?.text = NSString(format: "%.2f", (apr/3600)*Float((moneyTextField?.text)!)!*Float(timeLimit)) as String
        }else{
            commitBtn?.backgroundColor = UIColor.lightGray
            
            commitBtn?.layer.shadowColor = UIColor.lightGray.cgColor
            commitBtn?.isEnabled = false
            
            shouyiLabel?.text = ""
        }
    }
    
    @objc func commitBtnAction(){
        if commitEvent != nil {
            commitEvent!((moneyTextField?.text)!)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.contains("."))! {
            isHaveDot = true
        }
        
        if (textField.text?.isEmpty)! {
            if string == "." {
                return false
            }else{
                return true
            }
        }else{
            if isHaveDot {
                return false
            }else{
                return true
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moneyTextField?.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
