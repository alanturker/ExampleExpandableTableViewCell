//
//  ExpandableCollectionViewSource.swift
//  ExpandableTableViewCell
//
//  Created by Türker Alan on 1.01.2023.
//

import UIKit

final class ExpandableTableViewSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var data: [Section]
    private var vc: ViewController
    
    init(data: [Section], vc: ViewController ) {
        self.data = data
        self.vc = vc
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = data[section]
        if section.isExpand {
            return section.subCategory.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else { return UITableViewCell()}
        if indexPath.row == 0 {
            cell.textLabel?.text = data[indexPath.section].name
            cell.backgroundColor = .systemBlue
        } else {
            cell.textLabel?.text = data[indexPath.section].subCategory[indexPath.row - 1]
            cell.backgroundColor = .systemRed
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            data[indexPath.section].isExpand.toggle()
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            print("tapped cell")
        }
       
    }
}
