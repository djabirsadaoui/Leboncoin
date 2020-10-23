//
//  AnnoucementCellView.swift
//  LeBoncoin
//
//  Created by dsadaoui on 22/10/2020.
//

import UIKit

class AnnoucementCellView: UITableViewCell {
    static let identifier = "AnnoucementCellView"
    var annoucement: Announcement? {
        didSet {
            guard let annoucementItem = annoucement else {return}
            titleLabel.text = annoucementItem.title
            categoryLabel.text = "\(annoucementItem.categoryID)"
            priceLabel.text = "\(annoucementItem.price)€"
            if let url = annoucementItem.imagesURL.small {
                annoucementImageView.downloaded(from: url)
            }
            urgentLabel.isHidden = !(annoucement?.isUrgent ?? false)
        }
    }
    
    let annoucementImageView:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 80/4
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .firstColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    let urgentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.text = "Urgent"
        label.textColor = .thirdColor
        label.backgroundColor = .secondColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .thirdColor
        return label
    }()
    
    let containerView:UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(annoucementImageView)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(priceLabel)
        containerView.addArrangedSubview(categoryLabel)
        containerView.addArrangedSubview(urgentLabel)
        self.contentView.addSubview(containerView)
        annoucementImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        annoucementImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        annoucementImageView.widthAnchor.constraint(equalToConstant:80).isActive = true
        annoucementImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:5).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.annoucementImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor,constant:-5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
