//
//  UIBarButtonItem+Extension.swift
//  swift_project
//
//  Created by 高军 on 2018/4/3.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    func barButtonItemWith(Target target:Any?, Action action:Selector?, NormalImage normalImage:UIImage?, HighLightedImage highLightImage:UIImage?) -> UIBarButtonItem{
        let btn = UIButton(type:.custom)
        if target != nil && action != nil {
            btn.addTarget(target, action: action!, for: .touchUpInside)
        }
        if normalImage != nil {
            btn.setBackgroundImage(normalImage, for: .normal)
        }
        if highLightImage != nil {
            btn.setBackgroundImage(highLightImage, for: .highlighted)
        }
        return UIBarButtonItem(customView: btn)
    }
    
}
