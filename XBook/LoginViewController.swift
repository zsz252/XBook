//
//  LoginViewController.swift
//  XBook
//
//  Created by apple on 2016/10/31.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(_ sender: AnyObject) {
        AVUser.logInWithUsername(inBackground: self.username.text! , password: self.password.text!) { (user, error) in
            if error == nil {
                self.dismiss(animated: true, completion: { 
                    let savePassword = UserDefaults.standard
                    savePassword.set(self.password.text, forKey: "password")
                })
            }else{
                let e = error as! NSError
                if e.code == 210{
                    ProgressHUD.showError("用户名或密码错误")
                }else if e.code == 211{
                    ProgressHUD.showError("不存在该用户")
                }else if e.code == 216{
                    ProgressHUD.showError("未验证邮箱")
                }else if e.code == 1{
                    ProgressHUD.showError("操作频繁")
                }else{
                    ProgressHUD.showError("登录失败")
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
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
