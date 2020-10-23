//
//  ShowDetailAnnoucement.swift
//  LeBoncoin
//
//  Created by dsadaoui on 22/10/2020.
//

import UIKit

class DetailAnnoucementViewController: UIViewController {
    var annoucement: Announcement
    
    init(annoucement: Announcement) {
        self.annoucement = annoucement
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}
