//
//  CollectionViewCell.swift
//  PokeFinder
//
//  Created by Alfredo M. on 3/7/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UILabel!
    
    func initCell (pokemon: PokeAnnotation) {
        imageView.image = UIImage(named: "\(pokemon.pokemonNumber)")
        textView.text = pokemon.pokemonName
    }
}
