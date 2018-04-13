//
//  GJSegment.swift
//  swift_project
//
//  Created by 高军 on 2018/4/10.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class GJSegment: UIView {

    var titleArray:Array<Any>?{
        didSet{
            createUI()
        }
    }
    
    var buttonClickEvent: ((Int) -> Void)?
    
    func createUI(){
        let w = Int(self.frame.size.width) - (titleArray?.count)! * 70
        let margin = w / ((titleArray?.count)! + 1)
        for i in 0..<(titleArray?.count)! {
            let button = GJUtil.createButtonWith(Type: .custom, Title: titleArray?[i] as? String, Frame: CGRect(x:margin + i * (70 + margin), y:0, width:70, height:Int(self.frame.size.height)), TitleColor: LABEL_TEXT_COLOR, Font: 12, BackgroundColor: UIColor.clear, Target: self, Action: #selector(buttonClick(_:)), TextAligtment: .center)
            button.tag = i + 1
            self.addSubview(button)
            
            let lineView = GJUtil.createViewWith(Frame: CGRect(x:margin + i * (70 + margin), y:Int(self.frame.height - 2), width:70, height:2), BackgroundColor: UIColor.clear)
            lineView.tag = i + 11
            self.addSubview(lineView)
            
            if i == 0 {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                button.setTitleColor(TINT_COLOR, for: .normal)
                lineView.backgroundColor = TINT_COLOR
            }
        }
    }
    
    @objc func buttonClick(_ sender:Any){
        
        let button = sender as! UIButton
        
        if buttonClickEvent != nil {
            buttonClickEvent!(button.tag - 1)
        }
        
        changeButtonAndLineStatus(button.tag)
        
    }
    
    func changeButtonAndLineStatus(_ tag:Int){
        for subView in self.subviews {
            if subView is UIButton {
                if subView.tag != tag {
                    let btn = subView as! UIButton
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                    btn.setTitleColor(LABEL_TEXT_COLOR, for: .normal)
                }else{
                    let btn = subView as! UIButton
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    btn.setTitleColor(TINT_COLOR, for: .normal)
                }
            }
        }
        
        for subView in self.subviews {
            if !(subView is UIButton) {
                if subView.tag != tag + 10 {
                    subView.backgroundColor = UIColor.clear
                }else{
                    subView.backgroundColor = TINT_COLOR
                }
            }
        }
    }

}
