//
//  pushBook.swift
//  XBook
//
//  Created by apple on 2016/11/2.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class pushBook: NSObject {
    static func pushBookInBackground(dict : NSDictionary , object : AVObject){
//        "BookName":(self.BookTitle?.BookName?.text)!,
//        "BookEditor":self.BookTitle?.BookEditor?.text!,
//        "BookCover":self.BookTitle?.BookCover?.currentImage!,
//        "title":self.BooK_Title,
//        "score":String((self.Score?.show_star)!),
//        "type":self.type,
//        "detailType":self.detailType,
//        "descrption":self.Book_des
        object.setObject(dict["BookName"], forKey: "BookName")
        object.setObject(dict["BookEditor"], forKey: "BookEditor")
        object.setObject(dict["title"], forKey: "title")
        object.setObject(dict["score"], forKey: "score")
        object.setObject(dict["type"], forKey: "type")
        object.setObject(dict["detailType"], forKey: "detailType")
        object.setObject(dict["descrption"], forKey: "descrption")
        object.setObject(AVUser.current(), forKey: "user")
        let image = dict["BookCover"] as? UIImage
        let coverFile = AVFile(data: UIImagePNGRepresentation(image!)!)
        coverFile.saveInBackground { (success, error) in
            if success{
                object.setObject(coverFile, forKey: "cover")
                object.saveInBackground({ (success, error) in
                    if success{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil, userInfo: ["success":"true"])
                    }else{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil, userInfo: ["success":"false"])
                    }
                })
            }else{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushBookNotification"), object: nil, userInfo: ["success":"false"])
            }
        }
    }
}
