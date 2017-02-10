//
//  searchViewController.swift/Users/apple/Desktop/workspace/XBook/XBook/rankTableViewCell.swift
//  XBook
//
//  Created by apple on 2016/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class searchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dataArr = NSMutableArray()
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "发现"
        
        self.view.backgroundColor = UIColor.white
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(searchTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.footerRefresh))
        self.tableView?.mj_header.beginRefreshing()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? searchTableViewCell
        
        let dict = self.dataArr[indexPath.row] as? AVObject
        cell?.BookName?.text = "《"+(dict?["BookName"] as! String)+"》"+(dict?["title"] as! String)
        cell?.Editor?.text = "作者："+(dict?["BookEditor"] as! String)
        cell?.userName?.text = "编者："+(dict?["user"] as! AVUser).username!
        
        let date = dict?["createdAt"] as! Date
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm"
        cell?.date?.text = "发布时间："+format.string(from: date)
        cell?.more?.text = "书评:"+(dict?["descrption"] as? String)!
        let score = dict?["score"] as! String
        cell?.score?.show_star = Int(score)!
        cell?.type?.text = "类型:"+(dict?["detailType"] as? String)!
        
        let coverFile = dict?["cover"] as! AVFile
        cell?.cover?.sd_setImage(with: URL(string: (coverFile.url)!), placeholderImage: UIImage(named: "Cover"))
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        let vc = BookDetailViewController()
        vc.BookObject = self.dataArr[indexPath.row] as? AVObject
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func headerRefresh(){
        let query = AVQuery(className: "Book")
        query.order(byDescending: "createdAt")
        query.limit = 5
        query.skip = 0
        query.includeKey("user")
        query.findObjectsInBackground { (results, error) in
            self.tableView?.mj_header.endRefreshing()
            self.dataArr.removeAllObjects()
            self.dataArr.addObjects(from: results!)
            self.tableView?.reloadData()
        }
    }
    
    func footerRefresh(){
        let query = AVQuery(className: "Book")
        query.order(byDescending: "createdAt")
        query.limit = 5
        query.skip = self.dataArr.count
        query.includeKey("user")
        query.skip = self.dataArr.count
        query.findObjectsInBackground { (results, error) in
            self.tableView?.mj_footer.endRefreshing()
            self.dataArr.addObjects(from: results!)
            self.tableView?.reloadData()
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
