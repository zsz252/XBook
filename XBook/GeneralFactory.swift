//
//  GeneralFactory.swift
//  XBook
//
//  Created by apple on 2016/10/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class GeneralFactory: NSObject {
    static func addTitleWithTile(target:UIViewController,title1:String="关闭",title2:String="确认"){
        let btn1 = UIButton(frame: CGRect(x: 10, y: 20, width: 40, height: 20))
        btn1.setTitle(title1, for: .normal)
        btn1.contentHorizontalAlignment = .left
        btn1.setTitleColor(UIColor.red, for: .normal)
        btn1.titleLabel?.font = UIFont(name: MY_FONT, size: 16)
        btn1.tag = 1234
        target.view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: SCREEN_WIDTH-50, y: 20, width: 40, height: 20))
        btn2.setTitle(title2, for: .normal)
        btn2.contentHorizontalAlignment = .right
        btn2.setTitleColor(UIColor.red, for: .normal)
        btn2.titleLabel?.font = UIFont(name: MY_FONT, size: 16)
        btn2.tag = 1235
        target.view.addSubview(btn2)
        
        btn1.addTarget(target, action: Selector("close"), for: .touchUpInside)
        btn2.addTarget(target, action: Selector("sure"), for: .touchUpInside)
    }
}
