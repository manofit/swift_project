//
//  GJAlertLabel.swift
//  swift_project
//
//  Created by 高军 on 2018/4/16.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class GJAlertLabel: UIView {

    convenience init(Frame frame:CGRect, Text text:String, DismissTime dismissTime:Int){
        self.init(frame: frame)
        
        let label = GJUtil.createLabelWith(Text: text, Frame: frame, TextColor: UIColor.white, Font: 14, TextAligtment: .center)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.isHidden = true
        self.addSubview(label)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(dismissTime)), execute: {
            self.removeFromSuperview()
        })
    }
    

}
