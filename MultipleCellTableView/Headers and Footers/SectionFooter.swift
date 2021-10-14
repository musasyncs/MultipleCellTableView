//
//  SectionFooter.swift
//  MultipleCellTableView
//
//  Created by Ewen on 2021/10/15.
//

import UIKit

class SectionFooter: UITableViewHeaderFooterView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image         = UIImage(named: "tinder")
        imageView.contentMode   = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text          = "第 12.18.1(12180137) 版"
        label.textColor     = .systemGray
        label.font          = .systemFont(ofSize: 8, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let bgView = UIView()
        bgView.backgroundColor = .clear
        backgroundView = bgView
        
        contentView.addSubview(iconImageView)
        iconImageView.anchor(
            top: contentView.topAnchor,
            padding: .init(top: 30, left: 0, bottom: 0, right: 0),
            centerX: contentView.centerXAnchor,
            width: 28, height: 28
        )
        
        contentView.addSubview(label)
        label.anchor(
            top: iconImageView.bottomAnchor,
            padding: .init(top: 5, left: 0, bottom: 0, right: 0),
            centerX: contentView.centerXAnchor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

