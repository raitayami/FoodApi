//
//  DataService.swift
//  FoodAPI
//
//  Created by Tayami Rai on 07/12/2023.
//

import Foundation

struct DataService {
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func getData() async -> [Food]{


        guard apiKey != nil else {
            return [Food]()
        }

        if let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch"){

            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("\(apiKey ?? "error")", forHTTPHeaderField: "x-api-key")

            do{
                let (data, _) = try await URLSession.shared.data(for: request)

                let decoder = JSONDecoder()
                let result = try decoder.decode(Search.self, from: data)

                return result.results
            }
            catch{
                print(error)
            }
        }

        return [Food]()

    }

    func getCalorieData() async -> [CalorieResponse]{
        
        guard apiKey != nil else {
            return [CalorieResponse]()
        }
        
        if let url = URL(string: "https://api.spoonacular.com/recipes/findByNutrients?minCalories=1000&maxCalories=1036"){
            
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("\(apiKey ?? "error")", forHTTPHeaderField: "x-api-key")

            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                let result = try decoder.decode([CalorieResponse].self, from: data)

                print(result)
                
                return result
            }
            catch{
                print("This is getting printed-")
                print(error)
            }
        }
        return [CalorieResponse]()
    }
}


