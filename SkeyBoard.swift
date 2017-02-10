//
//  SkeyBoard.swift
//  XBook
//
//  Created by apple on 2016/10/30.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
struct SKeyBoard {
    
    // 注册键盘出现
    static func registerKeyBoardShow(target: UIViewController) {
        NotificationCenter.default.addObserver(target, selector: #selector(KeyBoardDelegate.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // 注册键盘隐藏
    static func registerKeyBoardHide(target: UIViewController) {
        NotificationCenter.default.addObserver(target, selector: #selector(KeyBoardDelegate.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // 移除键盘出现通知
    static func removeKeyboardNotifications(target: UIViewController) {
        NotificationCenter.default.removeObserver(target, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // 移除键盘隐藏通知
    static func removeKeyboardHideNotifications(target: UIViewController) {
        NotificationCenter.default.removeObserver(target, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // 返回键盘高度
    static func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    // 返回键盘上拉动画持续时间
    static func getKeyBoardDuration(notification: NSNotification) -> Double {
        let userInfo = notification.userInfo
        let keyboardDuration = userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        return keyboardDuration
    }
    
    // 返回键盘动画曲线
    static func getKeyBoardAnimationCurve(notification: NSNotification) -> NSObject {
        let userInfo = notification.userInfo
        let keyboardTranstionAnimationCurve = userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSValue
        
        return keyboardTranstionAnimationCurve
    }
    
    
}
