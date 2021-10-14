//
//  GalleryCollectionViewCell.swift
//  MultipleCellTableView
//
//  Created by Ewen on 2021/10/15.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font      = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode        = .scaleAspectFill
        imageView.clipsToBounds      = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius  = 5
        
        addSubview(imageView)
        imageView.fillSuperView()
        
        imageView.addSubview(nameLabel)
        nameLabel.anchor(
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 0, left: 10, bottom: 30, right: 0)
        )
                
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        imageView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: GalleryCollectionViewCellVM) {
        nameLabel.text  = viewModel.title
        imageView.image = UIImage(named: viewModel.imageName)
    }

}
