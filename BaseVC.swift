//
//  ViewController.swift
//  PokeBook
//
//  Created by Mbusi Hlatshwayo on 5/10/17.
//  Copyright © 2017 RainbowApps. All rights reserved.
//

import UIKit
import AVFoundation

class BaseVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pokemonArray = [Pokemon]()
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        parseCSV()
        initAudio()
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            sender.alpha = 0.8
        } else {
            audioPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCollectionViewCell{
            let pokemon = pokemonArray[indexPath.row]
            cell.configCell(pokemon)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
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
            print(rows)
            
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
    
}

