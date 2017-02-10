//
//  Push_TittleViewController.swift
//  XBook
//
//  Created by apple on 2016/10/28.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

typealias BookTitleCallBack = ( _ Title:String) -> Void

class Push_TittleViewController: UIViewController {

    var textFiled:UITextField?
    
    var callBack:BookTitleCallBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.textFiled = UITextField(frame: CGRect(x: 15, y: 60, width: SCREEN_WIDTH-30, height: 30))
        self.textFiled?.borderStyle = .roundedRect
        self.textFiled?.placeholder = "书评标题"
        self.textFiled?.font = UIFont(name: MY_FONT, size: 15)
        self.view.addSubview(self.textFiled!)
        
        self.textFiled?.becomeFirstResponder()
        // Do any additional setup after loading the view.
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
        self.callBack?((self.textFiled?.text)!)
        self.dismiss(animated: true) { 
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
