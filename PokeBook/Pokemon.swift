//
//  Pokemon.swift
//  PokeBook
//
//  Created by Mbusi Hlatshwayo on 5/10/17.
//  Copyright © 2017 RainbowApps. All rights reserved.
//

import Foundation

class Pokemon {
    
    var _name: String!
    var _pokebookID: Int!
    
    var name: String {
        return _name
    }
    var pokebookID: Int {
        return _pokebookID
    }
    
    init(name: String, pokeID: Int) {
        self._name = name
        self._pokebookID = pokeID
    }
}
