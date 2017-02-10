//
//  config.swift
//  XBook
//
//  Created by apple on 2016/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let MY_FONT = "Bauhaus ITC"

func RGB(r:Float,g:Float,b:Float) -> UIColor{
    return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}
