//
//  PokemonDetail.swift
//  PokedexApr16
//
//  Created by Donald Dang on 2022-04-17.
//

import Foundation

class PokemonDetail{
    
    private struct Returned: Codable{
        var height: Double
        var weight: Double
        var sprites: Sprites
    }
    
    private struct Sprites: Codable{
        var front_default: String
    }
    
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    var urlString = ""
    
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
                self.height = decodedData.height
                self.weight = decodedData.weight
                self.imageURL = decodedData.sprites.front_default
            } catch {
                print("There was an error decoding the JSON! Check your structs to ensure proper formatting.")
            }
            
            completed()
        }.resume()
    }
}
