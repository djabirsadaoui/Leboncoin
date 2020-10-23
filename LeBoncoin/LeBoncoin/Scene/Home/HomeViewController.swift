//
//  AnnoucementViewController.swift
//  LeBoncoin
//
//  Created by dsadaoui on 22/10/2020.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var viewModel: HomeViewModelProtocol = HomeViewModel(apifetcher: APIFetcher.shared)
    let annoucementsTableView = UITableView()
    let activityIndicator = UIActivityIndicatorView()
    let headerView = UIView()
    
    lazy var categoryViewController: CategoryViewController = CategoryViewController(self.viewModel.categories.value, onSelect: { (category) in
        self.viewModel.setFilter(for: category)
    })
    let categoryButton = ButtonWithImage(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            } else {
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigation()
        self.configure()
        self.bindViewModel()
    }
    
    func setUpNavigation() {
        navigationItem.title = "Annoucements"
        self.navigationController?.navigationBar.barTintColor = UIColor.secondColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.thirdColor]
    }
    
    func configure() {
        self.view.addSubview(annoucementsTableView)
        self.view.addSubview(activityIndicator)
        self.headerView.addSubview(categoryButton)
        self.view.addSubview(headerView)
        
        self.categoryButton.translatesAutoresizingMaskIntoConstraints = false
        self.categoryButton.image = UIImage(named: "down_arrow")
        self.categoryButton.title = "Categories"
        self.categoryButton.titleColor = .secondColor
        self.categoryButton.action = {
            self.displayPopoverView()
        }
        
        self.categoryButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        self.categoryButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.headerView.backgroundColor = UIColor.thirdColor
        
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.activityIndicator.tintColor = UIColor.secondColor
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.annoucementsTableView.dataSource = self
        self.annoucementsTableView.delegate = self
        self.annoucementsTableView.rowHeight  = 140
        self.annoucementsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.annoucementsTableView.topAnchor.constraint(equalTo:headerView.bottomAnchor).isActive = true
        self.annoucementsTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.annoucementsTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.annoucementsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.annoucementsTableView.register(AnnoucementCellView.self, forCellReuseIdentifier: AnnoucementCellView.identifier)
        
    }
    func displayPopoverView() {
        
        categoryViewController.modalPresentationStyle = .popover
        categoryViewController.preferredContentSize = CGSize(width: 150, height: 200)
        if let popover = categoryViewController.popoverPresentationController {
            popover.sourceView = self.categoryButton
            popover.sourceRect = self.categoryButton.bounds
            popover.permittedArrowDirections = [.up, .down]
        }
        self.present(categoryViewController, animated: true, completion: nil)
    }
    func bindViewModel() {
        viewModel.items.bind { (annoucements) in
                self.isLoading = false
                self.annoucementsTableView.reloadData()
        }
        viewModel.categories.bind { (categories) in
            self.categoryViewController.displayItems(items: categories)
        }
        viewModel.errorMessage.bind { (error) in
            // TODO
        }
        viewModel.getCategories()
        viewModel.getAnnoucements()
        self.isLoading = true
    }
}
// MARK: Handling Data Source
extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnnoucementCellView.identifier, for: indexPath) as? AnnoucementCellView
        guard let finalCell = cell else {
            return UITableViewCell()
        }
        finalCell.layer.shadowOffset = CGSize(width: 0, height: 1)
        finalCell.layer.shadowColor = UIColor.thirdColor.cgColor
        finalCell.layer.shadowOpacity = 0.3
        finalCell.layer.shadowRadius = 4
        finalCell.annoucement = viewModel.items.value[indexPath.row]
        return finalCell
    }
}

// MARK: Handling Table View
extension HomeViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO check index
        let viewController = DetailAnnoucementViewController( annoucement: viewModel.items.value[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

