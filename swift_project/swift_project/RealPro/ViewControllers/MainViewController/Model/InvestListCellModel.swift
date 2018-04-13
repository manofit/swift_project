//
//  InvestListCellModel.swift
//  swift_project
//
//  Created by 高军 on 2018/4/2.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class InvestListCellModel: NSObject {

    var name = ""
    var account = ""
    var apr = ""
    var nid = ""
    var lowestAccount = ""
    var scales = ""
    var productCategory = 1
    var category = 1
    var timeType = ""
    var time_limit = ""
    var typeStr = ""
    var uuid = ""
    var lastAccount = ""
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "id"{
            nid = value as! String
        }
    }
}
