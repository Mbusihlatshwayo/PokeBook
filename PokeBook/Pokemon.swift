//
//  Pokemon.swift
//  PokeBook
//
//  Created by Mbusi Hlatshwayo on 5/10/17.
//  Copyright © 2017 RainbowApps. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokebookID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolution: String!
    
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
