//
//  PokemonSelectorVC.swift
//  PokeFinder
//
//  Created by Alfredo M. on 3/7/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit

protocol ReturnDataProtocol: class {
    func sendDataToPreviousVC(pokemon: PokeAnnotation)
}

class PokemonSelectorVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemonArray: [PokeAnnotation] = []
    var sortedPokemonArray = [PokeAnnotation]()
    var inSearchMode = false
    
    
    weak var returnDataProtocol: ReturnDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        
        for i in 1...151 {
            pokemonArray.append(PokeAnnotation(pokemonNumber: i))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell{
            if inSearchMode {
                cell.initCell(pokemon: sortedPokemonArray[indexPath.row])
            }else {
                cell.initCell(pokemon: pokemonArray[indexPath.row])
            }
            return cell
        }
        return CollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return sortedPokemonArray.count
        }
        return pokemonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        returnDataProtocol?.sendDataToPreviousVC(pokemon: pokemonArray[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
        }else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            sortedPokemonArray = pokemonArray.filter({$0.pokemonName.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }
}
