//
//  ButtonWithImage.swift
//  LeBoncoin
//
//  Created by dsadaoui on 23/10/2020.
//

import UIKit

class ButtonWithImage: UIView {
    // MARK: Vars
    var action: (() ->Void)? = nil
    private let tapButton = UITapGestureRecognizer()
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
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
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(titleLabel)
        self.addSubview(imageView)
        self.tapButton.addTarget(self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapButton)
        // Add constraints
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 2).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 7).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Handing events
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let action = self.action {
            action()
        }
    }
}
