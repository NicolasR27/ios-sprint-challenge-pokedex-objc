//
//  PokemonDetailViewController.swift
//  PokedexSprintChallengeObjC
//
//  Created by Nicolas Rios on 6/13/20.
//  Copyright © 2020 Nicolas Rios. All rights reserved.


import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesStackView: UIStackView!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var primaryTypeLabel: UILabel!
    
    @objc dynamic var pokemon: Pokemon?
    @objc dynamic var controller: PokemonController?
    
    var kvoToken: NSKeyValueObservation?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokemon = pokemon else { return }
        updateViews()
        observe(pokemon: pokemon)
        loadPokemonData()
    }
    
    private func updateViews() {
        guard let pokemon = pokemon, let type = pokemon.type else { return }
        nameLabel.text = pokemon.name.capitalized
        primaryTypeLabel.text = "Type: \(type.capitalized)"
        if let id = pokemon.identifier {
            idLabel.text = "ID: \(id)"
        }
        if let abilities = pokemon.abilities as? [String] {
            for ability in abilities {
                let label = UILabel()
                label.text = ability.capitalized
                self.abilitiesStackView.addArrangedSubview(label)
            }
        }
        if let imageData = pokemon.spriteImg {
            let image = UIImage(data: imageData)
            spriteImageView.image = image
        }
        
    }
    
    func observe(pokemon: Pokemon) {
        pokemon.addObserver(self, forKeyPath: "identifier", options: .new, context: nil)
        pokemon.addObserver(self, forKeyPath: "abilities", options: .new, context: nil)
        pokemon.addObserver(self, forKeyPath: "spriteImg", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "identifier", let id = change?[.newKey] as? NSNumber {
            DispatchQueue.main.async {
                self.idLabel.text = "ID: \(id)"
            }
        } else if keyPath == "abilities" {
            if let newAbilities = change?[.newKey] as? [NSString] {
                for ability in newAbilities {
                    DispatchQueue.main.async {
                        let label = UILabel()
                        label.text = ability.capitalized
                        self.abilitiesStackView.addArrangedSubview(label)
                    }
                }
            }
        } else if keyPath == "spriteImg", let data = change?[.newKey] as? Data {
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.spriteImageView.image = image
            }
        }
    }
    
    func loadPokemonData() {
        guard let pokemon = pokemon, let controller = controller else { return }
        
        controller.fillInDetails(for: pokemon)
    }
    
    
    

}
