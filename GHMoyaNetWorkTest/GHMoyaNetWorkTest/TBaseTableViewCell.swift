//
//  TBaseTableViewCell.swift
//  GHMoyaNetWorkTest
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 liaoworking. All rights reserved.
//

import UIKit
import Reusable

class TBaseTableViewCell: UITableViewCell, Reusable {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}


