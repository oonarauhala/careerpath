//
//  File.swift
//  Career Path
//
//  Created by mikael on 22/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation

struct NetworkRequest {
    
    private enum NetworkError : Error {
        case InvalidURL
    }
    
    func fetchCareers(completion: @escaping (([CareerResponse]) -> Void)) throws {
        let urlString = "http://localhost:3000/careers"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.InvalidURL
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                let careers = try JSONDecoder().decode([CareerResponse].self, from: data)
                completion(careers)
            }
            catch {
                print("Couldn't decode response to CareerResponse")}
            }
            .resume()
    }
}
