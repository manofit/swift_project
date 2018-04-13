//
//  CompanyInvestDetailModel.swift
//  swift_project
//
//  Created by 高军 on 2018/4/13.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class CompanyInvestDetailModel: NSObject {

    var company_name = ""
    var company_industry = ""
    var company_regtime = ""
    var company_address = ""
    var workplace_nature = ""
    var company_scale = ""
    var introduce = ""
    var borrowUse = ""
    var repaymentSource = ""
    var companyBusinessInfo = ""
    var businessLicense = ""
    var accountPermits = ""
    var legalPersonIdCard = ""
    var companyPolicy = ""
    var contactInfo = ""
    var riskReport = ""
    
    var list = [Dictionary<String, String>]()
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
