//
//  weViewController.swift
//  XBook
//
//  Created by apple on 2016/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class weViewController: UIViewController {
    
    var titleLable:UILabel?
    
    var text:UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.titleLable = UILabel(frame: CGRect(x: 140, y: 60, width: 130, height: 60))
        self.titleLable?.text = "关于我们"
        self.titleLable?.font = UIFont(name: MY_FONT, size: 24)
        self.view.addSubview(self.titleLable!)
        
        self.text = UITextView(frame: CGRect(x: 20, y: 140, width: 340, height: 500))
        self.text?.text = "我们的目标是没有蛀牙"
        self.text?.font = UIFont(name: MY_FONT, size: 18)
        self.view.addSubview(self.text!)

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
