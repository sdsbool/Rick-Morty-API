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
    
    let characterViewModel = CharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CharacterCustomCell.self, forCellReuseIdentifier: "CharacterCustomCell")
        setupTableView()
        setupBindings()
        characterViewModel.fetchCharacters(url: "https://rickandmortyapi.com/api/character")
        
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])

    }
    
    
    private func setupBindings(){
        characterViewModel.onDataUpdated = { [weak self] in
            self?.tableView.reloadData()
        }

    }
    
    //TableView
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

}


extension CharacterListView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterViewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCustomCell", for: indexPath) as! CharacterCustomCell
        
        if let character = characterViewModel.character(at: indexPath.row) {
            cell.configure(with: character)
        }
        return cell
    }
}
