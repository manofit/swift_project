//
//  CompanyInvestDetailCell.swift
//  swift_project
//
//  Created by 高军 on 2018/4/13.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class CompanyInvestDetailCell: UITableViewCell {

    var companyNameLabel:UILabel?
    var industryLabel:UILabel?
    var foundDateLabel:UILabel?
    var addressLabel:UILabel?
    var companyStyleLabel:UILabel?
    var companyShapeLabel:UILabel?
    var companyDesLabel:UILabel?
    var borrowUseaLabel:UILabel?
    var repayFromLabel:UILabel?
    
    var businessImageView:UIImageView?
    var cardImageView:UIImageView?
    var openAccountImageView:UIImageView?
    var bossidcardImageView:UIImageView?
    var regulationImageView:UIImageView?
    var contactsImageView:UIImageView?
    
    var riskReportLabel:UILabel?
    var picBackView:UIView?
    
    func createCellWith(Section section:Int){
        if section == 0 {
            let titleLabel = GJUtil.createLabelWith(Text: "借款人基本信息", Frame: CGRect(x:10, y:10, width:150, height:20), TextColor: UIColor.black, Font: 15, TextAligtment: nil)
            self.contentView.addSubview(titleLabel)
            
            let lineView = GJUtil.createViewWith(Frame: CGRect(x:0 ,y:titleLabel.frame.maxY + 10, width:SCREEN_WIDTH, height:1), BackgroundColor: MAIN_WHITE_COLOR)
            self.contentView.addSubview(lineView)
            
            let titleArray = ["企业名称:","所属行业:","成立时间:","企业所在地:","公司性质:","企业规模:","企业介绍:"]
            for i in 0..<titleArray.count {
                let label = GJUtil.createLabelWith(Text: titleArray[i], Frame: CGRect(x:15, y:Int(lineView.frame.maxY) + 25*i + 10, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: .left)
                self.contentView.addSubview(label)
            }
            
            companyNameLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 10, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            companyNameLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(companyNameLabel!)
            
            industryLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 35, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            industryLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(industryLabel!)
            
            foundDateLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 60, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            foundDateLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(foundDateLabel!)
            
            addressLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 85, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            addressLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(addressLabel!)
            
            companyStyleLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 110, width:120 ,height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            companyStyleLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(companyStyleLabel!)
            
            companyShapeLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 135, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            companyShapeLabel?.adjustsFontSizeToFitWidth = true
            self.contentView.addSubview(companyShapeLabel!)
            
            companyDesLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:115, y:lineView.frame.maxY + 160, width:120, height:15), TextColor: UIColor.black, Font: 13, TextAligtment: nil)
            companyDesLabel?.adjustsFontSizeToFitWidth = true
            companyDesLabel?.numberOfLines = 0
            self.contentView.addSubview(companyDesLabel!)
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
            
            let label_1 = GJUtil.createLabelWith(Text: "公司工商信息:", Frame: CGRect(x:15, y:lineView.frame.maxY + 10, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_1)
            
            businessImageView = GJUtil.createImageViewWith(Frame: CGRect(x:label_1.frame.maxX + 10, y:label_1.frame.minY, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(businessImageView!)
            
            let label_2 = GJUtil.createLabelWith(Text: "营业执照:", Frame: CGRect(x:SCREEN_WIDTH/2, y:lineView.frame.maxY + 10, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_2)
            
            cardImageView = GJUtil.createImageViewWith(Frame: CGRect(x:label_2.frame.maxX + 10, y:label_2.frame.minY, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(cardImageView!)
            
            let label_3 = GJUtil.createLabelWith(Text: "开户许可证:", Frame: CGRect(x:15, y:lineView.frame.maxY + 35, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_3)
            
            openAccountImageView = GJUtil.createImageViewWith(Frame: CGRect(x:label_3.frame.maxX + 10, y:label_3.frame.minY, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(openAccountImageView!)
            
            let label_4 = GJUtil.createLabelWith(Text: "法人及股东身份证:", Frame: CGRect(x:SCREEN_WIDTH/2, y:lineView.frame.maxY + 35, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_4)
            
            bossidcardImageView = GJUtil.createImageViewWith(Frame: CGRect(x:label_4.frame.maxX + 10, y:label_4.frame.minY, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(bossidcardImageView!)
            
            let label_5 = GJUtil.createLabelWith(Text: "公司章程:", Frame: CGRect(x:15, y:lineView.frame.maxY + 60, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_5)
            
            regulationImageView = GJUtil.createImageViewWith(Frame: CGRect(x:label_5.frame.maxX + 10, y:label_5.frame.minY, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(regulationImageView!)
            
            let label_6 = GJUtil.createLabelWith(Text: "联系人信息:", Frame: CGRect(x:SCREEN_WIDTH/2, y:lineView.frame.maxY + 60, width:100, height:15), TextColor: LABEL_TEXT_COLOR, Font: 13, TextAligtment: nil)
            self.contentView.addSubview(label_6)
            
            bossidcardImageView = GJUtil.createImageViewWith(Frame: CGRect(x:label_6.frame.maxX + 10, y:label_6.frame.minY, width:15, height:15), ImageName: "", CornarRadius: 0)
            self.contentView.addSubview(bossidcardImageView!)
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
    
    func configCellWith(Model model:CompanyInvestDetailModel){
        companyNameLabel?.text = GJUtil.isBlankString(String: model.company_name)
        industryLabel?.text = GJUtil.isBlankString(String: model.company_industry)
        foundDateLabel?.text = GJUtil.isBlankString(String: model.company_regtime)
        addressLabel?.text = GJUtil.isBlankString(String: model.company_address)
        companyStyleLabel?.text = GJUtil.isBlankString(String: model.workplace_nature)
        companyShapeLabel?.text = GJUtil.isBlankString(String: model.company_scale)
        borrowUseaLabel?.text = GJUtil.isBlankString(String: model.borrowUse)
        repayFromLabel?.text = GJUtil.isBlankString(String: model.repaymentSource)
        
        companyDesLabel?.text = GJUtil.isBlankString(String: model.introduce)
        if companyDesLabel != nil {
            if companyDesLabel?.text != "" {
                let stringSize = ((companyDesLabel?.text)! as NSString).boundingRect(with: CGSize.init(width: companyDesLabel!.frame.size.width, height: CGFloat(MAXFLOAT)), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: [NSAttributedStringKey.font: companyDesLabel?.font! as Any], context: nil).size
                
                var rect = companyDesLabel?.frame
                rect?.size.height = stringSize.height
                companyDesLabel?.frame = rect!
            }
        }
        
        borrowUseaLabel?.text = GJUtil.isBlankString(String: model.borrowUse)
        repayFromLabel?.text = GJUtil.isBlankString(String: model.repaymentSource)
        
        if model.companyBusinessInfo == "1"{
            businessImageView?.image = UIImage(named:"")
        }else{
            businessImageView?.image = UIImage(named:"")
        }
        
        if model.businessLicense == "1"{
            cardImageView?.image = UIImage(named:"")
        }else{
            cardImageView?.image = UIImage(named:"")
        }
        
        if model.accountPermits == "1"{
            openAccountImageView?.image = UIImage(named:"")
        }else{
            openAccountImageView?.image = UIImage(named:"")
        }
        
        if model.legalPersonIdCard == "1"{
            bossidcardImageView?.image = UIImage(named:"")
        }else{
            bossidcardImageView?.image = UIImage(named:"")
        }
        
        if model.contactInfo == "1"{
            regulationImageView?.image = UIImage(named:"")
        }else{
            regulationImageView?.image = UIImage(named:"")
        }
        
        if model.companyPolicy == "1"{
            contactsImageView?.image = UIImage(named:"")
        }else{
            contactsImageView?.image = UIImage(named:"")
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
