//
//  DetailViewController.swift
//  PokedexApr16
//
//  Created by Donald Dang on 2022-04-16.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    var pokemon: Result!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonLabel.text = pokemon.name
        
        let pokemonDetail = PokemonDetail()
        pokemonDetail.urlString = pokemon.url
        pokemonDetail.getData {
            DispatchQueue.main.async {
                self.weightLabel.text = "\(pokemonDetail.weight)"
                self.heightLabel.text = "\(pokemonDetail.height)"
                guard let url = URL(string: pokemonDetail.imageURL) else {return}
                do{
                    let data = try Data(contentsOf: url)
                    self.imageLabel.image = UIImage(data: data)
                } catch{
                    print("ERROR! Cannot get image from URL!")
                }
            }
        }
        

    }
    

    

}
