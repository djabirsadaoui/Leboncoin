//
//  AnnoucementViewController.swift
//  LeBoncoin
//
//  Created by dsadaoui on 22/10/2020.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: Vars
    var viewModel: HomeViewModelProtocol = HomeViewModel(apifetcher: APIFetcher.shared)
    let annoucementsTableView = UITableView()
    let activityIndicator = UIActivityIndicatorView()
    let headerView = UIView()
    let categoryButton = ButtonWithImage(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
    lazy var categoryViewController: CategoryViewController = CategoryViewController(self.viewModel.categories.value, onSelect: { (category) in
        self.categoryButton.title = category.name
        self.viewModel.filter = category
    })
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
    
    //MARK: Initializer
    init() {
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
        self.bindViewModel()
    }
    
    //MARK: setup the view
    func setUpNavigation() {
        navigationItem.title = "Annoucements"
        self.navigationController?.navigationBar.barTintColor = UIColor.secondColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.thirdColor]
    }
    func configure() {
        view.addSubview(annoucementsTableView)
        view.addSubview(activityIndicator)
        headerView.addSubview(categoryButton)
        view.addSubview(headerView)
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.image = UIImage(named: "down_arrow")
        categoryButton.title = viewModel.categories.value.first?.name ?? "Categories"
        categoryButton.action = {
            self.displayPopoverView()
        }
        //Add constraints
        categoryButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        categoryButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        headerView.backgroundColor = UIColor.thirdColor
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        activityIndicator.tintColor = UIColor.secondColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        annoucementsTableView.dataSource = self
        annoucementsTableView.delegate = self
        annoucementsTableView.rowHeight  = 140
        annoucementsTableView.translatesAutoresizingMaskIntoConstraints = false
        annoucementsTableView.topAnchor.constraint(equalTo:headerView.bottomAnchor).isActive = true
        annoucementsTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        annoucementsTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        annoucementsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        annoucementsTableView.register(AnnoucementCellView.self, forCellReuseIdentifier: AnnoucementCellView.identifier)
        
    }
    
    //MARK: Handling the popover
    func displayPopoverView() {
        categoryViewController.modalPresentationStyle = .popover
        categoryViewController.preferredContentSize = CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.7)
        
        if let pres = categoryViewController.presentationController {
            pres.delegate = self
        }
        if let popover = categoryViewController.popoverPresentationController {
            popover.sourceView = self.categoryButton
            popover.sourceRect = self.categoryButton.bounds
            popover.permittedArrowDirections = [.up, .down]
        }
        self.present(categoryViewController, animated: true, completion: nil)
    }
    
    //MARK: Biding data with viewModel
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
        viewModel.getAnnoucements()
        self.isLoading = true
    }
}

// MARK: Handling data source
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

// MARK: Handling tableview delegate
extension HomeViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < viewModel.items.value.count {
            let viewController = DetailAnnoucementViewController(annoucement: viewModel.items.value[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension HomeViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

