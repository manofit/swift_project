//
//  PersonInvestDetailCell.swift
//  swift_project
//
//  Created by 高军 on 2018/4/13.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit
import SDWebImage

class PersonInvestDetailCell: UITableViewCell {

    var lenderNameLabel:UILabel?
    var residenceLabel:UILabel?
    var ageLabel:UILabel?
    var jobStyleLabel:UILabel?
    var marryStatusLabel:UILabel?
    var jobProfessionLabel:UILabel?
    var professionLabel:UILabel?
    var workYearLabel:UILabel?
    var monthIncomeTitleLabel:UILabel?
    var monthIncomeLabel:UILabel?
    var borrowUseaLabel:UILabel?
    var repayFromLabel:UILabel?
    
    var creditImageView:UIImageView?
    var jobAuthenticateImageView:UIImageView?
    var identityAuthenticateImageView:UIImageView?
    var incomeAuthenticateImageView:UIImageView?
    
    var incomeAuthenticateImageViewLabel:UILabel?
    var riskReportLabel:UILabel?
    
    var picBackView:UIView?
    
    func createCellWith(Section section:Int){
        if section == 0 {
            let titleLabel = GJUtil.createLabelWith(Text: "借款人基本信息", Frame: CGRect(x:10, y:10, width:150, height:20), TextColor: UIColor.black, Font: 15, TextAligtment: nil)
            self.contentView.addSubview(titleLabel)
            
            let lineView = GJUtil.createViewWith(Frame: CGRect(x:0 ,y:titleLabel.frame.maxY + 10, width:SCREEN_WIDTH, height:1), BackgroundColor: MAIN_WHITE_COLOR)
            self.contentView.addSubview(lineView)
            
            let titleArray = ["借款人:","户籍:","年龄:","工作单位性质:","婚姻状况:","从事行业:","职业:","累计工作年限:"]
            for i in 0..<titleArray.count {
                let label = GJUtil.createLabelWith(Text: titleArray[i], Frame: CGRect(x:15, y:Int(lineView.frame.maxY) + 25*i + 10, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: .left)
                self.contentView.addSubview(label)
            }
            
            monthIncomeTitleLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:15, y:lineView.frame.maxY + 210, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: .left)
            self.contentView.addSubview(monthIncomeTitleLabel!)
            
            lenderNameLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 10, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            lenderNameLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(lenderNameLabel!)
            
            residenceLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 35, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            residenceLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(residenceLabel!)
            
            ageLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 60, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            ageLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(ageLabel!)
            
            jobStyleLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 85, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            jobStyleLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(jobStyleLabel!)
            
            marryStatusLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 110, width:120 ,height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            marryStatusLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(marryStatusLabel!)
            
            jobProfessionLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 135, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            jobProfessionLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(jobProfessionLabel!)
            
            professionLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 160, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            professionLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(professionLabel!)
            
            workYearLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 135, width:185, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            workYearLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(workYearLabel!)
            
            monthIncomeLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 210, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            monthIncomeLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(monthIncomeLabel!)
        }else if section == 1 {
            let titleLabel = GJUtil.createLabelWith(Text: "借款信息", Frame: CGRect(x:10, y:10, width:150, height:20), TextColor: UIColor.black, Font: 15, TextAligtment: nil)
            self.contentView.addSubview(titleLabel)
            
            let lineView = GJUtil.createViewWith(Frame: CGRect(x:0 ,y:titleLabel.frame.maxY + 10, width:SCREEN_WIDTH, height:1), BackgroundColor: MAIN_WHITE_COLOR)
            self.contentView.addSubview(lineView)
            
            let titleArray = ["借款用途:","还款来源:"]
            for i in 0..<titleArray.count {
                let label = GJUtil.createLabelWith(Text: titleArray[i], Frame: CGRect(x:15, y:Int(lineView.frame.maxY) + 25*i + 10, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: .left)
                self.contentView.addSubview(label)
            }
            
            borrowUseaLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 10, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            borrowUseaLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(borrowUseaLabel!)
            
            repayFromLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 35, width:SCREEN_WIDTH - 130, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            repayFromLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(repayFromLabel!)
        }else if section == 2 {
            let titleLabel = GJUtil.createLabelWith(Text: "资质审核", Frame: CGRect(x:10, y:10, width:150, height:20), TextColor: UIColor.black, Font: 15, TextAligtment: nil)
            self.contentView.addSubview(titleLabel)
            
            let lineView = GJUtil.createViewWith(Frame: CGRect(x:0 ,y:titleLabel.frame.maxY + 10, width:SCREEN_WIDTH, height:1), BackgroundColor: MAIN_WHITE_COLOR)
            self.contentView.addSubview(lineView)
            
            let label_1 = GJUtil.createLabelWith(Text: "信用报告:", Frame: CGRect(x:15, y:lineView.frame.maxY + 10, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_1)
            
            creditImageView = GJUtil.createImageViewWith(Frame: CGRect(x:label_1.frame.maxX + 10, y:label_1.frame.minY, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(creditImageView!)
            
            let label_2 = GJUtil.createLabelWith(Text: "工作认证:", Frame: CGRect(x:SCREEN_WIDTH/2, y:lineView.frame.maxY + 10, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_2)
            
            jobAuthenticateImageView = GJUtil.createImageViewWith(Frame: CGRect(x:label_2.frame.maxX + 10, y:label_2.frame.minY, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(jobAuthenticateImageView!)
            
            let label_3 = GJUtil.createLabelWith(Text: "身份认证:", Frame: CGRect(x:15, y:lineView.frame.maxY + 35, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_3)
            
            identityAuthenticateImageView = GJUtil.createImageViewWith(Frame: CGRect(x:label_3.frame.maxX + 10, y:label_3.frame.minY, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(identityAuthenticateImageView!)
            
            incomeAuthenticateImageViewLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:SCREEN_WIDTH/2, y:lineView.frame.maxY + 35, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(incomeAuthenticateImageViewLabel!)
            
            identityAuthenticateImageView = GJUtil.createImageViewWith(Frame: CGRect(x:(incomeAuthenticateImageViewLabel?.frame.maxX)! + 10, y:(incomeAuthenticateImageViewLabel?.frame.minY)!, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(identityAuthenticateImageView!)
        }else if section == 3 {
            let titleLabel = GJUtil.createLabelWith(Text: "风险提示", Frame: CGRect(x:10, y:10, width:150, height:20), TextColor: UIColor.black, Font: 15, TextAligtment: nil)
            self.contentView.addSubview(titleLabel)
            
            let lineView = GJUtil.createViewWith(Frame: CGRect(x:0 ,y:titleLabel.frame.maxY + 10, width:SCREEN_WIDTH, height:1), BackgroundColor: MAIN_WHITE_COLOR)
            self.contentView.addSubview(lineView)
            
            let label_1 = GJUtil.createLabelWith(Text: "风险提示报告:", Frame: CGRect(x:15, y:lineView.frame.maxY + 10, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_1)
            
            riskReportLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 10, width:SCREEN_WIDTH - 130, height:40), TextColor: UIColor.black, Font: 12, TextAligtment: nil)
            riskReportLabel?.adjustsFontSizeToFitWidth = true
            riskReportLabel?.numberOfLines = 0
            self.contentView.addSubview(riskReportLabel!)
        }else if section == 4 {
            let titleLabel = GJUtil.createLabelWith(Text: "证件信息", Frame: CGRect(x:10, y:10, width:150, height:20), TextColor: UIColor.black, Font: 15, TextAligtment: nil)
            self.contentView.addSubview(titleLabel)
            
            let lineView = GJUtil.createViewWith(Frame: CGRect(x:0 ,y:titleLabel.frame.maxY + 10, width:SCREEN_WIDTH, height:1), BackgroundColor: MAIN_WHITE_COLOR)
            self.contentView.addSubview(lineView)
            
            picBackView = GJUtil.createViewWith(Frame: CGRect(x:0, y:lineView.frame.minY, width:SCREEN_WIDTH, height:1), BackgroundColor: UIColor.white)
            self.contentView.addSubview(picBackView!)
        }
    }
    
    func configCellWith(Model model:PersonInvestDetailModel){
        lenderNameLabel?.text = GJUtil.isBlankString(String: model.realName)
        residenceLabel?.text = GJUtil.isBlankString(String: model.hometown)
        ageLabel?.text = GJUtil.isBlankString(String: model.birthday)
        jobStyleLabel?.text = GJUtil.isBlankString(String: model.workplace_nature)
        marryStatusLabel?.text = GJUtil.isBlankString(String: model.marriage)
        jobProfessionLabel?.text = GJUtil.isBlankString(String: model.industry)
        professionLabel?.text = GJUtil.isBlankString(String: model.career)
        workYearLabel?.text = GJUtil.isBlankString(String: model.total_working_time)
        
        if model.productType == 11 {
            monthIncomeTitleLabel?.text = "月收入:"
            monthIncomeLabel?.text = GJUtil.isBlankString(String: model.monthly_salary)
            
            incomeAuthenticateImageViewLabel?.text = "收入认证:"
            if model.incomeCertification == "1" {
                incomeAuthenticateImageView?.image = UIImage(named:"")
            }else{
                incomeAuthenticateImageView?.image = UIImage(named:"")
            }
        }else{
            monthIncomeTitleLabel?.text = "学历:"
            monthIncomeLabel?.text = GJUtil.isBlankString(String: model.education)
            
            incomeAuthenticateImageViewLabel?.text = "医院认证:"
            if model.incomeCertification == "1" {
                incomeAuthenticateImageView?.image = UIImage(named:"")
            }else{
                incomeAuthenticateImageView?.image = UIImage(named:"")
            }
        }
        
        borrowUseaLabel?.text = GJUtil.isBlankString(String: model.borrowUse)
        repayFromLabel?.text = GJUtil.isBlankString(String: model.repaymentSource)
        
        if model.creditReport == "1"{
            creditImageView?.image = UIImage(named:"")
        }else{
            creditImageView?.image = UIImage(named:"")
        }
        
        if model.workCertification == "1"{
            jobAuthenticateImageView?.image = UIImage(named:"")
        }else{
            jobAuthenticateImageView?.image = UIImage(named:"")
        }
        
        if model.authentication == "1"{
            identityAuthenticateImageView?.image = UIImage(named:"")
        }else{
            identityAuthenticateImageView?.image = UIImage(named:"")
        }
        
        riskReportLabel?.text = GJUtil.isBlankString(String: model.riskReport).replacingOccurrences(of: "<br/>", with: "")
        if riskReportLabel != nil {
            if riskReportLabel?.text != "" {
                let stringSize = ((riskReportLabel?.text)! as NSString).boundingRect(with: CGSize.init(width: riskReportLabel!.frame.size.width, height: CGFloat(MAXFLOAT)), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: [NSAttributedStringKey.font: riskReportLabel?.font! as Any], context: nil).size
                
                var rect = riskReportLabel?.frame
                rect?.size.height = stringSize.height
                riskReportLabel?.frame = rect!
            }
        }
        
        var frame = picBackView?.frame
        frame?.size.height = CGFloat(model.list.count * 110 + 10)
        picBackView?.frame = frame!
        
        for i in 0..<model.list.count {
            let imageView = GJUtil.createImageViewWith(Frame: CGRect(x:Int((SCREEN_WIDTH-150)/2), y:110 * i + 10, width:150, height:100), ImageName: "", CornarRadius: 0)
            let dic = model.list[i] as Dictionary
            imageView.sd_setImage(with: URL.init(string: dic["picUrl"]!), completed: nil)
            
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImageView(_:))))
            imageView.isUserInteractionEnabled = true
            
            picBackView?.addSubview(imageView)
        }
    }
    
    @objc func tapImageView(_ reg:UITapGestureRecognizer){
        GJPictureShow.picture.show(ImageView: reg.view as! UIImageView)
    }
    
    func returnCellHeight() -> CGFloat{
        if riskReportLabel != nil {
            if riskReportLabel?.text != "" {
                let stringSize = ((riskReportLabel?.text)! as NSString).boundingRect(with: CGSize.init(width: riskReportLabel!.frame.size.width, height: CGFloat(MAXFLOAT)), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: [NSAttributedStringKey.font: riskReportLabel?.font! as Any], context: nil).size
                return stringSize.height + 70
            }
        }
        
        return 70
    }
    
    func returnPicCellHeight() -> CGFloat{
        return (picBackView?.frame.size.height)! + 50
    }

}
