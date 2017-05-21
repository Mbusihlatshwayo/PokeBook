//
//  DetailVC.swift
//  PokeBook
//
//  Created by Mbusi Hlatshwayo on 5/11/17.
//  Copyright © 2017 RainbowApps. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var mainPokeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var navLabel: UILabel!
    @IBOutlet weak var evolution2Image: UIImageView!
    @IBOutlet weak var evolution1Image: UIImageView!
    var pokemon: Pokemon!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        segControl.isHidden = true
        navLabel.text = pokemon.name.capitalized
        evolution1Image.image = UIImage(named: "\(pokemon.pokebookID)")
        pokemon.downloadDetails {
            self.updateUI()
            print("poke info = \(self.pokemon.weight)")
        }
        
    }
    
    func updateUI() {
        mainPokeImage.image = UIImage(named: "\(pokemon.pokebookID)")
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        defenseLabel.text = pokemon.defense
        idLabel.text = "\(pokemon.pokebookID)"
        baseAttackLabel.text = pokemon.attack
        
        if pokemon.nextEvolutionId == "" {
            nextEvolutionLabel.text = "No evolutions"
            evolution1Image.image = UIImage(named: "\(pokemon.pokebookID)")
            evolution2Image.isHidden = true
        } else {
            evolution2Image.isHidden = false
            evolution1Image.image = UIImage(named: "\(pokemon.pokebookID)")
            evolution2Image.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            let evoString = "Next Evolution: \(pokemon.nextEvolutionName) - LVL\(pokemon.nextEvolutionLevel)"
            nextEvolutionLabel.text = evoString
        }
        
    }

}
