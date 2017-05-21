//
//  Pokemon.swift
//  PokeBook
//
//  Created by Mbusi Hlatshwayo on 5/10/17.
//  Copyright © 2017 RainbowApps. All rights reserved.
//

import Foundation
import Alamofire

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
    private var _pokemonURL: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    var name: String {
        return _name
    }
    var pokebookID: Int {
        return _pokebookID
    }
    
    var nextEvolution: String {
        if _nextEvolution == nil {
            return "none"
        } else {
            return _nextEvolution
        }
    }
    
    var attack: String {
        if _attack == nil {
            return "none"
        } else {
            return _attack
        }
    }
    
    var weight: String {
        if _weight == nil {
            return "none"
        } else {
            return _weight
        }
    }
    
    var height: String {
        if _height == nil {
            return "none"
        } else {
            return _height
        }
    }
    
    var defense: String {
        if _defense == nil {
            return "none"
        } else {
            return _defense
        }
    }
    
    var type: String {
        if _type == nil {
            return "none"
        } else {
            return _type
        }
    }
    
    var description: String {
        if _description == nil {
            return "none"
        } else {
            return _description
        }
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            return ""
        } else {
            return _nextEvolutionLevel
        }
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            return ""
        } else {
            return _nextEvolutionName
        }
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            return ""
        } else {
            return _nextEvolutionId
        }
    }
    
    init(name: String, pokeID: Int) {
        self._name = name
        self._pokebookID = pokeID
        self._pokemonURL = "\(BASE_URL)\(POKE_URL)\(self._pokebookID!)/"
    }
    
    func downloadDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL!).responseJSON { response in
            print("POKEMON URL = \(self._pokemonURL!)")
            let result = response.result
            let resultDictionary = result.value as? Dictionary<String, AnyObject>
            if let weight = resultDictionary?["weight"] as? String {
                self._weight = weight
            }
            if let height = resultDictionary?["height"] as? String {
                self._height = height
            }
            if let attack = resultDictionary?["attack"] as? Int {
                self._attack = "\(attack)"
            }
            if let defense = resultDictionary?["defense"] as? Int {
                self._defense = "\(defense)"
            }
            if let types = resultDictionary?["types"] as? [Dictionary<String, String>], types.count > 0 {
                
                if let name = types[0]["name"] {
                    self._type = name.capitalized
                }
                if types.count > 1 {
                    for q in 1..<types.count {
                        if let name = types[q]["name"] {
                            self._type = self._type + ", \(name.capitalized)"
                        }
                        
                    }
                }
            }
            
            if let descriptionArr = resultDictionary?["descriptions"] as? [Dictionary<String,AnyObject>], descriptionArr.count>0 {
                if let url = descriptionArr[0]["resource_uri"] {
                    let descriptionURL = "\(BASE_URL)\(url)"
                    Alamofire.request(descriptionURL).responseJSON(completionHandler: { (response) in
                        if let descriptionDict = response.result.value as? Dictionary<String,AnyObject> {
                            if let description = descriptionDict["description"] as? String {
                                let newDescription = description.replacingOccurrences(of: "POKEMON", with: "Pokemon")
                                self._description = newDescription
                                print("ODJFKSLAF = \(newDescription)")
                            }
                        }
                        completed()
                    })
                }
            } else {
                self._description = "not found"
            }
            
            
            if let evolutionArr = resultDictionary?["evolutions"] as? [Dictionary<String, AnyObject>] , evolutionArr.count > 0 {
                if let nextEvolution = evolutionArr[0]["to"] as? String {
                    if nextEvolution.range(of: "mega") == nil {
                        self._nextEvolutionName = nextEvolution
                        if let uri = evolutionArr[0]["resource_uri"] as? String {
                            let newUri = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                            let nextEvolutionId = newUri.replacingOccurrences(of: "/", with: "")
                            self._nextEvolutionId = nextEvolutionId
                            if let lvlExist = evolutionArr[0]["level"] {
                                if let lvl = lvlExist as? Int {
                                     self._nextEvolutionLevel = "\(lvl)"
                                }
                            } else {
                                self._nextEvolutionLevel = "not found"
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
    
}
