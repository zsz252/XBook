//
//  helpViewController.swift
//  XBook
//
//  Created by apple on 2016/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class helpViewController: UIViewController {
    
    var titleLable:UILabel?
    
    var text:UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.titleLable = UILabel(frame: CGRect(x: 140, y: 60, width: 130, height: 60))
        self.titleLable?.text = "帮助提示"
        self.titleLable?.font = UIFont(name: MY_FONT, size: 24)
        self.view.addSubview(self.titleLable!)
        
        self.text = UITextView(frame: CGRect(x: 20, y: 140, width: 340, height: 500))
        self.text?.text = "    看书是指第二对脑神经在工作，两眼直视书本内容，全神贯注，通过视神经将书本内容传递给脑中枢。\n   一般人的正常阅读速度是200字/分，但受过快速阅读训练的人的一般阅读速度是300字/分。但这要经过刻苦的训练啊。先训练默读，做到不出声音不受干扰，专心致志；再训练读目录和标题，在阅读中紧紧抓住段落的核心；再训练扫描读，像摄像机一样工作，而不是数人头式地阅读，从第一个字读到最后一个字；再训练段读，用抓关键词的方法，几秒钟就抓住一段文字中的关键词，一次性阅读一个段落。一点一滴地强化，才可能最终突破。"
        self.text?.font = UIFont(name: MY_FONT, size: 18)
        self.view.addSubview(self.text!)
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
