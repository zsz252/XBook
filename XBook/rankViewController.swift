//
//  rankViewController.swift
//  XBook
//
//  Created by apple on 2016/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class rankViewController: UIViewController,JRSegmentControlDelegate,UITableViewDelegate,UITableViewDataSource{
    var segment:JRSegmentControl?
    var dataArr = NSMutableArray()
    var tableView:UITableView?
    var num = "disNum"
    let numArr = ["disNum","loveNum","scanNum"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "排行榜"
        
        self.view.backgroundColor = UIColor.white
        
        //AVUser.logOut()
        if AVUser.current() == nil  {
            let story = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = story.instantiateViewController(withIdentifier: "Login")
            self.present(loginVC, animated: true, completion: {
                
            })
        }
        
        self.segment = JRSegmentControl(frame: CGRect(x: 0, y: 65, width: 375, height: 20))
        self.segment?.titles = ["评论榜","关注榜","浏览榜"]
        self.segment?.cornerRadius = 5.0
        self.segment?.titleColor = UIColor.white
        self.segment?.indicatorViewColor = UIColor.white
        self.segment?.backgroundColor = UIColor.init(red: 8.0/255, green: 160.0/255, blue: 180.0/255, alpha: 1.0)
        self.segment?.delegate = self
        self.view.addSubview(self.segment!)
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 85, width: 375, height: 500))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(rankTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.footerRefresh))
        self.tableView?.mj_header.beginRefreshing()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** 选中某个按钮时的代理回调 */
    public func segmentControl(_ segment: JRSegmentControl!, didSelectedIndex index: Int) {
        self.num = numArr[index]
        self.tableView?.mj_header.beginRefreshing()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? rankTableViewCell
        
        let dict = self.dataArr[indexPath.row] as? AVObject
        cell?.BookName?.text = "《"+(dict?["BookName"] as! String)+"》"+(dict?["title"] as! String)
        cell?.Editor?.text = "作者："+(dict?["BookEditor"] as! String)
        cell?.rank?.text = "\(indexPath.row+1)"
        if(cell?.rank?.text == "1"){
            cell?.rank?.font = UIFont(name: MY_FONT, size: 36)
            cell?.rank?.textColor = UIColor.red
        }else if(cell?.rank?.text == "2"){
            cell?.rank?.font = UIFont(name: MY_FONT, size: 30)
            cell?.rank?.textColor = UIColor.red
        }else if(cell?.rank?.text == "3"){
            cell?.rank?.font = UIFont(name: MY_FONT, size: 24)
            cell?.rank?.textColor = UIColor.red
        }else{
            cell?.rank?.font = UIFont(name: MY_FONT, size: 16)
            cell?.rank?.textColor = UIColor.red
        }
        
        let date = dict?["createdAt"] as! Date
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm"
        cell?.more?.text = format.string(from: date)
        
        let coverFile = dict?["cover"] as! AVFile
        cell?.cover?.sd_setImage(with: URL(string: (coverFile.url)!), placeholderImage: UIImage(named: "Cover"))
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
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
        query.order(byDescending: num)
        query.limit = 20
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
        query.order(byDescending: num)
        query.limit = 20
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
