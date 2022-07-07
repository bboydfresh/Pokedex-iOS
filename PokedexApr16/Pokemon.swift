//
//  Pokemon.swift
//  PokedexApr16
//
//  Created by Donald Dang on 2022-04-16.
//

import Foundation

class Pokemon{
    struct Returned: Codable{
        var count: Double
        var results: [Result]
        var next: String?
        var previous: String?
    }
    
    
    
    var urlString = "https://pokeapi.co/api/v2/pokemon/"
    
    var PokemonArray: [Result] = []
    
    func getData(completed: @escaping () -> ()){
        guard let url = URL(string: urlString) else{
            print("There was an error fetching your URL! Try again.")
            completed()
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error{
                print("There was an error! Try again.")
            }
            
            do{
                let decodedData = try JSONDecoder().decode(Returned.self, from: data!)
                self.PokemonArray = self.PokemonArray + decodedData.results
                self.urlString = decodedData.next ?? ""
                //print(self.PokemonArray)
            } catch {
                print("There was an error decoding the JSON! Check your structs to ensure proper formatting.")
            }
            
            completed()
        }.resume()
    }
}
