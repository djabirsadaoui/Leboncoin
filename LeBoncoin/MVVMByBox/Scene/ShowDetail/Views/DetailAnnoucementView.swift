//
//  DetailAnnoucementView.swift
//  LeBoncoin
//
//  Created by dsadaoui on 26/10/2020.
//

import UIKit

class DetailAnnoucementView: UIView {
    //MARK: Vars
    var annoucement: Announcement? {
        didSet {
            guard let annoucementItem = annoucement else {return}
            titleLabel.text = annoucementItem.title
            categoryLabel.text = "Category: \(annoucementItem.categoryName ?? "")"
            priceLabel.text = "\(annoucementItem.price)€"
            if let url = annoucementItem.imagesURL.thumb {
                imageView.download(from: url)
            }
            creationDateLabel.text = annoucementItem.creationDate.dateFromString()
            urgentLabel.isHidden = !annoucementItem.isUrgent
            detailLabel.text = "Detail: \n\(annoucementItem.welcomeDescription)"
            if let siret = annoucementItem.siret {
                siretLabel.text = "Siret: \(siret)"
            }
        }
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let imageView: MyImageView = {
        let img = MyImageView()
        img.translatesAutoresizingMaskIntoConstraints = false 
        img.clipsToBounds = true
        return img
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .firstColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let siretLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
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
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    let creationDateLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
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
    let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        // Set stackView
        dateStackView.addArrangedSubview(creationDateLabel)
        dateStackView.addArrangedSubview(categoryLabel)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(priceLabel)
        containerView.addArrangedSubview(urgentLabel)
        containerView.addArrangedSubview(siretLabel)
        // Add subview
        scrollView.addSubview(dateStackView)
        scrollView.addSubview(containerView)
        scrollView.addSubview(detailLabel)
        self.addSubview(imageView)
        self.addSubview(scrollView)
        //Constrain imageView
        imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        //Constrain scroll view
        scrollView.contentSize = CGSize(width: self.frame.width, height: self.frame.height - (imageView.frame.height + 20))
        scrollView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10).isActive = true;
        scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true;
        scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true;
        scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true;
        //Constraint dateStackView
        dateStackView.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        dateStackView.leadingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        dateStackView.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        dateStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //Constraint containerView
        containerView.topAnchor.constraint(equalTo:self.dateStackView.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant:-10).isActive = true
        //Constraint detailLabel
        detailLabel.topAnchor.constraint(equalTo:self.containerView.bottomAnchor, constant: 15).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo:self.scrollView.safeAreaLayoutGuide.leadingAnchor, constant:10).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo:self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant:-10).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
