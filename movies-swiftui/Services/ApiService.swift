//
//  ApiService.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation

class ApiService {
  
  private static let baseUrl = "https://api.themoviedb.org/3/"
  
  func fetch<T: Decodable>(endpoint: String, type: T.Type, completion: @escaping (T?, Error?) -> ()) {
    let fullUrl = ApiService.baseUrl + endpoint + "?api_key=" + Secrets.apiKey
    guard let url = URL(string: fullUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
      if err != nil {
        completion(nil, err)
        return
      }
      
      guard let data = data else { return }
      
      do {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let searchResults = try jsonDecoder.decode(T.self, from: data)
        completion(searchResults, nil)
      } catch let jsonErr {
        completion(nil, jsonErr)
      }
      }.resume()
    
  }
  
}
