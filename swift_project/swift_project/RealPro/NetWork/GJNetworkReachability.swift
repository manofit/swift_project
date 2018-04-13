//
//  GJNetworkReachability.swift
//  swift_project
//
//  Created by 高军 on 2018/4/2.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit
import Alamofire


class GJNetworkReachability: NSObject {

    static let reachAbility = GJNetworkReachability()
    
    var reachAble:Bool = {
        var reach = true
        
        let manager = NetworkReachabilityManager(host: "www.baidu.com")
        
        manager?.listener = { status in
            switch status {
            case .notReachable:
                reach = false
                SVProgressHUD.showError(withStatus: "网络出错")
            case .reachable(.ethernetOrWiFi):
                reach = true
            case .reachable(.wwan):
                reach = true
            case .unknown:
                reach = false
                SVProgressHUD.showError(withStatus: "网络出错")
            }
        }
        manager?.startListening()
        
        return reach
    }()
    
}
