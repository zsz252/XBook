//
//  RegisterViewController.swift
//  XBook
//
//  Created by apple on 2016/10/31.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Register(_ sender: AnyObject) {
        let user = AVUser()
        user.username = self.username.text
        user.password = self.password.text
        user.email = self.email.text
        user.signUpInBackground { (success, error) in
            if success{
                ProgressHUD.showSuccess("注册成功，请验证邮箱")
                self.dismiss(animated: true, completion: { 
                    
                })
            }else{
                let e = error as! NSError
                if e.code == 125 {
                    ProgressHUD.showError("邮箱不合法")
                }else if e.code == 203 {
                    ProgressHUD.showError("该邮箱已注册")
                }else if e.code == 202 {
                    ProgressHUD.showError("用户名已存在")
                }else{
                    ProgressHUD.showError("注册失败")
                }
            }
        }
    }

    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true) { 
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
        self.email.resignFirstResponder()
    }

}
