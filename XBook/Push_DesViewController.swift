//
//  Push_DesViewController.swift
//  XBook
//
//  Created by apple on 2016/10/28.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

typealias Push_DesViewControllerBlock = (_ description:String) -> Void

class Push_DesViewController: UIViewController {
    
    var textView:JVFloatLabeledTextView?
    var callBack:Push_DesViewControllerBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.textView = JVFloatLabeledTextView(frame: CGRect(x: 8, y: 58, width: SCREEN_WIDTH-16, height: SCREEN_HEIGHT-58-8))
        self.textView?.placeholder = "  你可以在这里吐槽，评价，介绍 (～￣▽￣)～"
        self.textView?.font = UIFont(name: MY_FONT, size: 16)
        self.view.tintColor = UIColor.gray
        self.view.becomeFirstResponder()
        self.view.addSubview(self.textView!)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(){
        self.dismiss(animated: true) {
            
        }
    }
    
    func sure(){
        self.callBack!((self.textView?.text)!)
        self.dismiss(animated: true) { 
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector((keyboardWillHide)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notificaction:NSNotification){
        let dict = NSDictionary(dictionary: notificaction.userInfo!)
        
        let rect = (dict[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        
        self.textView?.contentInset = UIEdgeInsetsMake(0, 0, (rect?.size.height)!, 0)
    }
    
    func keyboardWillHide(notificaction:NSNotification){
        self.textView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
}
