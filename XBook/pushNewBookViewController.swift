//
//  pushNewBookViewController.swift
//  XBook
//
//  Created by apple on 2016/10/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class pushNewBookViewController: UIViewController,BookTitleDelegate,PhotoPickerDelegate,VPImageCropperDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var BookTitle:BookTitleView?
    
    var tableView:UITableView?
    
    var titleArray:Array<String>=[]
    
    var BooK_Title=""
    
    var Score:LDXScore?
    
    var showScore = false
    
    var type="文学"
    var detailType="文学"
    
    var Book_des=""
    
    //编辑
    var BookObject:AVObject?
    var fixType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.BookTitle = BookTitleView.init(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 160))
        self.BookTitle?.delegate = self
        self.view.addSubview(BookTitle!)
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 300, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-300))
        //使tableview空的线条消失
        self.tableView?.tableFooterView = UIView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.backgroundColor = UIColor(colorLiteralRed: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.tableView?.separatorStyle = .singleLineEtched
        self.view.addSubview(self.tableView!)
        
        self.titleArray = ["标题","评分","分类","书评"]
        
        self.Score = LDXScore(frame: CGRect(x: 100, y: 10, width: 100, height: 22))
        self.Score?.isSelect = true
        self.Score?.normalImg = UIImage(named:"btn_star_evaluation_normal")
        self.Score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.Score?.max_star = 5
        self.Score?.show_star = 5
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.pushBookNotification(notification:)), name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil)
        
    }
    
    func fixBook(){
        if self.fixType == "fix" {
            self.BookTitle?.BookName?.text = self.BookObject?["BookName"] as? String
            self.BookTitle?.BookEditor?.text = self.BookObject?["BookEditor"] as? String
            let coverFile = self.BookObject?["cover"] as? AVFile
            coverFile?.getDataInBackground({ (data, error) in
                self.BookTitle?.BookCover?.setImage(UIImage(data:data!), for: .normal)
            })
            
            self.BooK_Title = (self.BookObject?["title"] as? String)!
            self.type = self.BookObject?["type"] as! String
            self.detailType = (self.BookObject?["detailType"] as? String)!
            self.Book_des = (self.BookObject?["descrption"] as? String)!
            self.Score?.show_star = (Int)((self.BookObject!["score"] as? String)!)!
            if self.Book_des != ""{
                self.titleArray.append("")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    func pushBookNotification(notification : Notification){
        let dict = notification.userInfo
        let s = dict?["success"] as! String
        if s == "true"{
            if self.fixType == "fix"{
                ProgressHUD.showSuccess("修改成功")
            }else{
                ProgressHUD.showSuccess("上传成功")
            }
            self.dismiss(animated: true, completion: {
                
            })
        }else{
            ProgressHUD.showError("上传失败")
        }
    }
    
    func close(){
        self.dismiss(animated: true) { 
            
        }
    }
    
    func sure(){
        let dict = [
            "BookName":(self.BookTitle?.BookName?.text)!,
            "BookEditor":(self.BookTitle?.BookEditor?.text)!,
            "BookCover":(self.BookTitle?.BookCover?.currentImage)!,
            "title":self.BooK_Title,
            "score":String((self.Score?.show_star)!),
            "type":self.type,
            "detailType":self.detailType,
            "descrption":self.Book_des
        ] as [String : Any]
        if self.fixType == "fix" {
            pushBook.pushBookInBackground(dict: dict as NSDictionary , object: self.BookObject! )
        }else {
            let object = AVObject(className: "Book")
            pushBook.pushBookInBackground(dict: dict as NSDictionary, object: object!)
        }
    }
    //键盘隐藏
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.BookTitle?.BookEditor?.resignFirstResponder()
        self.BookTitle?.BookName?.resignFirstResponder()
    }
    //图片选择
    func choiceCover(){
        let vc = PhotoPickerViewController()
        vc.delegate = self
        self.present(vc, animated: true) { 
            
        }
    }
    
    
    func getImageFromPicker(image: UIImage) {
        let CroVC = VPImageCropperViewController(image: image, cropFrame: CGRect(x:0,y:100,width:SCREEN_WIDTH,height:SCREEN_WIDTH*1.273), limitScaleRatio: 3)
        CroVC?.delegate = self
        
        self.present(CroVC!, animated: true) { 
            
        }
    }
    
    //VPImageDelegete
    func imageCropperDidCancel(_ cropperViewController: VPImageCropperViewController!) {
        cropperViewController.dismiss(animated: true) { 
            
        }
    }
    
    func imageCropper(_ cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        self.BookTitle?.BookCover?.setImage(editedImage, for: .normal)
        cropperViewController.dismiss(animated: true) { 
            
        }
    }
    
    //uitableView代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        if(indexPath.row != 1 ){
            if(!(indexPath.row == 2 && self.showScore)){
                cell.accessoryType = .disclosureIndicator
            }
        }
        
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 15)
        cell.detailTextLabel?.font = UIFont(name: MY_FONT, size: 13)
        var row = indexPath.row
        if row>=2 && self.showScore{
            row -= 1
        }
        switch row {
        case 0:
            cell.detailTextLabel?.text = self.BooK_Title
            break
        case 2:
            cell.detailTextLabel?.text = self.type + "->" + self.detailType
        case 4:
            cell.accessoryType = .none
            let commentView = UITextView(frame: CGRect(x: 4, y: 4, width: SCREEN_WIDTH-8, height: 80))
            commentView.text = self.Book_des
            commentView.font = UIFont(name: MY_FONT, size: 13)
            commentView.textColor = UIColor.brown
            commentView.isUserInteractionEnabled = false
            cell.contentView.addSubview(commentView)
            break
        default:
            break
        }
        if indexPath.row == 2 && self.showScore{
            cell.contentView.addSubview(Score!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showScore && indexPath.row >= 5{
            return 88
        }else if !showScore && indexPath.row >= 4{
            return 88
        }else{
            return 44
        }
    }
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        var row = indexPath.row
        if self.showScore && row>=2 {
            row -= 1
        }
        switch row {
            case 0:
                tableViewSelectTitle()
                break
            case 1:
                tableViewSelectScore()
                break
            case 2:
                tableViewSeclectType()
                break
            case 3:
                tableViewSeclectDescrption()
                break
            default:
                break
        }
    }
    //选择标题
    func tableViewSelectTitle(){
        let vc = Push_TittleViewController()
        GeneralFactory.addTitleWithTile(target: vc)
        weak var wself = self
        vc.callBack = ({(Title:String) -> Void in
            wself?.BooK_Title = Title
            wself?.tableView?.reloadData()
        })
        self.present(vc, animated: true) { 
            
        }
    }
    //选择评分
    func tableViewSelectScore(){
        
        self.tableView?.beginUpdates()
        let tempIndexPath = [NSIndexPath(row: 2, section: 0)]
        
        if showScore{
            self.titleArray.remove(at: 2)
            self.tableView?.deleteRows(at: tempIndexPath as [IndexPath], with: .right)
            self.showScore = false
            
        }else{
            self.titleArray.insert("", at: 2)
            self.tableView?.insertRows(at: tempIndexPath as [IndexPath] , with: .left)
            self.showScore = true
        }
        self.tableView?.endUpdates()
    }
    //选择分类
    func tableViewSeclectType(){
        let vc = Push_typeViewController()
        GeneralFactory.addTitleWithTile(target: vc)
        
        let btn1 = vc.view.viewWithTag(1234) as! UIButton
        let btn2 = vc.view.viewWithTag(1235) as! UIButton
        btn1.setTitleColor(RGB(r: 38, g: 82, b: 67), for: .normal)
        btn2.setTitleColor(RGB(r: 38, g: 82, b: 67), for: .normal)
        weak var wself = self
        vc.callBack = ({(type:String , detailType:String) ->Void in
            wself?.type = type
            wself?.detailType = detailType
            wself?.tableView?.reloadData()
        })
        
        self.present(vc, animated: true) {
            
        }
    }
    //选择书评
    func tableViewSeclectDescrption(){
        let vc = Push_DesViewController()
        weak var wself = self
        GeneralFactory.addTitleWithTile(target: vc)
        vc.textView?.text = wself?.Book_des
        vc.callBack = ({(description:String) -> Void in
            wself?.Book_des = description
            if wself?.titleArray.last == ""{
                wself?.titleArray.removeLast()
            }
            if wself?.Book_des != ""{
                wself?.titleArray.append("")
            }
            wself?.tableView?.reloadData()
        })
        self.present(vc, animated: true) {
            
        }
    }
}
