//
//  ViewController.swift
//  ExpandableTableViewCell
//
//  Created by Türker Alan on 1.01.2023.
//

import UIKit

class Section {
    let name: String
    var isExpand: Bool = false
    let subCategory: [String]
    
    init(name: String, isExpand: Bool = false, subCategory: [String]) {
        self.name = name
        self.isExpand = isExpand
        self.subCategory = subCategory
    }
}

class ViewController: UIViewController {
    private var tableViewDataSource: ExpandableTableViewSource?
    private(set) var tableView: UITableView!
   
    private let data: [Section] = [
        Section(name: "Section 1", subCategory: [1, 2, 3].compactMap({ return "Cell \($0)" })),
        Section(name: "Section 2", subCategory: [1, 2, 3].compactMap({ return "Cell \($0)" })),
        Section(name: "Section 3", subCategory: [1, 2, 3].compactMap({ return "Cell \($0)" })),
        Section(name: "Section 4", subCategory: [1, 2, 3].compactMap({ return "Cell \($0)" })),
    ]
    
    private func setTableView() {
        tableView = {
            let tableView = UITableView()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            return tableView
        }()
        
        view.addSubview(tableView)
        Task(priority: .high)
        {
            await setTableViewDataSource()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDataSource = ExpandableTableViewSource(data: data, vc: self)
        setTableView()
        tableView.frame = view.bounds
    }
    
    internal func setTableViewDataSource() async -> Void{
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
    }

}

