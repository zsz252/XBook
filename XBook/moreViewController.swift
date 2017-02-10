//
//  moreViewController.swift
//  XBook
//
//  Created by apple on 2016/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class moreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView?
    
    var qBtn:UIButton?
    
    var img:UIImageView?
    
    var userLable:UILabel?
    
    var arr:NSArray = ["账号管理","帮助提示","关于我们"]
    
    override func viewWillAppear(_ animated: Bool) {
        userLable?.text = AVUser.current()?.username
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //375 667
        self.navigationItem.title = "更多"
        self.view.backgroundColor = UIColor.white
        
        img = UIImageView(frame: CGRect(x: 122, y: 90, width: 130, height: 130))
        img?.image = UIImage(named: "Avatar")
        self.view.addSubview(img!)
        
        userLable = UILabel(frame: CGRect(x: 122, y: 220, width: 130, height: 40))
        userLable?.textAlignment = .center
        userLable?.text = AVUser.current()?.username
        userLable?.font = UIFont(name: MY_FONT, size: 14)
        self.view.addSubview(userLable!)
        
        tableView = UITableView(frame: CGRect(x: 15, y: 280, width: 345, height: 150))
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        
        qBtn = UIButton(frame: CGRect(x: 62, y: 500, width: 250, height: 30))
        qBtn?.titleLabel?.font = UIFont(name: MY_FONT, size: 18)
        qBtn?.setTitle("退出登录", for: .normal)
        qBtn?.backgroundColor = UIColor.red
        qBtn?.addTarget(self, action: #selector(self.quitUser), for: .touchUpInside)
        self.view.addSubview(qBtn!)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.brown
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 16)
        cell.textLabel?.text = arr[indexPath.row] as? String
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let backBtn = UIBarButtonItem()
        backBtn.title = "返回"
        self.navigationItem.backBarButtonItem = backBtn
        self.tabBarController?.tabBar.isHidden = true
        switch indexPath.row {
        case 0:
            let vc = userViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = helpViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = weViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func quitUser(){
        let story = UIStoryboard(name: "Login", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "Login")
        self.present(vc, animated: true, completion: {
            self.tabBarController?.selectedIndex = 0
            AVUser.logOut()
            //self.tabBarController.
            ProgressHUD.showSuccess("退出成功")
        })
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
