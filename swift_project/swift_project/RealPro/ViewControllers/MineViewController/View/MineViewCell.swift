//
//  MineViewCell.swift
//  swift_project
//
//  Created by 高军 on 2018/4/16.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit


class MineViewCell: UITableViewCell {

    var phoneNumBtn:UIButton?
    var totalAssetLabel:UILabel?
    var totalIncomeLabel:UILabel?
    var avalibleFreeLabel:UILabel?
    var headerImageView:UIImageView?
    
    var cellBtnAction: ((Int) -> Void)?
    
    func createCellWith(Row row:Int){
        if row == 0 {
            self.contentView.backgroundColor = MAIN_WHITE_COLOR
            
            let imageView = GJUtil.createImageViewWith(Frame: CGRect(x:0 ,y:0, width:SCREEN_WIDTH, height:210 + STATUSBAR_HEIGHT), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(imageView)
            
            let titleLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:(SCREEN_WIDTH-200)/2, y:STATUSBAR_HEIGHT + 10, width:200, height:30), TextColor: UIColor.white, Font: 17, TextAligtment: .center)
            self.contentView.addSubview(titleLabel)
            
            headerImageView = GJUtil.createImageViewWith(Frame: CGRect(x:15, y:titleLabel.frame.maxY + 20, width:22 ,height:22), ImageName: "", CornarRadius: 11)
            headerImageView?.clipsToBounds = true
            self.contentView.addSubview(headerImageView!)
            
            phoneNumBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:(headerImageView?.frame.maxX)! + 5, y:(headerImageView?.frame.origin.y)!  - 3, width:100, height:30), TitleColor: UIColor.white, Font: 17, BackgroundColor: UIColor.clear, Target: self, Action: #selector(cellBtnClick(_:)), TextAligtment: .left)
            phoneNumBtn?.tag = 1
            self.contentView.addSubview(phoneNumBtn!)
            
            let jiantouBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:(phoneNumBtn?.frame.maxX)!, y:(headerImageView?.frame.origin.y)! + 2, width:20 ,height:20), TitleColor: UIColor.white, Font: 17, BackgroundColor: UIColor.clear, Target: self, Action: #selector(cellBtnClick(_:)), TextAligtment: .left)
            jiantouBtn.tag = 10
            self.contentView.addSubview(jiantouBtn)
            
            let midLineView = GJUtil.createViewWith(Frame: CGRect(x:(SCREEN_WIDTH-1)/2, y:(headerImageView?.frame.maxY)! + 20, width:1, height:46), BackgroundColor: UIColor.white)
            self.contentView.addSubview(midLineView)
            
            totalAssetLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:midLineView.frame.minX-150, y:midLineView.frame.origin.y, width:150, height:30), TextColor: MAIN_WHITE_COLOR, Font: 15, TextAligtment: .center)
            self.contentView.addSubview(totalAssetLabel!)
            
            let assetChaLabel = GJUtil.createLabelWith(Text: "账户总资产(元)", Frame: CGRect(x:midLineView.frame.minX-150, y:(totalAssetLabel?.frame.maxY)!, width:150, height:20), TextColor: MAIN_WHITE_COLOR, Font: 15, TextAligtment: .center)
            self.contentView.addSubview(assetChaLabel)
            
            totalIncomeLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:midLineView.frame.maxX, y:midLineView.frame.origin.y, width:150 ,height:30), TextColor: UIColor.white, Font: 20, TextAligtment: .center)
            self.contentView.addSubview(totalIncomeLabel!)
            
            let incomeChaLabel = GJUtil.createLabelWith(Text: "累计收益(元)", Frame: CGRect(x:midLineView.frame.minX-150, y:(totalIncomeLabel?.frame.maxY)!, width:150, height:20), TextColor: MAIN_WHITE_COLOR, Font: 15, TextAligtment: .center)
            self.contentView.addSubview(incomeChaLabel)
            
            let whiteBackView = GJUtil.createViewWith(Frame: CGRect(x:15, y:midLineView.frame.maxY + 20 ,width:SCREEN_WIDTH-30, height:80), BackgroundColor: UIColor.clear)
            whiteBackView.layer.cornerRadius = 5
            self.contentView.addSubview(whiteBackView)
            
            let imageView_back = GJUtil.createImageViewWith(Frame: CGRect(x:0, y:0, width:SCREEN_WIDTH-30, height:80), ImageName: "", CornarRadius: 5)
            imageView_back.clipsToBounds = true
            whiteBackView.addSubview(imageView_back)
            
            let freeChaLabel = GJUtil.createLabelWith(Text: "可用余额(元)", Frame: CGRect(x:20 ,y:20 ,width:150 ,height:20), TextColor: LABEL_TEXT_COLOR, Font: 14, TextAligtment: nil)
            whiteBackView.addSubview(freeChaLabel)
            
            avalibleFreeLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:20 ,y:freeChaLabel.frame.maxY, width:whiteBackView.frame.size.width-40, height:20), TextColor: UIColor.black, Font: 18, TextAligtment: nil)
            self.contentView.addSubview(avalibleFreeLabel!)
            
            let withDrawBtn = GJUtil.createButtonWith(Type: .custom, Title: "提现", Frame: CGRect(x:whiteBackView.frame.size.width-70, y:(whiteBackView.frame.size.height-30)/2, width:50, height:30), TitleColor: UIColor.black, Font: 19, BackgroundColor: UIColor.clear, Target: self, Action: #selector(cellBtnClick(_:)), TextAligtment: nil)
            withDrawBtn.tag = 2
            whiteBackView.addSubview(withDrawBtn)
            
            let addMoneyBtn = GJUtil.createButtonWith(Type: .custom, Title: "充值", Frame: CGRect(x:withDrawBtn.frame.minX-60, y:(whiteBackView.frame.size.height-30)/2, width:50, height:30), TitleColor: TINT_COLOR, Font: 19, BackgroundColor: UIColor.clear, Target: self, Action: #selector(cellBtnClick(_:)), TextAligtment: nil)
            addMoneyBtn.tag = 3
            whiteBackView.addSubview(addMoneyBtn)
            
            let chujiequanBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:15, y:whiteBackView.frame.maxY+10, width:165, height:70), TitleColor: UIColor.white, Font: nil, BackgroundColor: UIColor.clear, Target: self, Action: #selector(cellBtnClick(_:)), TextAligtment: nil)
            chujiequanBtn.tag = 4
            chujiequanBtn.setImage(UIImage(named:""), for: .normal)
            self.contentView.addSubview(chujiequanBtn)
            
            let jiaxiquanBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:SCREEN_WIDTH-180, y:whiteBackView.frame.maxY+10, width:165, height:70), TitleColor: UIColor.white, Font: nil, BackgroundColor: UIColor.clear, Target: self, Action: #selector(cellBtnClick(_:)), TextAligtment: nil)
            jiaxiquanBtn.tag = 5
            jiaxiquanBtn.setImage(UIImage(named:""), for: .normal)
            self.contentView.addSubview(jiaxiquanBtn)
        }else if row == 1 {
            self.imageView?.image = UIImage(named:"")
            self.textLabel?.text = "我的出借"
        }else if row == 2 {
            self.imageView?.image = UIImage(named:"")
            self.textLabel?.text = "资金明细"
        }else if row == 3 {
            self.imageView?.image = UIImage(named:"")
            self.textLabel?.text = "邀请有奖"
        }else{
            self.imageView?.image = UIImage(named:"")
            self.textLabel?.text = "站内信"
        }
    }
    
    @objc func cellBtnClick(_ sender:Any){
        let button = sender as! UIButton
        
        if cellBtnAction != nil {
            cellBtnAction!(button.tag)
        }
    }
    
    func configCellWith(Model model:MineViewModel){
        phoneNumBtn?.setTitle(GJUtil.isBlankString(String: model.mobilePhone), for: .normal)
        
        totalAssetLabel?.text = GJUtil.isBlankString(String: model.account_total)
        totalIncomeLabel?.text = GJUtil.isBlankString(String: model.earnAmount)
        
        avalibleFreeLabel?.text  = GJUtil.isBlankString(String: model.use_money)
        
        if model.headImg != "" {
            headerImageView?.sd_setImage(with: URL(string: model.headImg), completed: nil)
        }
    }

}
