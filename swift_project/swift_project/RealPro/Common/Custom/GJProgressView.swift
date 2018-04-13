//
//  GJProgressView.swift
//  swift_project
//
//  Created by 高军 on 2018/4/12.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class GJProgressView: UIView {

    var mainPathWidth:CGFloat = 0.0
    
    lazy var proLabel:UILabel? = {
        let label = GJUtil.createLabelWith(Text: "", Frame: CGRect(x:0, y:0, width:self.bounds.size.width, height:self.bounds.size.height), TextColor: UIColor.white, Font: self.bounds.size.width/6, TextAligtment: .center)
        label.center = CGPoint(x:self.bounds.size.width/2, y:self.bounds.size.height/2)
        self.addSubview(label)
        
        return label
    }()
    
    var proLabelNum = 1
    var progress = 1
    
    lazy var backPathLayer:CAShapeLayer? = {
        let pathLay = CAShapeLayer()
        pathLay.fillColor = UIColor.clear.cgColor
        pathLay.strokeColor = UIColor.white.withAlphaComponent(0.5).cgColor
        pathLay.lineWidth = mainPathWidth
        self.layer.addSublayer(pathLay)
        
        return pathLay
    }()
    
    lazy var mainPathLayer:CAShapeLayer? = {
        let pathLay = CAShapeLayer()
        pathLay.fillColor = UIColor.clear.cgColor
        pathLay.strokeColor = UIColor.white.cgColor
        pathLay.lineWidth = mainPathWidth
        self.layer.addSublayer(pathLay)
        
        return pathLay
    }()
    
    var proLabelTimer:Timer?
    
    func drawCircleWith(Progress pro:Int){
        progress = pro
        proLabelNum = 0
        
        let backPath = UIBezierPath(arcCenter: CGPoint(x:self.bounds.size.width/2, y:self.bounds.size.height/2), radius: self.bounds.size.width/2 - mainPathWidth, startAngle: .pi, endAngle: .pi * 3, clockwise: true)
        
        let mainPath = UIBezierPath(arcCenter: CGPoint(x:self.bounds.size.width/2, y:self.bounds.size.height/2), radius: self.bounds.size.width/2 - mainPathWidth + 3, startAngle: .pi, endAngle: .pi * 3, clockwise: true)
        
        backPathLayer?.path = backPath.cgPath
        mainPathLayer?.path = mainPath.cgPath
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = CFTimeInterval(pro/100)
        animation.fromValue = NSNumber.init(value: 0.0)
        animation.toValue = NSNumber.init(value: pro/100)
        animation.fillMode = "forwards"
        animation.isRemovedOnCompletion = false
        mainPathLayer?.add(animation, forKey: "strokeEndAnimation")
        
        if progress > 0 {
            DispatchQueue.global().async(execute: {
                self.proLabelTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.proLabelTimerAction), userInfo: nil, repeats: true)
                RunLoop.current.run()
            })
        }else{
            proLabel?.text = "0%"
        }
    }
    
    @objc func proLabelTimerAction(){
        DispatchQueue.main.async {
            self.proLabel?.text = "\(self.proLabelNum)"
        }
        
        if proLabelNum >= progress {
            proLabelTimer?.invalidate()
            proLabelTimer = nil
        }else{
            proLabelNum += 1
        }
    }
    

}
