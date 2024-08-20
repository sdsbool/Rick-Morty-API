//
//  CharacterListView.swift
//  Rick&Morty-API
//
//  Created by Usuario on 19/8/24.
//  Copyright © 2024 casa. All rights reserved.
//

import Foundation
import UIKit

class CharacterListView: UIViewController {
    
    //TableView
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
}

extension CharacterListView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CharacterCustomCell.self)", for: indexPath) as? CharacterCustomCell else {
            return UITableViewCell()
        }
        return cell
    }
}
