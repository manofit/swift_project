//
//  MainInvestListCell.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/2.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit
import SDCycleScrollView

@objc protocol MainInvestListCellDelegate {
    @objc optional func scrollViewDidSelected(Index index:Int)
    @objc optional func announceBtnAction()
}

class MainInvestListCell: UITableViewCell, SDCycleScrollViewDelegate{

    var delegate:MainInvestListCellDelegate?
    
    var scrollView:SDCycleScrollView?
    var announcementBtn:UIButton?
    
    var categoryLabel:UILabel?
    var investTitleLabel:UILabel?
    var rateLabel:UILabel?
    var timeLabel:UILabel?
    var surplusLabel:UILabel?
    var investBtn:UIButton?
    
    func createInvestListCellWith(Section section:NSInteger, Row row:NSInteger){
        if section == 0 {
            if row == 0 {
                scrollView = SDCycleScrollView(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:200), imageNamesGroup: [])
                scrollView?.backgroundColor = UIColor.white
                scrollView?.pageControlStyle = SDCycleScrollViewPageContolStyleClassic
                scrollView?.delegate = self as SDCycleScrollViewDelegate
                self.contentView.addSubview(scrollView!)
            }else{
                let boardCast = GJUtil.createImageViewWith(Frame: CGRect(x:10, y:12, width:16, height:16), ImageName: "bottom_broadcast", CornarRadius: 0.0)
                self.contentView.addSubview(boardCast)
                
                announcementBtn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:30, y:5, width:SCREEN_WIDTH-60, height:30), TitleColor: LABEL_TEXT_COLOR, Font: 12.0, BackgroundColor: UIColor.clear, Target: self, Action: #selector(clickAnounceBtn), TextAligtment: .left)
                self.contentView.addSubview(announcementBtn!)
                
                let line_view = GJUtil.createViewWith(Frame: CGRect(x:0, y:(announcementBtn?.frame.maxY)! + 5, width:SCREEN_WIDTH, height:0.5), BackgroundColor: MAIN_WHITE_COLOR)
                self.contentView.addSubview(line_view)
                
                let rightImageView = GJUtil.createImageViewWith(Frame: CGRect(x:SCREEN_WIDTH-30, y:12.5, width:15, height:15), ImageName: "tableCell_right", CornarRadius: 0.0)
                self.contentView.addSubview(rightImageView)
                
                for i in 0...3 {
                    let margin = Int((SCREEN_WIDTH-160)/5)
                    
                    let imageNameArray = ["bottom_home1","bottom_home2","bottom_home3","bottom_home4"]
                    let imageLabelArray = ["安全风控","助力小微企业","服务实体经济","合规监管"]
                    
                    let btn = GJUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:margin*(i+1)+40*i, y:Int((announcementBtn?.frame.maxY)! + 15), width:40, height:40), TitleColor: nil, Font: nil, BackgroundColor: UIColor.clear, Target: nil, Action: nil, TextAligtment: nil)
                    btn.setImage(UIImage(named:imageNameArray[i]), for: .normal)
                    self.contentView.addSubview(btn)
                    
                    let label = GJUtil.createLabelWith(Text: imageLabelArray[i], Frame: CGRect(x:Int(btn.frame.midX) - ((margin+40)/2), y:Int(btn.frame.maxY), width:margin+40, height:40), TextColor: LABEL_TEXT_COLOR, Font: 12.0, TextAligtment: .center)
                    label.numberOfLines = 0
                    self.contentView.addSubview(label)
                }
            }
        }else{
            categoryLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:10, y:10, width:40, height:20), TextColor: nil, Font: 12.0, TextAligtment: .center)
            categoryLabel?.layer.borderWidth = 1
            categoryLabel?.layer.cornerRadius = 2
            self.contentView.addSubview(categoryLabel!)
            
            investTitleLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:60, y:0, width:SCREEN_WIDTH-70, height:40), TextColor: LABEL_TEXT_COLOR, Font: 14.0, TextAligtment: .center)
            self.contentView.addSubview(investTitleLabel!)
            
            let line_view = GJUtil.createViewWith(Frame: CGRect(x:0, y:(investTitleLabel?.frame.maxY)!, width:SCREEN_WIDTH, height:0.5), BackgroundColor: MAIN_WHITE_COLOR)
            self.contentView.addSubview(line_view)
            
            let yearRateLabel = GJUtil.createLabelWith(Text: "年化利率", Frame: CGRect(x:10, y:(investTitleLabel?.frame.maxY)! + 10, width:SCREEN_WIDTH/3, height:20), TextColor: LABEL_TEXT_COLOR, Font: 12.0, TextAligtment: .center)
            self.contentView.addSubview(yearRateLabel)
            
            let timeTextLabel = GJUtil.createLabelWith(Text: "借款期限", Frame: CGRect(x:SCREEN_WIDTH/3+10, y:(investTitleLabel?.frame.maxY)! + 10, width:SCREEN_WIDTH/3, height:20), TextColor: LABEL_TEXT_COLOR, Font: 12.0, TextAligtment: .center)
            self.contentView.addSubview(timeTextLabel)
            
            surplusLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:SCREEN_WIDTH/3*2, y:(investTitleLabel?.frame.maxY)! + 10, width:SCREEN_WIDTH/3, height:20), TextColor: LABEL_TEXT_COLOR, Font: 12.0, TextAligtment: .center)
            self.contentView.addSubview(surplusLabel!)
            
            rateLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:10, y:yearRateLabel.frame.maxY + 5, width:SCREEN_WIDTH/3, height:20), TextColor: TINT_COLOR, Font: 12.0, TextAligtment: .center)
            self.contentView.addSubview(rateLabel!)
            
            timeLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:SCREEN_WIDTH/3+10, y:timeTextLabel.frame.maxY + 5, width:SCREEN_WIDTH/3, height:20), TextColor: UIColor.black, Font: 12.0, TextAligtment: .center)
            self.contentView.addSubview(timeLabel!)
            
            investBtn = GJUtil.createButtonWith(Type: .custom, Title: "出借", Frame: CGRect(x:SCREEN_WIDTH/3*2+(SCREEN_WIDTH/3-70)/2, y:(surplusLabel?.frame.maxY)! + 5, width:70, height:20), TitleColor: UIColor.white, Font: 14.0, BackgroundColor: BTN_BACK_COLOR, Target: nil, Action: nil, TextAligtment: .center)
            investBtn?.layer.cornerRadius = 10
            investBtn?.layer.masksToBounds = true
            self.contentView.addSubview(investBtn!)
            
            
        }
    }
    
    func configCellWithModel(CellModel cellModel:InvestListCellModel, BannarArray bannarArray:[BannarModel], AnnounceModel anounceModel:AnnouceModel){
        var imagePathArray = [String]()
        for model in bannarArray {
            imagePathArray.append(model.picPath)
        }
        scrollView?.imageURLStringsGroup = imagePathArray
        
        announcementBtn?.setTitle("公告:\(anounceModel.title)", for: .normal)
        
        if cellModel.productCategory == 1 {
            categoryLabel?.text = cellModel.typeStr
            categoryLabel?.layer.backgroundColor = INVEST_PERSON.cgColor
            categoryLabel?.textColor = INVEST_PERSON
        }else if cellModel.productCategory == 2 {
            categoryLabel?.text = cellModel.typeStr
            categoryLabel?.layer.backgroundColor = INVEST_COM.cgColor
            categoryLabel?.textColor = INVEST_COM
        }
        
        if cellModel.category == 0 {
            categoryLabel?.text = "新手"
            categoryLabel?.layer.backgroundColor = INVEST_NEW.cgColor
            categoryLabel?.textColor = INVEST_NEW
        }
        
        investTitleLabel?.text = GJUtil.isBlankString(String: cellModel.name)
        
        rateLabel?.attributedText = GJUtil.changeToAttributeStringWith(String: NSString(format: "%.2f%%", Double(cellModel.apr)!) as String, IndexOfString: 0, LengthOfString: NSString(format: "%.2f%%", Double(cellModel.apr)!).length - 1, StringFont: 24, StringColor: TINT_COLOR)
        
        if cellModel.timeType == "0" {
            timeLabel?.attributedText = GJUtil.changeToAttributeStringWith(String: NSString(format: "%@个月") as String, IndexOfString: 0, LengthOfString: NSString(format: "%@个月").length - 2, StringFont: 24, StringColor: UIColor.black)
        }else{
            timeLabel?.attributedText = GJUtil.changeToAttributeStringWith(String: NSString(format: "%@天") as String, IndexOfString: 0, LengthOfString: NSString(format: "%@个月").length - 1, StringFont: 24, StringColor: UIColor.black)
        }
        
        if cellModel.lastAccount == "0"{
            investBtn?.backgroundColor = UIColor.gray
            investBtn?.setTitle("已借完", for: .normal)
        }else{
            investBtn?.backgroundColor = BTN_BACK_COLOR
            investBtn?.setTitle("出借", for: .normal)
        }
        
        if Int(cellModel.lastAccount)!*1 >= 10000 {
            let moneyString:NSString = cellModel.lastAccount as NSString
            let string:NSMutableString = NSMutableString.init(format: "%@", moneyString.substring(to: moneyString.length - 2))
            string.insert(".", at: string.length - 2)
            let second:NSString = NSString.init(format: "剩余%@万元", string)
            surplusLabel?.attributedText = GJUtil.changeToAttributeStringWith(String: second as String, IndexOfString: 2, LengthOfString: string.length, StringFont: 14, StringColor: UIColor.black)
        }else{
            surplusLabel?.attributedText = GJUtil.changeToAttributeStringWith(String: NSString(format: "剩余%@元", cellModel.lastAccount) as String, IndexOfString: 2, LengthOfString: cellModel.lastAccount.count, StringFont: 14, StringColor: UIColor.black)
        }
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        if delegate != nil {
            delegate?.scrollViewDidSelected!(Index: index)
        }
    }
    
    @objc func clickAnounceBtn(){
        if delegate != nil {
            delegate?.announceBtnAction!()
        }
    }

}
