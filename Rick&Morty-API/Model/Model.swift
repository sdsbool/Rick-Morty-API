//
//  Model.swift
//  Rick&Morty-API
//
//  Created by Usuario on 19/8/24.
//  Copyright © 2024 casa. All rights reserved.
//

import Foundation

struct CharacterResponse: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let next: String
}

struct Character: Decodable {
    let name: String
    let image: String
    let location: Location
}

struct Location: Decodable {
    let name: String
}
