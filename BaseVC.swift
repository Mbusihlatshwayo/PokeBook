//
//  ViewController.swift
//  PokeBook
//
//  Created by Mbusi Hlatshwayo on 5/10/17.
//  Copyright © 2017 RainbowApps. All rights reserved.
//

import UIKit
import AVFoundation

class BaseVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pokemonArray = [Pokemon]()
    var filterdPokemonArray = [Pokemon]()
    var audioPlayer: AVAudioPlayer!
    var inSearchMode = false
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.returnKeyType = UIReturnKeyType.done
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        parseCSV()
        initAudio()
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            sender.alpha = 0.8
        } else {
//            audioPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
//            audioPlayer.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCollectionViewCell{
            let pokemon : Pokemon
            if inSearchMode {
                pokemon = filterdPokemonArray[indexPath.row]
                cell.configCell(pokemon)
            } else {
                pokemon = pokemonArray[indexPath.row]
                cell.configCell(pokemon)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        if inSearchMode {
            poke = filterdPokemonArray[indexPath.row]
        } else {
            poke = pokemonArray[indexPath.row]
        }
        performSegue(withIdentifier: "testSegue", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filterdPokemonArray.count
        } else {
            return pokemonArray.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func parseCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokeID: pokeID)
                pokemonArray.append(poke)
                
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
            self.view.endEditing(true)
        } else {
            inSearchMode = true
            let lowerCase = searchBar.text!.lowercased()
            filterdPokemonArray = pokemonArray.filter( { $0.name.range(of: lowerCase) != nil } )
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "testSegue" {
            if let detailController = segue.destination as? DetailVC {
                if let poke = sender as? Pokemon {
                    detailController.pokemon = poke
                }
            }
        }
    }
    
}

