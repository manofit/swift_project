//
//  InvestHistoryCell.swift
//  swift_project
//
//  Created by 高军 on 2018/4/13.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class InvestHistoryCell: UITableViewCell {

    var lenderNameLabel:UILabel?
    var lendCountLabel:UILabel?
    var dateLabel:UILabel?
    
    var backView:UIView?
    
    func createCellWith(Row row:Int){
        backView = GJUtil.createViewWith(Frame: CGRect(x:15, y:0, width:SCREEN_WIDTH-30, height:44), BackgroundColor: UIColor.clear)
        if row % 2 == 0 {
            backView?.backgroundColor = MAIN_WHITE_COLOR
        }else{
            backView?.backgroundColor = UIColor.white
        }
        self.contentView.addSubview(backView!)
        
        lenderNameLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:2, y:10, width:80, height:20), TextColor: LABEL_TEXT_COLOR, Font: 14, TextAligtment: nil)
        self.contentView.addSubview(lenderNameLabel!)
        
        lendCountLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:100, y:10, width:80, height:20), TextColor: LABEL_TEXT_COLOR, Font: 14, TextAligtment: nil)
        self.contentView.addSubview(lendCountLabel!)
        
        dateLabel = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:200, y:10, width:SCREEN_WIDTH-200, height:20), TextColor: LABEL_TEXT_COLOR, Font: 14, TextAligtment: nil)
        self.contentView.addSubview(dateLabel!)
    }
    
    func configCellWith(Model model:InvestHistoryModel){
        lenderNameLabel?.text = GJUtil.isBlankString(String: model.username)
        dateLabel?.text = GJUtil.isBlankString(String: model.addtime)
        lendCountLabel?.text = GJUtil.isBlankString(String: model.money)
    }
    
    func configCellWithNoData(){
        for subView in (backView?.subviews)! {
            let v = subView as UIView
            v.removeFromSuperview()
        }
        
        backView?.backgroundColor = UIColor.white
        
        let imageView = GJUtil.createImageViewWith(Frame: CGRect(x:(SCREEN_WIDTH-100)/2-15, y:40, width:100, height:100), ImageName: "", CornarRadius: 0)
        backView?.addSubview(imageView)
        
        let label = GJUtil.createLabelWith(Text: "暂无记录", Frame: CGRect(x:0, y:imageView.frame.maxY + 10, width:SCREEN_WIDTH - 30, height:30), TextColor: LABEL_TEXT_COLOR, Font: 16, TextAligtment: .center)
        backView?.addSubview(label)
    }

}
