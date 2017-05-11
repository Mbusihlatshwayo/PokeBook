//
//  PokeCollectionViewCell.swift
//  PokeBook
//
//  Created by Mbusi Hlatshwayo on 5/10/17.
//  Copyright © 2017 RainbowApps. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeLabel: UILabel!
    var pokemon: Pokemon!
    
    // rounded edges
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    
    func configCell(_ poke: Pokemon) {
        self.pokemon = poke
        pokeImage.image = UIImage(named: "\(self.pokemon.pokebookID)")
        pokeLabel.text = self.pokemon._name.capitalized
    }
    

}
