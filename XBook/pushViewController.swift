//
//  pushViewController.swift
//  XBook
//
//  Created by apple on 2016/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class pushViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate {

    var dataArray = NSMutableArray()
    var tableView:UITableView?
    var navigationView:UIView?
    var swipeCell:IndexPath?
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView?.mj_header.beginRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.setNavigatioBar()
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        self.tableView?.register(pushBook_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.footerRefresh))
        
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationView?.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationView?.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavigatioBar(){
        
        navigationView = UIView(frame: CGRect(x: 0, y: -20, width: SCREEN_WIDTH, height: 65))
        navigationView?.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.addSubview(navigationView!)
        
        let addBookBtn = UIButton(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH, height: 45))
        addBookBtn.setImage(UIImage(named:"plus circle"), for: .normal)
        addBookBtn.setTitleColor(UIColor.black, for: .normal)
        addBookBtn.setTitle("   新建书评", for: .normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .left
        
        addBookBtn.addTarget(self, action: #selector(pushViewController.pushNewBook), for: .touchUpInside)
        
        navigationView?.addSubview(addBookBtn)
        
    }
    
    func pushNewBook(){
        let vc = pushNewBookViewController()
        GeneralFactory.addTitleWithTile(target: vc, title1:"返回", title2:"发布")
        self.present(vc, animated: true) { 
           
        }
    }
    
    //uitableview代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? pushBook_Cell
        
        cell?.rightUtilityButtons = self.returnRightBtn()
        cell?.delegate = self
        
        let dict = self.dataArray[indexPath.row] as? AVObject
        cell?.BookName?.text = "《"+(dict?["BookName"] as! String)+"》"+(dict?["title"] as! String)
        cell?.Editor?.text = "作者："+(dict?["BookEditor"] as! String)
        
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
        vc.BookObject = self.dataArray[indexPath.row] as? AVObject
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func returnRightBtn()->[AnyObject]{
        let btn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        btn1.backgroundColor = UIColor.orange
        btn1.setTitle("编辑", for: .normal)
        
        let btn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        btn2.backgroundColor = UIColor.red
        btn2.setTitle("删除", for: .normal)
        return [btn1,btn2]
    }
    
    //SWTableViewCellDelegate
    func swipeableTableViewCell(_ cell: SWTableViewCell!, scrollingTo state: SWCellState) {
        let indexPath = self.tableView?.indexPath(for: cell)
        if state == .cellStateRight{
            if self.swipeCell != nil && self.swipeCell?.row != indexPath?.row {
                let swipedCell = self.tableView?.cellForRow(at: self.swipeCell!) as? pushBook_Cell
                swipedCell?.hideUtilityButtons(animated: true)
            }
            self.swipeCell = indexPath
        }else if state == .cellStateCenter{
            self.swipeCell = nil
        }
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerRightUtilityButtonWith index: Int) {
        cell.hideUtilityButtons(animated: true)
        
        let indexPath = self.tableView?.indexPath(for: cell)
        
        let object = self.dataArray[(indexPath?.row)!] as? AVObject
        
        if index == 0 {
            let vc = pushNewBookViewController()
            GeneralFactory.addTitleWithTile(target: vc,title1: "关闭", title2: "发布")
            
            vc.fixType = "fix"
            vc.BookObject = object
            vc.fixBook()
            self.present(vc, animated: true, completion: { 
                
            })
        }else{
            ProgressHUD.show("")
            
            let disscussQuery = AVQuery(className: "discuss")
            disscussQuery.whereKey("BookObject", equalTo: object!)
            disscussQuery.findObjectsInBackground({ (results, error) in
                for Book in results! {
                    let BookObject = Book as? AVObject
                    BookObject?.deleteInBackground()
                }
            })
            
            let loveQuery = AVQuery(className: "Love")
            loveQuery.whereKey("BookObject", equalTo: object!)
            loveQuery.findObjectsInBackground({ (results, error) in
                for Book in results! {
                    let BookObject = Book as? AVObject
                    BookObject?.deleteInBackground()
                }
            })
            
            object?.deleteInBackground({ (success, error) in
                if success{
                    ProgressHUD.showSuccess("删除成功")
                    self.dataArray.removeObject(at: (indexPath?.row)!)
                    self.tableView?.reloadData()
                }else{
                    
                }
            })
        }
    }
    
    //上拉加载 下拉刷新
    func headerRefresh(){
        let query = AVQuery(className: "Book")
        query.order(byDescending: "createdAt")
        
        query.limit = 20
        query.skip = 0
        query.whereKey("user", equalTo: AVUser.current())
        query.findObjectsInBackground { (results, error) in
            self.tableView?.mj_header.endRefreshing()
            self.dataArray.removeAllObjects()
            self.dataArray.addObjects(from: results!)
            self.tableView?.reloadData()
        }
    }
    
    func footerRefresh(){
        let query = AVQuery(className: "Book")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
        query.whereKey("user", equalTo: AVUser.current())
        query.findObjectsInBackground { (results, error) in
            self.tableView?.mj_footer.endRefreshing()
            self.dataArray.addObjects(from: results!)
            self.tableView?.reloadData()
        }
    }
}
