//
//  rankTableViewCell.swift
//  XBook
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class rankTableViewCell: UITableViewCell {
    
    var BookName:UILabel?
    var Editor:UILabel?
    var more:UILabel?
    var cover:UIImageView?
    var rank:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.BookName = UILabel(frame: CGRect(x: 78, y: 8, width: 242, height: 25))
        self.Editor = UILabel(frame: CGRect(x: 78, y: 33, width: 242, height: 25))
        self.more = UILabel(frame: CGRect(x: 78, y: 66, width: 242, height: 25))
        
        self.BookName?.font = UIFont(name: MY_FONT, size: 15)
        self.Editor?.font = UIFont(name: MY_FONT, size: 15)
        self.more?.font = UIFont(name: MY_FONT, size: 13)
        self.more?.textColor = UIColor.gray
        
        self.contentView.addSubview(self.BookName!)
        self.contentView.addSubview(self.Editor!)
        self.contentView.addSubview(self.more!)
        
        self.cover = UIImageView(frame: CGRect(x: 8, y: 9, width: 56, height: 70))
        self.contentView.addSubview(self.cover!)
        
        self.rank = UILabel(frame: CGRect(x: 330, y: 33, width: 40, height: 40))
        self.contentView.addSubview(self.rank!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
