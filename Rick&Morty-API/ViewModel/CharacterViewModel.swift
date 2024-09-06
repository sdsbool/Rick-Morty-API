//
//  CharacterViewModel.swift
//  Rick&Morty-API
//
//  Created by Usuario on 26/8/24.
//  Copyright © 2024 casa. All rights reserved.
//

import Foundation

class CharacterViewModel {
    
    public var characters: [Character] = []
    private var nextPageURL: String?
    private var isLoading = false {
        didSet {
            onLoadingStateChanged?(isLoading)
        }
    }
    
    
    var onDataUpdated: (() -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    
    
    func fetchCharacters(url: String){
        
        //si "isLoading" es "true" sale del metodo para evitar iniciar una nueva solicitud
        guard !isLoading else { return }
        isLoading = true
        onLoadingStateChanged?(true)
        
        
        guard let url = URL(string: url) else {
            isLoading = false
            onLoadingStateChanged?(false)
            return
        }
        
        //revisar código
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.isLoading = false
                self.onLoadingStateChanged?(false)
                return
            }
            
            do {
                let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                self.characters.append(contentsOf: characterResponse.results) //agrego nuevos personajes
                self.nextPageURL = characterResponse.info.next
                DispatchQueue.main.async {
                    self.onDataUpdated!()
                    self.isLoading = false
                }
            } catch {
                print("Error data: \(error)")
                self.isLoading = false
            }
        }
        task.resume()
    }
    
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    func character(at index: Int) -> Character? {
        guard index >= 0 && index < characters.count else { return nil }
        return characters[index]
    }
    
// funcion para cargar más páginas si aún no se terminaron de listar todos los personajes
    func loadNextPage(currentIndex: Int) {
        if currentIndex == characters.count - 1, let nextPage = nextPageURL{
            fetchCharacters(url: nextPage)
        }
    }
}
