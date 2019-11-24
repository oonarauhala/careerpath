//
//  File.swift
//  Career Path
//
//  Created by iosdev on 22/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation

struct NetworkRequest {
    func fetchCareers(completion: @escaping (([CareerResponse]) -> Void)) {
        let urlString = "http://localhost:3000/careers"
        
        guard let url = URL(string: urlString) else {
            print("The request URL did not respond")
            return
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
