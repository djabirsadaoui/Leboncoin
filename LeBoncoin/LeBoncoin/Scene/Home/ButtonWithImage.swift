//
//  ButtonWithImage.swift
//  LeBoncoin
//
//  Created by dsadaoui on 23/10/2020.
//

import UIKit

class ButtonWithImage: UIView {

    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let tapButton = UITapGestureRecognizer()
    var action: (() ->Void)? = nil
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
   
    override init(frame: CGRect) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(titleLabel)
        self.addSubview(imageView)
        self.tapButton.addTarget(self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapButton)
    }
    
    override func layoutSubviews() {
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 2).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let action = self.action {
            action()
        }
    }
}
