//
//  discussCell.swift
//  XBook
//
//  Created by apple on 2016/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class discussCell: UITableViewCell {
    
    var avatarImage:UIImageView?
    
    var nameLabel:UILabel?
    
    var detailLable:UILabel?
    
    var dateLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func initFrame(){
        for view in self.contentView.subviews{
            view.removeFromSuperview()
        }
    
        self.avatarImage = UIImageView(frame: CGRect(x: 8, y: 8, width: 40, height: 40))
        self.avatarImage?.layer.cornerRadius = 20
        self.avatarImage?.layer.masksToBounds = true
        self.contentView.addSubview(self.avatarImage!)
    
        self.nameLabel = UILabel(frame: CGRect(x: 56, y: 8, width: SCREEN_WIDTH-56-8, height: 15))
        self.nameLabel?.font = UIFont(name: MY_FONT, size: 13)
        self.contentView.addSubview(self.nameLabel!)
    
        self.dateLabel = UILabel(frame: CGRect(x: 56, y: self.frame.size.height-8-10, width: SCREEN_WIDTH-56-8, height: 10))
        self.dateLabel?.font = UIFont(name: MY_FONT, size: 13)
        self.dateLabel?.textColor = UIColor.gray
        self.contentView.addSubview(self.dateLabel!)
    
        self.detailLable = UILabel(frame: CGRect(x: 56, y: 30, width: SCREEN_WIDTH-56-8, height: self.frame.size.height-30-25))
        self.detailLable?.font = UIFont(name: MY_FONT, size: 15)
        self.detailLable?.numberOfLines = 0
        self.contentView.addSubview(self.detailLable!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
