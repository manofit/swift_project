//
//  VariableDefineFile.swift
//  swift_project
//
//  Created by 高军 on 2018/4/2.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SCREEN_MAX_LENGTH  = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let IS_IPHONE_4_OR_LESS = SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5 = SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6 = SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P = SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_X = SCREEN_MAX_LENGTH == 812.0

let STATUS_NAV_BAR_Y:CGFloat = IS_IPHONE_X == true ? 88.0 : 64.0
let TABBAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 83.0 : 49.0
let STATUSBAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 44.0 : 20.0

/*
 * 颜色
 */
let TINT_COLOR = UIColor(red: 164.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
let TABBAR_TINT_COLOR = UIColor(red: 237.0/255, green: 31.0/255, blue: 59.0/255, alpha: 1.0)
let MAIN_WHITE_COLOR = UIColor(red: 242.0/255, green: 242.0/255, blue: 242.0/255, alpha: 1.0)
let LABEL_TEXT_COLOR = UIColor.gray
let INVEST_PERSON = UIColor(red: 34.0/255, green: 160.0/255, blue: 43.0/255, alpha: 1.0)
let INVEST_COM = UIColor(red: 237.0/255, green: 31.0/255, blue: 59.0/255, alpha: 1.0)
let INVEST_NEW = UIColor(red: 253.0/255, green: 143.0/255, blue: 27.0/255, alpha: 1.0)
let BTN_BACK_COLOR = UIColor(red: 18.0/255, green: 147.0/255, blue: 255.0/255, alpha: 1.0)
let LABEL_BLACK_COLOR = UIColor(red: 30.0/255, green: 30.0/255, blue: 30.0/255, alpha: 1.0)
