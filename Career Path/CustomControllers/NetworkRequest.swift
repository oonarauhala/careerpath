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
    
    func fetchGetUsers(completion: @escaping ((AnyObject) -> Void)){
        
        let urlString: String = "http://localhost:3000/users"
        
        guard let url = URL(string: urlString) else {
            print("Error: URL not created")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let dataResponse = data else {
                print("Error: No data received")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [[String: Any]]
                    else {
                        print("problem in json serialization")
                        return
                }
                print("json is: " + json.description)
                for obj in json {
                    //let value2 = String(describing: value)
                    if let a = obj["username"] {
                        print(String(describing: a) + "  ")
                    }
                    
                    // access all key / value pairs in dictionary
                }
            }
            catch {
                print("catch in fetchgetuser")
            }
            
            }
            .resume()
        
    }
    
    func fetchPostUser(userID: String, firstname: String, lastname: String, age: Int) -> Void {
        
        let urlString: String = "http://localhost:3000/users/" + userID
        
        guard let url = URL(string: urlString) else {
            print("Error: URL not created")
            return
        }
        
        var request = URLRequest(url: url)
        
        
        let user = User(firstname, lastname, age)
        
        guard let uploadData = try? JSONEncoder().encode(user) else {
            print("could not encode user")
            return
        }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
        }
            .resume()
        
    }
}
