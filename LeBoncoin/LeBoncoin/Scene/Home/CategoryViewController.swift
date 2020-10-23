//
//  CategoryViewController.swift
//  LeBoncoin
//
//  Created by dsadaoui on 23/10/2020.
//

import UIKit


class CategoryViewController : UITableViewController {
    
    typealias SelectionHandler = (Category) -> Void

    
    private var items : [Category]
    func displayItems(items: [Category]) {
        self.items = items
        self.tableView.reloadData()
    }
    private let onSelect : SelectionHandler?
    
    init(_ items : [Category], onSelect : SelectionHandler? = nil) {
        self.items = items
        self.onSelect = onSelect
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        onSelect?(items[indexPath.row])
    }
    
}
