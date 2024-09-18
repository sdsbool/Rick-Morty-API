//
//  CharacterCustomCell.swift
//  Rick&Morty-API
//
//  Created by Usuario on 19/8/24.
//  Copyright © 2024 casa. All rights reserved.
//

import UIKit

class CharacterCustomCell: UITableViewCell {
    
    //Creacion de vistas según necesidad
    public var imageCharacterView: UIImageView = {
        let imageCharacter = UIImageView()
        imageCharacter.contentMode = .scaleAspectFit
        imageCharacter.translatesAutoresizingMaskIntoConstraints = false
        
        return imageCharacter
    }()
    
    public var nameCharacterLabel : UILabel = {
        let nameCharacter = UILabel()
        nameCharacter.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameCharacter.translatesAutoresizingMaskIntoConstraints = false
        
        return nameCharacter
    }()
    
    public var locationCharacterLabel : UILabel = {
        let locationCharacter = UILabel()
        locationCharacter.font = UIFont.systemFont(ofSize: 16, weight: .light)
        locationCharacter.translatesAutoresizingMaskIntoConstraints = false
        
        return locationCharacter
    }()
    
    lazy public var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(nameCharacterLabel)
        stackView.addArrangedSubview(locationCharacterLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCustomCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  /*  func configure(with character: Character) {
        nameCharacterLabel.text = character.name
        locationCharacterLabel.text = character.location.name
        
        if let url = URL(string: character.image) {
            loadImage(from: url)
        }
    }
 
 */
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url)
    }
    
    func setupCustomCell() {
        addSubview(imageCharacterView)
        addSubview(stackView)
        configureConstraints()
    }
    
    //Configuracion de Constraints
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            //imageCharacterView Constraints
            imageCharacterView.widthAnchor.constraint(equalToConstant: 60),
            imageCharacterView.heightAnchor.constraint(equalToConstant: 60),
            imageCharacterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageCharacterView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageCharacterView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            //stackView Constraints
            stackView.leadingAnchor.constraint(equalTo: imageCharacterView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            ])
    }
    
 
    
    func configure(with character: Character) {
        nameCharacterLabel.text = character.name
        locationCharacterLabel.text = character.location.name
        
        imageCharacterView.image = nil
        
        // Cargo la imagen desde la URL
        if let url = URL(string: character.image) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                // Manejo de errores
                if let error = error {
                    print("Error in image: \(error)")
                    return
                }
                // Verifico si se recibieron datos y convierto a imagen
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageCharacterView.image = image
                    }
                }
            }
            task.resume()
            
        }
    }
}

