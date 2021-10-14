//
//  SwitchTableViewCell.swift
//  MultipleCellTableView
//
//  Created by Ewen on 2021/10/15.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor     = .blue
        imageView.contentMode   = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor     = .black
        return label
    }()
    
    private let cellSwitch: UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.transform   = CGAffineTransform(scaleX: 0.8, y: 0.8)
        cellSwitch.onTintColor = .systemPink
        return cellSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconImageView)
        iconImageView.anchor(
            leading: contentView.leadingAnchor,
            padding: .init(top: 0, left: 25, bottom: 0, right: 0),
            centerY: contentView.centerYAnchor,
            width: 25, height: 25
        )
        
        contentView.addSubview(label)
        label.anchor(
            leading: iconImageView.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 0),
            centerY: contentView.centerYAnchor
        )
        
        contentView.addSubview(cellSwitch)
        cellSwitch.anchor(
            trailing: contentView.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 30),
            centerY: contentView.centerYAnchor
        )
        
        cellSwitch.addTarget(self, action: #selector(cellSwitchValueChanged), for: .valueChanged)
        
        accessoryType   = .none
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with viewModel: SwitchTableViewCellVM) {
        label.text                  = viewModel.title
        iconImageView.image         = viewModel.iconImage
        iconImageView.tintColor     = viewModel.iconTintColor
        cellSwitch.isOn             = viewModel.isOn
    }
    
    @objc func cellSwitchValueChanged(_ cellSwitch: UISwitch) {
        if cellSwitch.isOn {
            print("Switch is on.")
        } else {
            print("Switch is off.")
        }
    }
}
