//
//  DetailAnnoucementViewController.swift
//  LeBoncoin
//
//  Created by dsadaoui on 22/10/2020.
//

import UIKit

class DetailAnnoucementViewController: UIViewController {
    //MARK: Vars
    var annoucement: Announcement
    
    //MARK: Initializer
    init(annoucement: Announcement) {
        self.annoucement = annoucement
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigation()
        self.configure()
    }
    
    //MARK: setup the view
    func setUpNavigation() {
        self.navigationController?.navigationBar.tintColor = .thirdColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.thirdColor]
    }
    func configure() {
        let detailAnnoucementView = DetailAnnoucementView(frame: self.view.frame)
        detailAnnoucementView.annoucement = annoucement
        self.view = detailAnnoucementView
    }
}
