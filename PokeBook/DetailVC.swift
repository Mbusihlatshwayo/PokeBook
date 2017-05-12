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
    var pokemon: Pokemon!
    
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}
