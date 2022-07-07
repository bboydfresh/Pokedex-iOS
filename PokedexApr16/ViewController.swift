//
//  ViewController.swift
//  PokedexApr16
//
//  Created by Donald Dang on 2022-04-16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var activityIndicator = UIActivityIndicatorView()
    var pokemon = Pokemon()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        pokemon.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"{
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.pokemon = pokemon.PokemonArray[selectedIndexPath.row]
        }
    }
    
    
    
    func loadAll(){
        if pokemon.urlString.hasPrefix("http"){
            pokemon.getData {
                DispatchQueue.main.async {
                    //self.navigationItem.title = "\(self.pokemon.PokemonArray.count) of \(self.pokemon.count)"
                    self.tableView.reloadData()
                }
                self.loadAll()
            }
        } else{
            print("Done.")
            
        }
    }

    @IBAction func loadAllButtonPressed(_ sender: Any) {
        loadAll()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(pokemon.PokemonArray.count)
        return pokemon.PokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pokemon.PokemonArray[indexPath.row].name
        if indexPath.row == pokemon.PokemonArray.count - 1 && pokemon.urlString.hasPrefix("http"){
            pokemon.getData {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return cell
    }
    
    
}

