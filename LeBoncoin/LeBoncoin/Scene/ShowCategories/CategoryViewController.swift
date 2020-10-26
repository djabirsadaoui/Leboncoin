//
//  CategoryViewController.swift
//  LeBoncoin
//
//  Created by dsadaoui on 23/10/2020.
//

import UIKit


class CategoryViewController : UITableViewController {
    // MARK: Vars
    typealias SelectionHandler = (Category) -> Void
    private var items : [Category]
    private let onSelect : SelectionHandler?
    
    //MARK: Initializer
    init(_ items : [Category], onSelect : SelectionHandler? = nil) {
        self.items = items
        self.onSelect = onSelect
        super.init(style: .plain)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .thirdColor
        self.tableView.separatorColor = .secondColor
        self.tableView.separatorInset = UIEdgeInsets.zero
    }
    // MARK: Functions
    func displayItems(items: [Category]) {
        self.items = items
        self.tableView.reloadData()
    }
    
    //MARK: Handling data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .thirdColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    //MARK: Handling tableView delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        onSelect?(items[indexPath.row])
    }
    
}
