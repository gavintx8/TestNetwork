//
//  TMineTitleCell.swift
//  GHMoyaNetWorkTest
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 liaoworking. All rights reserved.
//

import UIKit
import SnapKit

class TMineTitleCell: TBaseTableViewCell {
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = .gray
        tl.textAlignment = .left
        tl.font = UIFont.systemFont(ofSize: 14)
        return tl
    }()
    
    lazy var contentLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = .red
        tl.textAlignment = .right
        tl.font = UIFont.systemFont(ofSize: 14)
        return tl
    }()
    
    lazy var right: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage.init(named: "rightarrow_8x14_")
        return imv
    }()
    
    lazy var logo: UIImageView = {
        let imv = UIImageView()
        return imv
    }()
    
    override func configUI() {
        separatorInset = .zero
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
            $0.left.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
            $0.left.equalTo(titleLabel.snp.right).offset(5)
        }
        
        contentView.addSubview(right)
        right.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(14)
            $0.width.equalTo(8)
            $0.right.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(logo)
        logo.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(58)
            $0.width.equalTo(58)
            $0.right.equalToSuperview().offset(-20)
        }
    }
}

