//
//  InvestDetailCell.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/11.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class InvestDetailCell: UITableViewCell {

    var investTotalLabel:UILabel?
    var yearRateLabel:UILabel?
    var timeLabel:UILabel?
    var surplusLabel:UILabel?
    var progressView:GJProgressView?
    
    var proNameLabel:UILabel?
    var proTypeLabel:UILabel?
    var startTimeLabel:UILabel?
    var receiveTypeLabel:UILabel?
    
    var picImageView:UIImageView?
    
    var investAction: (() -> Void)?
    
    func createCellWith(Section section:Int, Row row:Int, Progress progress:String, IsCompleted isCompleted:Bool){
        if section == 0 {
            let view_1 = GJUtil.createViewWith(Frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:180), BackgroundColor: UIColor(red: 232.0/255, green: 55.0/255, blue: 64.0/255, alpha: 1.0))
            self.contentView.addSubview(view_1)
            
            let view_2 = GJUtil.createViewWith(Frame: CGRect(x:0, y:view_1.frame.maxY, width:SCREEN_WIDTH, height:80), BackgroundColor: UIColor(red: 242.0/255, green: 57.0/255, blue: 66.0/255, alpha: 1.0))
            self.contentView.addSubview(view_2)
            
            investTotalLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:15, y:15, width:SCREEN_WIDTH - 30, height:20), TextColor: UIColor.white, Font: 15, TextAligtment: .left)
            self.contentView.addSubview(investTotalLabel!)
            
            yearRateLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:15, y:(investTotalLabel?.frame.maxY)! + 30, width:120, height:60), TextColor: UIColor.white, Font: 60, TextAligtment: .center)
            self.contentView.addSubview(yearRateLabel!)
            
            let label_1 = GJUtil.createLabelWith(Text: "%", Frame: CGRect(x:(yearRateLabel?.frame.maxX)!, y:(yearRateLabel?.frame.maxY)! - 25, width:30 , height:20), TextColor: UIColor.white, Font:  17, TextAligtment: .left)
            self.contentView.addSubview(label_1)
            
            let label_2 = GJUtil.createLabelWith(Text: "年化利率", Frame: CGRect(x:15, y:(yearRateLabel?.frame.maxY)!, width:120 , height:20), TextColor: MAIN_WHITE_COLOR, Font:  14, TextAligtment: .center)
            self.contentView.addSubview(label_2)
            
            //进度条
            progressView = GJProgressView(frame: CGRect(x:SCREEN_WIDTH - 135, y:(investTotalLabel?.frame.maxY)! + 10 ,width:115, height:115))
            progressView?.mainPathWidth = 17
            self.contentView.addSubview(progressView!)
            
            progressView?.drawCircleWith(Progress: Int(progress)!)
            
            timeLabel = GJUtil.createLabelWith(Text: "个月", Frame: CGRect(x:15, y:view_1.frame.maxY + 15, width:SCREEN_WIDTH/2 - 30, height:30), TextColor: UIColor.white, Font: 20, TextAligtment: .center)
            self.contentView.addSubview(timeLabel!)
            
            let label_3 = GJUtil.createLabelWith(Text: "借款期限", Frame: CGRect(x:15, y:(timeLabel?.frame.maxY)!, width:SCREEN_WIDTH/2 - 30, height:20), TextColor: MAIN_WHITE_COLOR, Font: 15, TextAligtment: .center)
            self.contentView.addSubview(label_3)
            
            let view_3 = GJUtil.createViewWith(Frame: CGRect(x:SCREEN_WIDTH/2 - 0.5, y:view_1.frame.maxY + 25, width:1, height:30), BackgroundColor: UIColor.white)
            self.contentView.addSubview(view_3)
            
            surplusLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:SCREEN_WIDTH/2 + 15, y:view_1.frame.maxY + 15, width:SCREEN_WIDTH/2 - 30, height:30), TextColor: UIColor.white, Font: 20, TextAligtment: .center)
            self.contentView.addSubview(surplusLabel!)
            
            let label_4 = GJUtil.createLabelWith(Text: "剩余可投（元）", Frame: CGRect(x:SCREEN_WIDTH/2 + 15, y:view_1.frame.maxY, width:SCREEN_WIDTH/2 - 30, height:20), TextColor: MAIN_WHITE_COLOR, Font: 15, TextAligtment: .center)
            self.contentView.addSubview(label_4)
        }else if section == 1 {
            let label_1 = GJUtil.createLabelWith(Text: "产品介绍:", Frame: CGRect(x:15, y:15, width:100 ,height:30), TextColor: UIColor.black, Font: 20, TextAligtment: .left)
            self.contentView.addSubview(label_1)
            
            let lineView = GJUtil.createViewWith(Frame: CGRect(x:0, y:label_1.frame.maxY + 15, width:SCREEN_WIDTH, height:1), BackgroundColor: MAIN_WHITE_COLOR)
            self.contentView.addSubview(lineView)
            
            let titleArray = ["产品名称:","产品类型:","起息时间:","回款方式:"]
            for i in 0..<titleArray.count {
                let maigin = 15*(i+1) + 30*i
                let label = GJUtil.createLabelWith(Text: titleArray[i], Frame: CGRect(x:15, y:lineView.frame.maxY + CGFloat(maigin), width:80, height:20), TextColor: LABEL_TEXT_COLOR, Font: 17, TextAligtment: .left)
                self.contentView.addSubview(label)
            }
            
            proNameLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:110, y:lineView.frame.maxY + 15, width:SCREEN_WIDTH - 125, height:20), TextColor: UIColor.black, Font: 17, TextAligtment: .left)
            proNameLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(proNameLabel!)
            
            proTypeLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:110, y:lineView.frame.maxY + 60, width:SCREEN_WIDTH - 125, height:20), TextColor: UIColor.black, Font: 17, TextAligtment: .left)
            self.contentView.addSubview(proTypeLabel!)
            
            startTimeLabel = GJUtil.createLabelWith(Text: "T+1日计息", Frame: CGRect(x:110, y:lineView.frame.maxY + 105, width:SCREEN_WIDTH - 125, height:20), TextColor: UIColor.black, Font: 17, TextAligtment: .left)
            self.contentView.addSubview(startTimeLabel!)
            
            receiveTypeLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:110, y:lineView.frame.maxY + 150, width:SCREEN_WIDTH - 125, height:20), TextColor: UIColor.black, Font: 17, TextAligtment: .left)
            self.contentView.addSubview(startTimeLabel!)
            
            picImageView = GJUtil.createImageViewWith(Frame: CGRect(x:SCREEN_WIDTH - 115, y:15 , width:100, height:80), ImageName: "任务详情-已结束", CornarRadius: 0.0)
            if isCompleted {
                picImageView?.isHidden = false
            }else{
                picImageView?.isHidden = true
            }
            self.contentView.addSubview(picImageView!)
        }
    }
    
    func createFooterViewWith(IsCompleted isCompleted:Bool){
        if isCompleted {
            let imageView = GJUtil.createImageViewWith(Frame: CGRect(x:0, y:280, width:SCREEN_WIDTH, height:70), ImageName: "下拉", CornarRadius: 0.0)
            self.contentView.addSubview(imageView)
        }else{
            let imageView = GJUtil.createImageViewWith(Frame: CGRect(x:0, y:280, width:SCREEN_WIDTH, height:70), ImageName: "下拉", CornarRadius: 0.0)
            self.contentView.addSubview(imageView)
            
            let investBtn = GJUtil.createButtonWith(Type: .custom, Title: "立即出借", Frame: CGRect(x:15, y:350, width:SCREEN_WIDTH - 30, height:60), TitleColor: UIColor.white, Font: 20, BackgroundColor: TINT_COLOR, Target: self, Action: #selector(investBtnAction), TextAligtment: .center)
            investBtn.layer.cornerRadius = 5
            investBtn.layer.shadowOffset = CGSize(width:0, height:5)
            investBtn.layer.shadowOpacity = 0.5
            investBtn.layer.shadowColor = TINT_COLOR.cgColor
            self.contentView.addSubview(investBtn)
        }
    }
    
    func configCellWithModel(Model model:InvestDetailModel){
        investTotalLabel?.text = "借款总额（元）: \(GJUtil.isBlankString(String: model.account))"
        yearRateLabel?.text = NSString(format: "%.1f", model.apr) as String
        timeLabel?.text = "\(model.time_limit)个月"
        surplusLabel?.text = model.account_wait
        proNameLabel?.text = model.name
        proTypeLabel?.text = GJUtil.isBlankString(String: model.guarantee_type_str)
        receiveTypeLabel?.text = model.repayment_style_str
    }
    
    @objc func investBtnAction(){
        if investAction != nil {
            investAction!()
        }
    }

}
