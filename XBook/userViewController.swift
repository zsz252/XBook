//
//  userViewController.swift
//  XBook
//
//  Created by apple on 2016/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class userViewController: UIViewController {
    
    var oLable:UILabel?
    
    var nLable:UILabel?
    
    var rLable:UILabel?
    
    var oPassword:UITextField?
    
    var nPassword:UITextField?
    
    var rPassword:UITextField?
    
    var btn:UIButton?
    
    var titleLable:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.titleLable = UILabel(frame: CGRect(x: 140, y: 60, width: 130, height: 60))
        self.titleLable?.text = "账户管理"
        self.titleLable?.font = UIFont(name: MY_FONT, size: 24)
        self.view.addSubview(self.titleLable!)
        
        self.oLable = UILabel(frame: CGRect(x: 20, y: 160, width: 120, height: 30))
        self.oLable?.text = "旧密码:"
        self.oLable?.font = UIFont(name: MY_FONT, size: 17)
        self.view.addSubview(self.oLable!)
        
        self.nLable = UILabel(frame: CGRect(x: 20, y: 200, width: 120, height: 30))
        self.nLable?.text = "新密码:"
        self.nLable?.font = UIFont(name: MY_FONT, size: 17)
        self.view.addSubview(self.nLable!)
        
        self.rLable = UILabel(frame: CGRect(x: 20, y: 240, width: 120, height: 30))
        self.rLable?.text = "再次输入密码:"
        self.rLable?.font = UIFont(name: MY_FONT, size: 17)
        self.view.addSubview(self.rLable!)
        
        self.oPassword = UITextField(frame: CGRect(x: 140, y: 160, width: 210, height: 30))
        self.oPassword?.borderStyle = .roundedRect
        self.oPassword?.isSecureTextEntry = true
        self.view.addSubview(self.oPassword!)
        
        self.nPassword = UITextField(frame: CGRect(x: 140, y: 200, width: 210, height: 30))
        self.nPassword?.isSecureTextEntry = true
        self.nPassword?.borderStyle = .roundedRect
        self.view.addSubview(self.nPassword!)
        
        self.rPassword = UITextField(frame: CGRect(x: 140, y: 240, width: 210, height: 30))
        self.rPassword?.isSecureTextEntry = true
        self.rPassword?.borderStyle = .roundedRect
        self.view.addSubview(self.rPassword!)
        
        self.btn = UIButton(frame: CGRect(x: 67, y: 350, width: 240, height: 30))
        self.btn?.setTitle("确认修改", for: .normal)
        self.btn?.backgroundColor = UIColor.red
        self.btn?.titleLabel?.font = UIFont(name: MY_FONT, size: 18)
        self.view.addSubview(self.btn!)
        self.btn?.addTarget(self, action: #selector(self.clickedBtn), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.oPassword?.resignFirstResponder()
        self.rPassword?.resignFirstResponder()
        self.nPassword?.resignFirstResponder()
    }
    
    func clickedBtn(){
        let savePassword = UserDefaults.standard
        if self.oPassword?.text != savePassword.object(forKey: "password") as? String {
            ProgressHUD.showError("原密码不正确！")
            self.oPassword?.text = ""
        }else if self.nPassword?.text != self.rPassword?.text {
            ProgressHUD.showError("两次密码输入不正确")
            self.nPassword?.text = ""
            self.rPassword?.text = ""
        }else{
            AVUser.current().updatePassword((self.oPassword?.text)!, newPassword: (self.nPassword?.text)!, block: { (success, error) in
                if (success != nil){
                    ProgressHUD.showSuccess("修改成功")
                }else{
                    ProgressHUD.showError("修改失败")
                }
            })
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
