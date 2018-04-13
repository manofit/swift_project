//
//  PersonInvestDetailModel.swift
//  swift_project
//
//  Created by 高军 on 2018/4/13.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class PersonInvestDetailModel: NSObject {

    var realName = ""
    var hometown = ""
    var birthday = ""
    var workplace_nature = ""
    var marriage = ""
    var industry = ""
    var career = ""
    var total_working_time = ""
    var monthly_salary = ""
    var education = ""
    var borrowUse = ""
    var repaymentSource = ""
    var creditReport = ""
    var workCertification = ""
    var authentication = ""
    var incomeCertification = ""
    var hospitalCertification = ""
    var riskReport = ""
    
    var list = [Dictionary<String, String>]()
    
    var productType = 1
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
